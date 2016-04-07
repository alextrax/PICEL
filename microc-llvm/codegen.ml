(* Code generation: translate takes a semantically checked AST and
produces LLVM IR

LLVM tutorial: Make sure to read the OCaml version of the tutorial

http://llvm.org/docs/tutorial/index.html

Detailed documentation on the OCaml LLVM library:

http://llvm.moe/
http://llvm.moe/ocaml/

*)

module L = Llvm
module A = Ast

module StringMap = Map.Make(String)
let named_values:(string, L.llvalue) Hashtbl.t = Hashtbl.create 50
exception Error of string

let translate program =
  let rec transform p v f=
	match p with
	a::b -> (match a with
		 A.Vdecl(x)-> transform b (x::v) f
		 | A.Fdecl(x)-> transform b v (x::f))
	| []-> (v,f)
	in
	let (globals, functions) = transform program [] [] in
	let rec transform_globals g r =
	match g with
	a::b ->(match a with
		 A.Bind(x) -> transform_globals b (x::r)
		| _ -> transform_globals b r
		)
	| [] -> r
	in let globals= transform_globals globals [] in
  let context = L.global_context () in
  let the_module = L.create_module context "MicroC"
  and i32_t  = L.i32_type  context
  and i8_t   = L.i8_type   context
  and i1_t   = L.i1_type   context
  and void_t = L.void_type context in

  let ltype_of_typ = function
      A.Int -> i32_t
    | A.Bool -> i1_t
    | A.Void -> void_t
    | _ -> i32_t in

  (* Declare each global variable; remember its value in a map *)
  let global_vars =
    let global_var m (t, n) = 
      (*let init = L.const_int (ltype_of_typ t) 0
      in StringMap.add n (L.define_global n init the_module) m *)
      match t with 
      A.Array(typ, len) -> 
        let ainit = L.const_array (ltype_of_typ typ) (Array.make len ( L.const_int (ltype_of_typ typ) 0)) in
        StringMap.add n (L.define_global n ainit the_module) m;
      | _ -> let init = L.const_int (ltype_of_typ t) 0
      in StringMap.add n (L.define_global n init the_module) m
      (*let leni = L.const_int (ltype_of_typ A.Int) len 
        in L.build_array_malloc (ltype_of_typ typ) leni n builder
      |*)
    in
    List.fold_left global_var StringMap.empty globals in

  (* Declare printf(), which the print built-in function will call *)
  let printf_t = L.var_arg_function_type i32_t [| L.pointer_type i8_t |] in
  let printf_func = L.declare_function "printf" printf_t the_module in

  (* Declare ext_foo(), which the ext_foo built-in function will call *)
  let ext_foo_t = L.var_arg_function_type i32_t [| L.pointer_type i8_t |] in
  let ext_foo_func = L.declare_function "get_width" ext_foo_t the_module in
  let ext_foo_t = L.var_arg_function_type i32_t [| L.pointer_type i8_t |] in
  let ext_foo_func = L.declare_function "get_height" ext_foo_t the_module in

  (* Define each function (arguments and return type) so we can call it *)
  let function_decls =
    let function_decl m fdecl =
      let name = fdecl.A.fname
      and formal_types =
	Array.of_list (List.map (fun (t,_) -> ltype_of_typ t) fdecl.A.formals)
      in let ftype = L.function_type (ltype_of_typ fdecl.A.typ) formal_types in
      StringMap.add name (L.define_function name ftype the_module, fdecl) m in
    List.fold_left function_decl StringMap.empty functions in
  
  (* Fill in the body of the given function *)
  let build_function_body fdecl =
    Hashtbl.clear named_values;
    let (the_function, _) = StringMap.find fdecl.A.fname function_decls in
    let builder = L.builder_at_end context (L.entry_block the_function) in

    let int_format_str = L.build_global_stringptr "%d\n" "fmti" builder in
    let str_format_str = L.build_global_stringptr "%s\n" "fmts" builder in
    (* Construct the function's "locals": formal arguments and locally
       declared variables.  Allocate each on the stack, initialize their
       value, if appropriate, and remember their values in the "locals" map *)
    let start_formal:(string, L.llvalue) Hashtbl.t=Hashtbl.create 50 in
