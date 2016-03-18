(* Ocamllex scanner for MicroC *)

{ open Parser }

rule token = parse
  [' ' '\t' '\r' '\n'] { token lexbuf } (* Whitespace *)
| "/*"     { comment lexbuf }           (* Comments *)
| '('      { LPAREN }
| ')'      { RPAREN }
| '{'      { LBRACE }
| '}'      { RBRACE }
| '['      {LBRACKET}
| ']'      {RBRACKET}
| '#'     {CONV}
| ".+"   {DADD}
| ".-"    {DSUB}
| ".*"    {DMUL}
| ';'      { SEMI }
| ','      { COMMA }
| '+'      { PLUS }
| '-'      { MINUS }
| '*'      { TIMES }
| '/'      { DIVIDE }
| '='      { ASSIGN }
| "=="     { EQ }
| "!="     { NEQ }
| '<'      { LT }
| "<="     { LEQ }
| ">"      { GT }
| ">="     { GEQ }
| "if"     { IF }
| "else"   { ELSE }
| "for"    { FOR }
| "while"  { WHILE }
| "return" { RETURN }
| "int"    { INT }
| "pic"  { PIC }
| "char" { CHAR }
| "import" { IMPORT }
| "break"  { BREAK }
| "continue" { CONTINUE }
| "sizeof" { SIZEOF }
| "void" { VOID }
| "true" { TRUE }
| "false" { FALSE }
| "main" { MAIN }
| "and" { AND }
| "or" { OR }
| "not" { NOT }
| "copy" { COPY }
| "delete" { DELETE }
| ['0'-'9']+ as lxm { LITERAL(int_of_string lxm) }
| ['a'-'z' 'A'-'Z']['a'-'z' 'A'-'Z' '0'-'9' '_']* as lxm { ID(lxm) }
| eof { EOF }
| _ as char { raise (Failure("illegal character " ^ Char.escaped char)) }

and comment = parse
  "*/" { token lexbuf }
| _    { comment lexbuf }
