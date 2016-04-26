(* Ocamllex scanner for MicroC *)

{ open Parser }

rule token = parse
[' ' '\t' '\r' '\n']   { token lexbuf } 	(* Whitespace *)
| "/*"     			   { comment lexbuf }           (* Comments *)
| ( '-'?['0'-'9']+ ) as lxm { LITERAL(int_of_string lxm) }
| "++"				   { PPLUS }
| "--"				   { MMINUS }
| '('      			   { LPAREN }
| ')'      			   { RPAREN }
| '{'      			   { LBRACE }
| '}'      			   { RBRACE }
| '['      			   { LBRACKET }
| ']'      			   { RBRACKET }
| '#'      			   { CONV }
| ".+"     			   { DPLUS }
| ".-"     			   { DMIN }
| ".*"     			   { DTIMES }
| ';'      			   { SEMI }
| ','      			   { COMMA }
| '+'      			   { PLUS }
| '-'      			   { MINUS }
| '*'      			   { TIMES }
| '/'      			   { DIVIDE }
| '='      			   { ASSIGN }
| "=="     			   { EQ }
| "!="     			   { NEQ }
| '<'      			   { LT }
| "<="     			   { LEQ }
| ">"      			   { GT }
| ">="     			   { GEQ }
| "if"     			   { IF }
| "else"   			   { ELSE }
| "for"    			   { FOR }
| "while"  			   { WHILE }
| "return" 			   { RETURN }
| "int"    			   { INT }
| "bool"   			   { BOOL }
| "char"   		  	   { CHAR }
| "void"   			   { VOID }
| "pic"    			   { PIC }
| "mat"			   	   { MATRIX }
| "import" 			   { IMPORT }
| "break"  			   { BREAK }
| "continue" 			   { CONTINUE }
| "sizeof" 			   { SIZEOF }
| "true" 			   { TRUE }
| "false" 			   { FALSE }
| "main" 			   { MAIN }
| "and" 			   { AND }
| "or" 				   { OR }
| "not"				   { NOT }
| "delete" 			   { DELETE }
| '.'				   {DOT}
| '\'' _ '\'' as  s    { CHARLIT(s.[1]) }
| '\"' ("\\\"" | [^ '\"' ])* '\"' as s { STRINGLIT(String.sub s 1 ((String.length s) - 2))}
| ['a'-'z' 'A'-'Z']['a'-'z' 'A'-'Z' '0'-'9' '_']* as lxm { ID(lxm) }
| eof { EOF }
| _ as char { raise (Failure("illegal character " ^ Char.escaped char)) }

and comment = parse
  "*/" { token lexbuf }
| _    { comment lexbuf }
