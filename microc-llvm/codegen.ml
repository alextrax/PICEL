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
let named_values:(string, L.llvalue) Hashtbl.t = Hashtbl.create 100
let type_map:(L.llvalue, A.typ) Hashtbl.t =Hashtbl.create 100
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
  let the_module = L.create_module context "PICEL"
  and i32_t  = L.i32_type  context
  and i8_t   = L.i8_type   context
  and i1_t   = L.i1_type   context
  and void_t = L.void_type context in
  let i8_p = L.pointer_type i8_t in
  let pic_t = L.struct_type context [| i32_t; i32_t; i32_t; i8_p|] in  (* width, height, bytes per pixel, data[] *)
  let pic_p = L.pointer_type pic_t in 
  let mat_t = L.array_type i32_t 25 in
  let mat_p = L.pointer_type mat_t in

  let ltype_of_typ = function
      A.Int -> i32_t
    | A.Bool -> i1_t
    | A.Void -> void_t
    | A.Pic -> pic_t
    | A.Matrix(n,m) -> L.array_type i32_t (n*m)
    | A.Char -> i8_t
    | _ -> i32_t in

  (* Declare each global variable; remember its value in a map *)
  let global_vars =
    let global_var m (t, n) = 
      (*let init = L.const_int (ltype_of_typ t) 0
      in StringMap.add n (L.define_global n init the_module) m *)
      match t with 
      A.Array(typ, len) -> 
        let ainit = L.const_array (ltype_of_typ typ) (Array.make len ( L.const_int (ltype_of_typ typ) 0)) in 
		let addr=(L.define_global n ainit the_module) in
			Hashtbl.add type_map addr t;
        StringMap.add n addr m;
      | A.Pic -> let init_st = L.const_struct context [| (L.const_int i32_t 0); (L.const_int i32_t 0); (L.const_int i32_t 0); (L.const_pointer_null i8_p) |] 
        in let addr = L.define_global n init_st the_module
      in Hashtbl.add type_map addr t; StringMap.add n addr m;
      |A.Matrix(x, y) -> 
        let ainit = L.const_array i32_t (Array.make (x*y) ( L.const_int i32_t 0)) in 
    let addr=(L.define_global n ainit the_module) in
      Hashtbl.add type_map addr t;
        StringMap.add n addr m;  
      | _ -> let init = L.const_int (ltype_of_typ t) 0
      in Hashtbl.add type_map init t; StringMap.add n (L.define_global n init the_module) m; 

      (*let leni = L.const_int (ltype_of_typ A.Int) len 
        in L.build_array_malloc (ltype_of_typ typ) leni n builder
      |*)
    in
    List.fold_left global_var StringMap.empty globals in

  (* Declare printf(), which the print built-in function will call *)
  let printf_t = L.var_arg_function_type i32_t [| L.pointer_type i8_t |] in
  let printf_func = L.declare_function "printf" printf_t the_module in

  (* Declare external funations *)
  let ext_load_t = L.var_arg_function_type pic_t [| L.pointer_type i8_t |] in
  let ext_load_func = L.declare_function "load" ext_load_t the_module in
  let ext_save_t = L.var_arg_function_type i32_t [| pic_p|] in
  let ext_save_func = L.declare_function "save" ext_save_t the_module in
  let ext_save_file_t = L.var_arg_function_type i32_t [|  L.pointer_type i8_t ; pic_p|] in
  let ext_save_file_func = L.declare_function "save_file" ext_save_file_t the_module in
  let ext_newpic_t = L.var_arg_function_type pic_t [| i32_t ; i32_t |] in
  let ext_newpic_func = L.declare_function "newpic" ext_newpic_t the_module in
  (*let ext_conv_t = L.var_arg_function_type i32_t [| pic_t ; (L.array_type i32_t (25)) |] in
  let ext_conv_func = L.declare_function "convolution" ext_conv_t the_module in*)

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
  Hashtbl.add type_map local t; 
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
	
    let get_pic_index elmt =
      match elmt with
       "w" -> 0
      |"h" -> 1
      |"bpp" -> 2
      |"data" -> 3
      | _ -> -1 in 
    let get_RGB_offset elmt =
      match elmt with
       "b" -> 0
      |"g" -> 1
      |"r" -> 2
      | _ -> -1 in   
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
      | A.StringLit s -> L.build_global_stringptr s ("str_" ^ s) builder 
      | A.BoolLit b -> L.const_int i1_t (if b then 1 else 0)
      | A.Noexpr -> L.const_int i32_t 0
      | A.Id s -> L.build_load (lookup s) s builder
      | A.Getarr (s, e) -> let e' = expr builder e in
		     let addr=lookup s in
 	             let typ=Hashtbl.find type_map addr in (
                     match typ with
			               A.Array(t,l) ->
                     let arraystar_type = L.pointer_type (ltype_of_typ t) in 
		     
                     let cast_pointer = L.build_bitcast addr arraystar_type "c_ptr" builder in
                     let addr = L.build_in_bounds_gep cast_pointer (Array.make 1 e') "elmt_addr" builder in 
                     L.build_load addr "elmt" builder
		     |_ -> raise (Failure ("Array type is wrong!")))
      | A.Getmatrix (s, x, y) -> let x' = expr builder x and y' = expr builder y in
         let addr=lookup s in
               
                     let typ=Hashtbl.find type_map addr in (
                     match typ with
      A.Matrix(n,m) ->    (*   (x * m) + y  *)
                     let arraystar_type = L.pointer_type i32_t in 
                     let x_mul_m = L.build_mul x' (L.const_int i32_t m) "x_mul_m" builder in
                     let xm_add_y = L.build_add x_mul_m y' "xm_add_y" builder in
                     let cast_pointer = L.build_bitcast addr arraystar_type "c_ptr" builder in
                     let addr = L.build_in_bounds_gep cast_pointer (Array.make 1 xm_add_y) "elmt_addr" builder in 
                     L.build_load addr "elmt" builder
         |_ -> raise (Failure ("Mat type is wrong: " ^ s)))


      | A.Assignarr (s, e1, e2) -> let e1' = expr builder e1 and e2' = expr builder e2 in
		     let addr=lookup s in
 	             let typ=Hashtbl.find type_map addr in (
                     match typ with
			A.Array(t,l) ->
                     let arraystar_type = L.pointer_type (ltype_of_typ t) in  
                     let cast_pointer = L.build_bitcast addr arraystar_type "c_ptr" builder in
                     let addr = L.build_in_bounds_gep cast_pointer (Array.make 1 e1') "elmt_addr" builder in 
                     ignore (L.build_store e2' addr builder); e2' 
		|_ -> raise (Failure ("Array type is wrong!")))

      | A.Assignmatrix (s, x, y, e) -> let x' = expr builder x and y' = expr builder y and e' = expr builder e in
         let addr=lookup s in
                     let typ=Hashtbl.find type_map addr in (
                     match typ with
      A.Matrix(n,m) ->    (*   (x * m) + y  *)
                     let arraystar_type = L.pointer_type i32_t in 
                     let x_mul_m = L.build_mul x' (L.const_int i32_t m) "x_mul_m" builder in
                     let xm_add_y = L.build_add x_mul_m y' "xm_add_y" builder in
                     let cast_pointer = L.build_bitcast addr arraystar_type "c_ptr" builder in
                     let addr = L.build_in_bounds_gep cast_pointer (Array.make 1 xm_add_y) "elmt_addr" builder in 
                     ignore (L.build_store e' addr builder); e'
         |_ -> raise (Failure ("Array type is wrong!")))    
              
      | A.Getpic (pic, elmt) -> let addr = L.build_struct_gep (lookup pic) (get_pic_index elmt) elmt builder in L.build_load addr elmt builder
      | A.GetRGBXY (pic, elmt, x, y) -> let x' = expr builder x and y' = expr builder y in
                     let waddr = L.build_struct_gep (lookup pic) 0 "tmp_w" builder in let width = L.build_load waddr "tmp_w" builder in
                     let haddr = L.build_struct_gep (lookup pic) 1 "tmp_h" builder in let height = L.build_load haddr "tmp_h" builder in 
                     let bpp_addr = L.build_struct_gep (lookup pic) 2 "tmp_bpp" builder in let bpp = L.build_load bpp_addr "tmp_bpp" builder in
                     let row_increment =  L.build_mul width bpp "row_increment" builder in
                     let y_mul_rincre = L.build_mul y' row_increment "y_mul_rincre" builder in
                     let x_mul_bpp = L.build_mul x' bpp "x_mul_bpp" builder in
                     let x_add_y = L.build_add y_mul_rincre x_mul_bpp "x_add_y" builder in
                     let data_index = L.build_add x_add_y (L.const_int i32_t (get_RGB_offset elmt) ) "data_index" builder in
                     (*let charstar_type = L.pointer_type i8_t in  *)
                     let data_addr = L.build_struct_gep (lookup pic) 3 elmt builder in
                     let data_ptr = L.build_load data_addr "data_ptr" builder in
                     (*let cast_pointer = L.build_bitcast data_ptr charstar_type "c_ptr" builder in*)
                     let addr = L.build_in_bounds_gep data_ptr (Array.make 1 data_index) "rgb_addr" builder in 
                     L.build_load addr "rgb_value" builder

      | A.Assignpic (pic, elmt, e) -> let e' = expr builder e in 
                          let addr = L.build_struct_gep (lookup pic) (get_pic_index elmt) elmt builder in
                          ignore (L.build_store e' addr builder); e'
      | A.AssignRGBXY (pic, elmt, x, y, e) -> let x' = expr builder x and y' = expr builder y and e' = expr builder e in
                     let waddr = L.build_struct_gep (lookup pic) 0 "tmp_w" builder in let width = L.build_load waddr "tmp_w" builder in
                     let haddr = L.build_struct_gep (lookup pic) 1 "tmp_h" builder in let height = L.build_load haddr "tmp_h" builder in 
                     let bpp_addr = L.build_struct_gep (lookup pic) 2 "tmp_bpp" builder in let bpp = L.build_load bpp_addr "tmp_bpp" builder in
                     let row_increment =  L.build_mul width bpp "row_increment" builder in
                     let y_mul_rincre = L.build_mul y' row_increment "y_mul_rincre" builder in
                     let x_mul_bpp = L.build_mul x' bpp "x_mul_bpp" builder in
                     let x_add_y = L.build_add y_mul_rincre x_mul_bpp "x_add_y" builder in
                     let data_index = L.build_add x_add_y (L.const_int i32_t (get_RGB_offset elmt) ) "data_index" builder in
                     (*let charstar_type = L.pointer_type i8_t in  *)
                     let data_addr = L.build_struct_gep (lookup pic) 3 elmt builder in
                     let data_ptr = L.build_load data_addr "data_ptr" builder in
                     (*let cast_pointer = L.build_bitcast data_ptr charstar_type "c_ptr" builder in*)
                     let char_e = L.build_intcast e' i8_t "char_RGB" builder in
                     let addr = L.build_in_bounds_gep data_ptr (Array.make 1 data_index) "rgb_addr" builder in 
                     ignore (L.build_store char_e addr builder); char_e    

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
                      let addr = lookup s in 
                      let typ = (try Hashtbl.find type_map addr with Not_found -> raise (Failure ("find type_map failed " ^ s))) in
                      (match typ with 
                        A.Pic -> ignore (L.build_store e' addr builder); e'
                        | _ -> let cast_value = L.build_intcast e' (ltype_of_typ typ) "casted_value" builder in
                     ignore (L.build_store cast_value addr builder); cast_value
                      )
                      
      | A.Call ("print", [e]) | A.Call ("printb", [e]) ->
	  L.build_call printf_func [| int_format_str ; (expr builder e) |]
      "printf" builder
      | A.Call ("prints", [e]) ->
    L.build_call printf_func [| str_format_str ; (expr builder e) |]
	    "printf" builder
      | A.Call ("load", [e]) ->
    L.build_call ext_load_func [| (expr builder e) |]
      "load" builder
      | A.Call ("save", [e]) ->
        (match e with A.Id s ->
      L.build_call ext_save_func [| (lookup s) |]
      "save" builder)
      | A.Call ("save_file", e) ->
      let a = List.hd e in let b = List.hd (List.tl e) in
        (match b with A.Id s ->
    L.build_call ext_save_file_func [| (expr builder a) ; (lookup s) |]
      "save_file" builder)
      | A.Call ("newpic", e) ->
      let a = List.hd e in let b = List.hd (List.tl e) in
    L.build_call ext_newpic_func [| (expr builder a) ; (expr builder b) |]
      "newpic" builder
      (*| A.Call ("convolution", e) ->
      let a = List.hd e in let b = List.hd (List.tl e) in
    L.build_call ext_conv_func [| (expr builder a) ; (expr builder b) |]
      "convolution" builder*)
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
                                                in Hashtbl.add named_values n local_arr ; Hashtbl.add type_map local_arr t; builder
                          | A.Pic ->  (*let local_st = L.build_malloc pic_t n builder*)
                            let local_st = L.build_alloca pic_t n builder
                            in Hashtbl.add named_values n local_st ; Hashtbl.add type_map local_st t; builder
                          | A.Matrix(x, y) -> 
        let local_mat = L.build_array_alloca i32_t (L.const_int i32_t (x*y)) n builder in 
        Hashtbl.add named_values n local_mat ; Hashtbl.add type_map local_mat t; builder
                          | _ -> let local_var = L.build_alloca (ltype_of_typ t) n builder
                                  in Hashtbl.add named_values n local_var; Hashtbl.add type_map local_var t ; builder)
      | A.S_init (t, n, p) -> let local_var = L.build_alloca (ltype_of_typ t) n builder
                              in let e' = expr builder p in
                              let cast_value = L.build_intcast e' (ltype_of_typ t) "casted_value" builder in
                              ignore (L.build_store cast_value local_var builder);
                              Hashtbl.add named_values n local_var; Hashtbl.add type_map local_var t ; builder                  
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
 
