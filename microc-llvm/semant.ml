(* Semantic checking for the MicroC compiler *)

open Ast

module StringMap = Map.Make(String)
(* module SS = Set.Make(String) *)
(* Semantic checking of a program. Returns void if successful,
   throws an exception if something is wrong.
   Check each global variable, then check each function *)
let local_symbols = Hashtbl.create 1;;
let for_init_symbols = Hashtbl.create 1;;
let global_symbols = Hashtbl.create 1;;

let pic_attrs = List.fold_left (fun m (t, n) -> StringMap.add n t m)
                StringMap.empty ([(Int, "h"); (Int, "w"); (Int, "bpp"); (Void, "data")])

let check program =
  (* Split program into globals & functions *)
  let local_hash_list = [] in
  let rec transform p v f =
  match p with
  a::b -> (match a with
     Vdecl(x) -> transform b (x::v) f
     | Fdecl(x) -> transform b v (x::f))
  | [] -> (v,f)
  in
  let (globals, functions) = transform program [] [] 
  in
  let rec transform_globals g r =
  match g with
    a::b -> (
        match a with
        Bind(x) -> transform_globals b (x::r)
        | _ -> transform_globals b r
      )
    | [] -> r
  in let globals = transform_globals globals [] in

  (* Raise an exception if the given list has a duplicate *)
  let report_duplicate exceptf list =
    let rec helper = function
       n1 :: n2 :: _ when n1 = n2 -> raise (Failure (exceptf n1))
      | _ :: t -> helper t
      | [] -> ()
    in helper (List.sort compare list)
  in
  (* Raise an exception if a given binding is to a void type *)
  let check_not_void exceptf = function
      (Void, n) -> raise (Failure (exceptf n))
    | _ -> ()
  in
  let check_assign lvaluet rvaluet err =
     if (string_of_typ lvaluet) == (string_of_typ rvaluet) then lvaluet else raise err
  in
   
  (**** Checking Global Variables ****)

  List.iter (check_not_void (fun n -> "illegal void global " ^ n)) globals;
   
  report_duplicate (fun n -> "duplicate global " ^ n) (List.map snd globals);

  (**** Checking Functions ****)

  if List.mem "print" (List.map (fun fd -> fd.fname) functions)
  then raise (Failure ("function print may not be defined")) else ();

  report_duplicate (fun n -> "duplicate function " ^ n)
    (List.map (fun fd -> fd.fname) functions);

  (* Function declaration for a named function *)
  let built_in_decls = StringMap.add "newpic"
      { typ = Void; fname = "newpic"; formals = [(Int, "x"); (Int, "y")];
        body = [] } (StringMap.add "save"
      { typ = Void; fname = "save"; formals = [(Pic, "x")];
        body = [] } (StringMap.add "save_file" 
      { typ = Void; fname = "save_file"; formals = [(Void, "x"); (Pic, "x")];
        body = [] } (StringMap.add "load" 
      { typ = Pic; fname = "load"; formals = [(Void, "x")];
        body = [] } (StringMap.add "printb" 
      { typ = Void; fname = "printb"; formals = [(Bool, "x")];
        body = [] } (StringMap.add "print"
      { typ = Void; fname = "print"; formals = [(Int, "x")];
        body = [] } (StringMap.singleton "prints"
      { typ = Void; fname = "prints"; formals = [(Void, "x")];
        body = [] }))))))
  in
     
  let function_decls = List.fold_left (fun m fd -> StringMap.add fd.fname fd m)
                         built_in_decls functions
  in

  let function_decl s = try StringMap.find s function_decls
       with Not_found -> raise (Failure ("unrecognized function " ^ s))
  in

  let _ = function_decl "main" in (* Ensure "main" is defined *)

  let check_function func =
    List.iter (check_not_void (fun n -> "illegal void formal " ^ n ^
      " in " ^ func.fname)) func.formals;

    report_duplicate (fun n -> "duplicate formal " ^ n ^ " in " ^ func.fname)
      (List.map snd func.formals);
    
    List.fold_left (fun tbl (t, n) -> Hashtbl.add tbl n t; tbl)
    global_symbols globals;
  
    let rec search_var_in_locals s = function
        hd :: sl -> (* print_string ("hash: " ^ (string_of_hash hd) ^ "\n"); *)
                    if (Hashtbl.mem hd s) then Hashtbl.find hd s
                    else search_var_in_locals s sl
        | [] -> raise Not_found
    in
    let type_of_identifier local_hash_list s =
      try Hashtbl.find for_init_symbols s
      with Not_found ->
         try Hashtbl.find local_symbols s
         with Not_found -> 
            try Hashtbl.find global_symbols s
            with Not_found -> 
               try search_var_in_locals s local_hash_list
               with Not_found -> raise (Failure ("undeclared identifier " ^ s))
    in
    let pic_attr_checker s = 
      try StringMap.find s pic_attrs
      with Not_found -> raise (Failure ("attributes not found in pic:" ^ s))
    in
    (* Return the type of an expression or throw an exception *)
    let rec expr local_hash_list = function
        Literal _ -> Int
      | BoolLit _ -> Bool
      | StringLit _ -> Void
      | Id s -> type_of_identifier local_hash_list s
      | Binop(e1, op, e2) as e -> let t1 = (expr local_hash_list e1) and t2 = (expr local_hash_list e2) in
      (match op with
          Add | Sub | Mult | Div when t1 = Int && t2 = Int -> Int
         | Equal | Neq when t1 = t2 -> Bool
         | Less | Leq | Greater | Geq when t1 = Int && t2 = Int -> Bool
         | And | Or when t1 = Bool && t2 = Bool -> Bool
         | _ -> raise (Failure ("illegal binary operator " ^
              string_of_typ t1 ^ " " ^ string_of_op op ^ " " ^
              string_of_typ t2 ^ " in " ^ string_of_expr e)))
      | Unop(op, e) as ex -> let t = expr local_hash_list e in
      (match op with
            Neg when t = Int -> Int
           | Not when t = Bool -> Bool
           | _ -> raise (Failure ("illegal unary operator " ^ string_of_uop op ^
           string_of_typ t ^ " in " ^ string_of_expr ex)))
      | Noexpr -> Void
      | Assign(var, e) as ex -> let lt = type_of_identifier local_hash_list var
                                and rt = expr local_hash_list e in
        check_assign lt rt
                 (Failure ("illegal assignment " ^ string_of_typ lt ^ " = " ^
                           string_of_typ rt ^ " in " ^ string_of_expr ex))
      | Getarr(s, e) -> ignore(type_of_identifier local_hash_list s); (expr local_hash_list e)
      | Assignarr(s, e1, e2) -> ignore(type_of_identifier local_hash_list s); 
                                expr local_hash_list e1; 
                                expr local_hash_list e2
      | Getmatrix(s, e1, e2) -> ignore(type_of_identifier local_hash_list s);
                                expr local_hash_list e1; 
                                expr local_hash_list e2
      | Assignmatrix(s, e1, e2, e3) -> ignore(type_of_identifier local_hash_list s); 
                                        expr local_hash_list e1; 
                                        expr local_hash_list e2; 
                                        expr local_hash_list e3
      | GetRGBXY(s1, s2, e1, e2) -> ignore(type_of_identifier local_hash_list s1); 
                                    ignore(type_of_identifier local_hash_list s2); 
                                    expr local_hash_list e1; 
                                    expr local_hash_list e2
      | AssignRGBXY(s1, s2, e1, e2, e3) -> ignore(type_of_identifier local_hash_list s1); 
                                            ignore(type_of_identifier local_hash_list s2);
                                            expr local_hash_list e1;
                                            expr local_hash_list e2;
                                            expr local_hash_list e3
      | Getpic(s1, s2) -> ignore(type_of_identifier local_hash_list s1); 
                          ignore(pic_attr_checker s2); 
                          StringMap.find s2 pic_attrs
      | Assignpic(s1, s2, e) -> ignore(type_of_identifier local_hash_list s1);
                                ignore(pic_attr_checker s2); 
                                expr local_hash_list e
      | Call(fname, actuals) as call -> let fd = function_decl fname in
         if List.length actuals != List.length fd.formals then
              raise (Failure ("expecting " ^ string_of_int
              (List.length fd.formals) ^ " arguments in " ^ string_of_expr call))
         else
           List.iter2 (fun (ft, _) e -> let et = (expr local_hash_list e) in
              ignore (check_assign ft et
                (Failure ("illegal actual argument found " ^ string_of_typ et ^
                " expected " ^ string_of_typ ft ^ " in " ^ string_of_expr e))))
             fd.formals actuals;
           fd.typ   
    in
    let check_bool_expr local_hash_list e = if (expr local_hash_list e) != Bool
        then raise (Failure ("expected Boolean expression in " ^ string_of_expr e))
        else () 
    in
    (* Temporarily check for init type and always return expr first *)
    let check_not_void_in_symbols s t =
        check_not_void (fun n -> "illegal void local " ^ n ^ " in " ^ func.fname) (t, s)
    in
    let check_duplicate_in_symbols s t =
        try 
          let types = Hashtbl.find_all local_symbols s 
          in
          (* print_string "check_duplicate_in_symbols\n";
          print_string ((string_of_hash local_symbols) ^ "\n"); *)
          if List.mem t types then raise (Failure ((fun n -> "duplicate local " ^ n) s))
          else ()
        with Not_found -> ()
    in
    let add_var_into_symbols s t = 
      check_not_void_in_symbols s t;
      check_duplicate_in_symbols s t;
      Hashtbl.add local_symbols s t
    in
    let check_for_init local_hash_list e =
      match e with 
      F_init(t1, s1, e1) -> check_not_void_in_symbols s1 t1; 
                            Hashtbl.add for_init_symbols s1 t1;
                            expr local_hash_list e1
      | F_expr e1 -> expr local_hash_list e1
    in
    (* Verify a statement or throw an exception *)
    let combine_hashes from_hash to_hash = 
        (* print_string "combine_hashes:\n"; *)
        (* print_string ("from_hash: " ^ (string_of_hash from_hash) ^ "\n"); *)
        Hashtbl.iter (fun key value -> Hashtbl.add to_hash key value) from_hash;
        (* print_string ("to_hash: " ^ (string_of_hash to_hash) ^ "\n") *)
    in
    let enter_block_update_local_hash_list local_hash_list local_symbols = 
      (* print_string "enter block update hash\n"; *)
      (* print_string ((string_of_hash local_symbols) ^ "\n"); *)
      let tmp_hash = Hashtbl.copy local_symbols
      in
      Hashtbl.clear local_symbols;
      List.fold_left (fun tbl (t, n) -> 
                    Hashtbl.add tbl n t; tbl) local_symbols (func.formals);
      if Hashtbl.length for_init_symbols > 0 
      then combine_hashes for_init_symbols local_symbols; Hashtbl.clear for_init_symbols;
      (tmp_hash :: local_hash_list)
    in
    
    let leave_block_update_local_hash_list local_hash_list =
        (* print_string "leave block update hash\n"; *)
        combine_hashes (List.hd local_hash_list) local_symbols;
        (* print_string ( "local_symbols: " ^ (string_of_hash local_symbols) ^ "\n") *)
    in
    let rec stmt local_hash_list = function
      Block sl -> 
        (* print_string "Block\n"; *)
        let local_hash_list = enter_block_update_local_hash_list local_hash_list local_symbols
        in
        (* let _ =
          print_string "============\n";
          print_string ("Test local_hash_list length: " ^ string_of_int(List.length local_hash_list) ^ "\n");
          print_string ("local_hash_list: " ^ ((string_of_list string_of_hash local_hash_list) ^ "\n"));
          print_string ("local_symbols: " ^ (string_of_hash local_symbols) ^ "\n");
          print_string "============\n"
        in *)
        let rec check_block local_hash_list = function
            [Return _ as s] -> stmt local_hash_list s
            | Return _ :: _ -> raise (Failure "nothing may follow a return")
            | Block sl :: ss -> (* print_string ("Block with stmt list\n"); *)
                                check_block (enter_block_update_local_hash_list local_hash_list local_symbols) (sl @ ss)
            | s :: ss ->(*  print_string("s :: ss\n"); *) stmt local_hash_list s; check_block local_hash_list ss
            | [] -> leave_block_update_local_hash_list local_hash_list; ()
        in check_block local_hash_list sl
      | Expr e -> (* print_string "Expr\n";  print_string ((string_of_expr e) ^ "\n"); *) ignore (expr local_hash_list e)
      | S_bind(t, s) -> (* print_string "S_bind\n"; *) ignore (add_var_into_symbols s t)
      | S_init(t, s, e) ->  (* print_string "S_init\n";  *)
                            (* print_string ((string_of_expr e) ^ "\n"); *)
                            ignore(add_var_into_symbols s t); 
                            ignore(expr local_hash_list e) (* why can this work? *)
      | Return e -> (* print_string "Return\n"; *)
          let t = (expr local_hash_list e) in if t = func.typ then () else
           raise (Failure ("return gives " ^ string_of_typ t ^ " expected " ^
                           string_of_typ func.typ ^ " in " ^ string_of_expr e))       
      | If(p, b1, b2) -> (* print_string "if\n"; *)
                          check_bool_expr local_hash_list p; 
                          stmt local_hash_list b1; 
                          stmt local_hash_list b2
      | For(e1, e2, e3, st) ->  (* print_string "for\n";
                                print_string ((string_of_stmt st) ^ "\n");
                                print_string ("local_hash_list: " ^ (string_of_list string_of_hash local_hash_list) ^ "\n"); *)
                                ignore (check_for_init local_hash_list e1); 
                                check_bool_expr local_hash_list e2; 
                                ignore (expr local_hash_list e3); 
                                stmt local_hash_list st
      | While(p, s) -> check_bool_expr local_hash_list p; 
                        stmt local_hash_list s
    in
    stmt local_hash_list (Block func.body)
   
  in
  List.iter check_function functions