(*    let local_vars =*)
      let add_formal m (t, n) p = L.set_value_name n p;
	let local = L.build_alloca (ltype_of_typ t) n builder in
	ignore (L.build_store p local builder);
	Hashtbl.add start_formal n local; m in
	List.fold_left2 add_formal start_formal fdecl.A.formals (Array.to_list (L.params the_function)) ;
(*	
      let add_local m (t, n) =
	let local_var = L.build_alloca (ltype_of_typ t) n builder
	in StringMap.add n local_var m in

      let formals = List.fold_left2 add_formal StringMap.empty fdecl.A.formals
          (Array.to_list (L.params the_function)) in
      List.fold_left add_local formals [] (* fdecl.A.locals *) in*)
    (* Invoke "f builder" if the current block doesn't already
       have a terminal (e.g., a branch). *)
    let add_terminal builder f =
      match L.block_terminator (L.insertion_block builder) with
	Some _ -> ()
      | None -> ignore (f builder) in
	
    (* Build the code for the given statement; return the builder for
       the statement's successor *)
    let rec stmt named_values hashlist builder=
	

    (* Return the value for a variable or formal argument *)
    let lookup n= (*try StringMap.find n local_vars
                 with Not_found -> try StringMap.find n global_vars
                 with Not_found -> raise (Failure ("undeclared variable " ^ n))*)
    let rec lookup2 n h=
	match h with
	a::b -> (try Hashtbl.find a n 
                with  Not_found -> lookup2 n b)
	| [] ->(try StringMap.find n global_vars 
                with  Not_found -> raise (Failure ("undeclared variable " ^ n)))
    in (try Hashtbl.find named_values n
	with Not_found ->lookup2 n hashlist)
    in

    (* Construct code for an expression; return its value *)
    let rec expr builder = function
	A.Literal i -> L.const_int i32_t i
      | A.StringLit s -> L.build_global_stringptr s "tmp" builder 
      | A.BoolLit b -> L.const_int i1_t (if b then 1 else 0)
      | A.Noexpr -> L.const_int i32_t 0
      | A.Id s -> L.build_load (lookup s) s builder
      | A.Getarr (s, e) -> let e' = expr builder e in
                     let arraystar_type = L.pointer_type i32_t in  
                     let cast_pointer = L.build_bitcast (lookup s) arraystar_type "c_ptr" builder in
                     let addr = L.build_in_bounds_gep cast_pointer (Array.make 1 e') "elmt_addr" builder in 
                     L.build_load addr "elmt" builder
      | A.Assignarr (s, e1, e2) -> let e1' = expr builder e1 and e2' = expr builder e2 in
                     let arraystar_type = L.pointer_type i32_t in  
                     let cast_pointer = L.build_bitcast (lookup s) arraystar_type "c_ptr" builder in
                     let addr = L.build_in_bounds_gep cast_pointer (Array.make 1 e1') "elmt_addr" builder in 
                     ignore (L.build_store e2' addr builder); e2'
                     
      | A.Binop (e1, op, e2) ->
	  let e1' = expr builder e1
	  and e2' = expr builder e2 in
	  (match op with
	    A.Add     -> L.build_add
	  | A.Sub     -> L.build_sub
	  | A.Mult    -> L.build_mul
          | A.Div     -> L.build_sdiv
	  | A.And     -> L.build_and
	  | A.Or      -> L.build_or
	  | A.Equal   -> L.build_icmp L.Icmp.Eq
	  | A.Neq     -> L.build_icmp L.Icmp.Ne
	  | A.Less    -> L.build_icmp L.Icmp.Slt
	  | A.Leq     -> L.build_icmp L.Icmp.Sle
	  | A.Greater -> L.build_icmp L.Icmp.Sgt
	  | A.Geq     -> L.build_icmp L.Icmp.Sge
	  ) e1' e2' "tmp" builder
      | A.Unop(op, e) ->
	  let e' = expr builder e in
	  (match op with
	    A.Neg     -> L.build_neg
          | A.Not     -> L.build_not) e' "tmp" builder
      | A.Assign (s, e) -> let e' = expr builder e in
	                   ignore (L.build_store e' (lookup s) builder); e'
      | A.Call ("print", [e]) | A.Call ("printb", [e]) ->
	  L.build_call printf_func [| int_format_str ; (expr builder e) |]
      "printf" builder
      | A.Call ("prints", [e]) ->
    L.build_call printf_func [| str_format_str ; (expr builder e) |]
	    "printf" builder
      | A.Call ("get_width", [e]) ->
    L.build_call ext_foo_func [| (expr builder e) |]
      "get_width" builder
      | A.Call ("get_height", [e]) ->
    L.build_call ext_foo_func [| (expr builder e) |]
      "get_height" builder
      | A.Call (f, act) ->
         let (fdef, fdecl) = StringMap.find f function_decls in
	 let actuals = List.rev (List.map (expr builder) (List.rev act)) in
	 let result = (match fdecl.A.typ with A.Void -> ""
                                            | _ -> f ^ "_result") in
         L.build_call fdef (Array.of_list actuals) result builder
      
    in


 function
	A.Block sl -> handle_block builder (named_values::hashlist) sl
      | A.Expr e -> ignore (expr builder e); builder
      | A.S_bind (t, n) -> (match t with
                          A.Array(atyp, alen) -> let local_arr = L.build_array_alloca (ltype_of_typ atyp) (L.const_int i32_t alen) n builder 
                          (* L.const_array (ltype_of_typ atyp) (Array.make alen ( L.const_int (ltype_of_typ atyp) 0)) *)
                                                in Hashtbl.add named_values n local_arr ; builder
                          | _ -> let local_var = L.build_alloca (ltype_of_typ t) n builder
                                  in Hashtbl.add named_values n local_var ; builder)
      | A.S_init (t, n, p) -> let local_var = L.build_alloca (ltype_of_typ t) n builder
                              in let e' = expr builder p in
                              ignore (L.build_store e' local_var builder);
                              Hashtbl.add named_values n local_var ; builder                  
      | A.Return e -> ignore (match fdecl.A.typ with
	  A.Void -> L.build_ret_void builder
	| _ -> L.build_ret (expr builder e) builder); builder
      | A.If (predicate, then_stmt, else_stmt) ->
         let bool_val = expr builder predicate in
	 let merge_bb = L.append_block context "merge" the_function in

	 let then_bb = L.append_block context "then" the_function in
	 add_terminal (stmt named_values hashlist (L.builder_at_end context then_bb) then_stmt)
	   (L.build_br merge_bb);

	 let else_bb = L.append_block context "else" the_function in
	 add_terminal (stmt named_values hashlist (L.builder_at_end context else_bb)  else_stmt)
	   (L.build_br merge_bb);

	 ignore (L.build_cond_br bool_val then_bb else_bb builder);
	 L.builder_at_end context merge_bb

      | A.While (predicate, body) ->
	  let pred_bb = L.append_block context "while" the_function in
	  ignore (L.build_br pred_bb builder);

	  let body_bb = L.append_block context "while_body" the_function in
	  add_terminal (stmt named_values hashlist (L.builder_at_end context body_bb) body)
	    (L.build_br pred_bb);

	  let pred_builder = L.builder_at_end context pred_bb in
	  let bool_val = expr pred_builder predicate in

	  let merge_bb = L.append_block context "merge" the_function in
	  ignore (L.build_cond_br bool_val body_bb merge_bb pred_builder);
	  L.builder_at_end context merge_bb

      | A.For (e1, e2, e3, body) -> let e'= match e1 with
	A.F_expr(e) -> A.Expr(e)
	| A.F_init(e)-> A.S_init(e) in
	handle_block builder (named_values::hashlist)
	    ( [ e' ; A.While (e2, A.Block [body ; A.Expr e3]) ] )
   and handle_block builder hashlist s=
	
	let new_n:(string, L.llvalue) Hashtbl.t=Hashtbl.create 50 in
     List.fold_left (stmt new_n hashlist) builder s
  in
    (* Build the code for each statement in the function *)
    let builder = stmt start_formal [] builder (A.Block fdecl.A.body) in

    (* Add a return if the last block falls off the end *)
    add_terminal builder (match fdecl.A.typ with
        A.Void -> L.build_ret_void
      | t -> L.build_ret (L.const_int (ltype_of_typ t) 0))
  in

  List.iter build_function_body functions;
  the_module
 
