(* Abstract Syntax Tree and functions for printing it *)

type op = Add | Sub | Mult | Div | Equal | Neq | Less | Leq | Greater | Geq | And | Or 

type uop = Neg | Not | Delete

type typ = Int | Bool | Char | Array of typ*int | Pic | Void | Matrix of int*int

type bind = typ * string

type expr = Literal of int
  | Id of string
  | StringLit of string
  | CharLit of char
  | BoolLit of bool
  | Binop of expr * op * expr
  | Unop of uop * expr
  | Assign of string * expr
  | Call of string * expr list
  | Getarr of string * expr 
  | Assignarr of string * expr * expr
  | Getpic of string * string 
  | GetRGBXY of string * string * expr * expr
  | Getmatrix of string * expr * expr
  | Assignpic of string * string * expr
  | AssignRGBXY of string * string * expr * expr * expr
  | Assignmatrix of string * expr * expr * expr
  | Convol of expr * expr
  | Noexpr
  | Init_array of string * expr list

type initialization = typ * string * expr

type vdecl =  Bind of bind

type for_init = F_init of initialization
  | F_expr of expr


type stmt = Block of stmt list
  | Expr of expr
  | If of expr * stmt * stmt
  | For of for_init * expr * expr * stmt
  | While of expr * stmt
  | Return of expr
  | S_bind of bind
  | S_init of initialization

type func_decl = {
  typ: typ;
  fname: string;
  formals: bind list;
  body: stmt list;
}

type decl = Vdecl of vdecl
  | Fdecl of func_decl

type  program = decl list

(* Pretty-printing functions *)

 let rec string_of_typ = function
    Int -> "int"
    | Bool -> "bool"
    | Void -> "void"
    | Pic  -> "pic"
    | Char -> "char"
    | Array(typ, i) -> (string_of_typ typ) ^ " array[" ^ (string_of_int i) ^ "]"
    | Matrix(i1, i2) -> "mat " ^ (string_of_int i1) ^ " " ^ (string_of_int i2)

 let string_of_op = function
    Add -> "+"
    | Sub -> "-"
    | Mult -> "*"
    | Div -> "/"
    | Equal -> "=="
    | Neq -> "!="
    | Less -> "<"
    | Leq -> "<="
    | Greater -> ">"
    | Geq -> ">="
    | And -> "&&"
    | Or -> "||"

let string_of_uop = function
    Neg -> "-"
    | Not -> "!"
    | Delete -> "delete "

let rec string_of_expr = function
    Literal(l) -> string_of_int l
  | StringLit(s) -> "\"" ^ s ^ "\""
  | BoolLit(true) -> "true"
  | BoolLit(false) -> "false"
  | Id(s) -> s
  | Binop(e1, o, e2) ->
      string_of_expr e1 ^ " " ^ string_of_op o ^ " " ^ string_of_expr e2
  | Unop(o, e) -> string_of_uop o ^ string_of_expr e
  | Assign(v, e) -> v ^ " = " ^ string_of_expr e
  | Call(f, el) ->
      f ^ "(" ^ String.concat ", " (List.map string_of_expr el) ^ ")"
  | Noexpr -> ""
  | _ -> "Havn't done yet!!"

let string_of_for_init = function
  F_init(t, s, e) -> (string_of_typ t) ^ " " ^ s ^ " " ^ (string_of_expr e) (* for loop init *)
  | F_expr e -> string_of_expr e

let rec string_of_stmt = function
    Block(stmts) ->
      "{\n" ^ String.concat "" (List.map string_of_stmt stmts) ^ "}\n"
  | Expr(expr) -> string_of_expr expr ^ ";\n";
  | Return(expr) -> "return " ^ string_of_expr expr ^ ";\n";
  | If(e, s, Block([])) -> "if (" ^ string_of_expr e ^ ")\n" ^ string_of_stmt s
  | If(e, s1, s2) ->  "if (" ^ string_of_expr e ^ ")\n" ^
      string_of_stmt s1 ^ "else\n" ^ string_of_stmt s2
  | For(fi, e2, e3, st) ->
      ("for (" ^ (string_of_for_init fi) ^ " ; " ^ (string_of_expr e2) ^ " ; " ^
        (string_of_expr e3)  ^ ") " ^ (string_of_stmt st))
  | While(e, st) -> ("while (" ^ (string_of_expr e) ^ ") " ^ (string_of_stmt st))
  | S_bind(t, s) -> ((string_of_typ t) ^ " " ^ s)
  | S_init(t, s, e) -> ((string_of_typ t) ^ " " ^ s ^ " " ^ (string_of_expr e))

let string_of_bind (t, id) =
  string_of_typ t ^ " " ^ id ^ ";\n"

let string_of_vdecl = function
  Bind(bind) -> string_of_bind bind

let string_of_fdecl fdecl =
  string_of_typ fdecl.typ ^ " " ^
  fdecl.fname ^ "(" ^ String.concat ", " (List.map snd fdecl.formals) ^
  ")\n{\n" ^
  (*String.concat "" (List.map string_of_vdecl fdecl.locals) ^*)
  String.concat "" (List.map string_of_stmt fdecl.body) ^
  "}\n"

let string_of_decl = function
  Vdecl(vdecl) -> string_of_vdecl vdecl  ^ "\n" 
  |Fdecl(func_decl) -> " " ^ string_of_fdecl func_decl ^ "\n"

(*let string_of_decl (vars, funcs) =
  String.concat "" (List.map string_of_vdecl vars) ^ "\n" ^
  String.concat "\n" (List.map string_of_fdecl funcs)*)

let string_of_hash tbl = 
    Hashtbl.fold (fun key value init -> "{" ^ key ^ ": " ^ string_of_typ(value) ^ "} " ^ init) tbl ""

let string_of_list string_fun lst =
    "[" ^ (List.fold_left (fun res elem -> res ^ "; " ^ string_fun(elem)) "" lst) ^ " ]"

let string_of_program (decls) =
  String.concat "" (List.map string_of_decl decls)

