type token =
  | SEMI
  | LPAREN
  | RPAREN
  | LBRACE
  | RBRACE
  | COMMA
  | LBRACKET
  | RBRACKET
  | PLUS
  | MINUS
  | TIMES
  | DIVIDE
  | ASSIGN
  | NOT
  | DPLUS
  | DMIN
  | DTIMES
  | CONV
  | EQ
  | NEQ
  | LT
  | LEQ
  | GT
  | GEQ
  | TRUE
  | FALSE
  | AND
  | OR
  | RETURN
  | BREAK
  | CONTINUE
  | IMPORT
  | MAIN
  | SIZEOF
  | IF
  | ELSE
  | FOR
  | WHILE
  | INT
  | CHAR
  | BOOL
  | VOID
  | DELETE
  | PIC
  | LITERAL of (int)
  | ID of (string)
  | CHARLIT of (char)
  | STRINGLIT of (string)
  | EOF

val program :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Ast.program
