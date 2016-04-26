%{ open Ast %}

%token SEMI LPAREN RPAREN LBRACE RBRACE COMMA LBRACKET RBRACKET
%token PLUS MINUS TIMES DIVIDE ASSIGN NOT DPLUS DMIN DTIMES CONV DOT
%token EQ NEQ LT LEQ GT GEQ TRUE FALSE AND OR CONV PPLUS MMINUS
%token RETURN BREAK CONTINUE IMPORT MAIN SIZEOF IF ELSE FOR WHILE INT CHAR BOOL VOID DELETE PIC MATRIX
%token <int> LITERAL
%token <string> ID
%token <char> CHARLIT
%token <string> STRINGLIT
%token EOF

%nonassoc NOELSE
%nonassoc ELSE

%right ASSIGN
%left CONV
%left OR
%left AND
%left EQ NEQ
%left LT GT LEQ GEQ
%left PLUS MINUS
%left TIMES DIVIDE
%right NOT NEG

%start program

%type <Ast.program> program

%%

program:
  decls EOF { $1 }

decls:
   /* nothing */ { [] }
 | vdecl decls { $1 :: $2 }
 | fdecl decls { $1 :: $2 }

fdecl:
   typ ID LPAREN formals_opt RPAREN LBRACE  stmt_list RBRACE
     { Fdecl({ typ = $1;
   fname = $2;
   formals = $4;
   body = List.rev $7 }) }
  |typ MAIN LPAREN formals_opt RPAREN LBRACE  stmt_list RBRACE
     { Fdecl({ typ = $1;
   fname = "main";
   formals = $4;
   body = List.rev $7 }) } 

formals_opt:
    /* nothing */ { [] }
  | formal_list   { List.rev $1 }

formal_list:
    typ ID                   { [($1,$2)] }
  | MATRIX ID 		     { [(Matrix(5,5), $2)] }
  | formal_list COMMA typ ID { ($3,$4) :: $1 }
  | formal_list COMMA MATRIX ID { (Matrix(5,5),$4) :: $1 }

typ:
    INT { Int }
  | BOOL { Bool }
  | CHAR { Char }
  | VOID { Void }
  | PIC {Pic}
/*  | MATRIX { Matrix(5, 5) }*/

vdecl:
   typ ID SEMI { Vdecl(Bind($1, $2)) }
  | typ ID  LBRACKET LITERAL RBRACKET SEMI {Vdecl(Bind(Array($1, $4),$2))}  
  | MATRIX ID LBRACKET LITERAL RBRACKET LBRACKET LITERAL RBRACKET SEMI { Vdecl(Bind(Matrix($4,$7),$2)) }

stmt_list:
    /* nothing */  { [] }
  | stmt_list stmt { $2 :: $1 }

stmt:
    expr SEMI { Expr $1 }
  | RETURN SEMI { Return Noexpr }
  | RETURN expr SEMI { Return $2 }
  | LBRACE stmt_list RBRACE { Block(List.rev $2) }
  | IF LPAREN expr RPAREN stmt %prec NOELSE { If($3, $5, Block([])) }
  | IF LPAREN expr RPAREN stmt ELSE stmt    { If($3, $5, $7) }
  | FOR LPAREN expr_opt SEMI expr SEMI expr_opt RPAREN stmt
     { For(F_expr($3), $5, $7, $9) }
  | FOR LPAREN typ ID ASSIGN expr SEMI expr SEMI expr_opt RPAREN stmt
     { For(F_init($3,$4, $6), $8, $10, $12) }
  | WHILE LPAREN expr RPAREN stmt { While($3, $5) }
  | typ ID SEMI { S_bind($1, $2) }
  | typ ID ASSIGN expr SEMI { S_init($1, $2, $4) }
  | typ ID LBRACKET LITERAL RBRACKET SEMI {S_bind(Array($1, $4),$2)}
  | MATRIX ID LBRACKET LITERAL RBRACKET LBRACKET LITERAL RBRACKET SEMI { S_bind(Matrix($4,$7),$2) }

expr_opt:
    /* nothing */ { Noexpr }
  | expr          { $1 }

expr:
    LITERAL          { Literal($1) }
  | TRUE             { BoolLit(true) }
  | FALSE            { BoolLit(false) }
  | ID               { Id($1) }
  | CHARLIT	         { CharLit($1) }
  | STRINGLIT	       { StringLit($1) }
  | expr PLUS   expr { Binop($1, Add,   $3) }
  | expr MINUS  expr { Binop($1, Sub,   $3) }
  | expr TIMES  expr { Binop($1, Mult,  $3) }
  | expr DIVIDE expr { Binop($1, Div,   $3) }
  | expr EQ     expr { Binop($1, Equal, $3) }
  | expr NEQ    expr { Binop($1, Neq,   $3) }
  | expr LT     expr { Binop($1, Less,  $3) }
  | expr LEQ    expr { Binop($1, Leq,   $3) }
  | expr GT     expr { Binop($1, Greater, $3) }
  | expr GEQ    expr { Binop($1, Geq,   $3) }
  | expr AND    expr { Binop($1, And,   $3) }
  | expr OR     expr { Binop($1, Or,    $3) }
  | MINUS expr %prec NEG { Unop(Neg, $2) }
  | NOT expr         { Unop(Not, $2) }
  | ID ASSIGN expr   { Assign($1, $3) }
  | ID LPAREN actuals_opt RPAREN { Call($1, $3) }
  | LPAREN expr RPAREN { $2 }
  | ID LBRACKET expr RBRACKET ASSIGN expr { Assignarr($1, $3, $6) }
  | ID LBRACKET expr RBRACKET { Getarr($1, $3) }
  | ID DOT ID        {Getpic($1, $3)}
  | ID DOT ID LBRACKET expr RBRACKET LBRACKET expr RBRACKET {GetRGBXY($1, $3, $5, $8)}
  | ID DOT ID ASSIGN expr {Assignpic($1, $3, $5)}
  | ID DOT ID LBRACKET expr RBRACKET LBRACKET expr RBRACKET ASSIGN expr {AssignRGBXY($1, $3, $5, $8, $11)}
  | ID LBRACKET expr RBRACKET LBRACKET expr RBRACKET { Getmatrix($1,$3,$6) }  
  | ID LBRACKET expr RBRACKET LBRACKET expr RBRACKET ASSIGN expr { Assignmatrix($1,$3,$6,$9) }
  | expr CONV expr { Convol($1,$3) }
  | ID PPLUS { Assign($1, Binop(Id($1), Add, Literal(1))) } 
  | ID MMINUS { Assign($1, Binop(Id($1), Sub, Literal(1))) }
  | DELETE ID { Unop(Delete, Id($2)) }
  | ID ASSIGN int_list { Init_array($1, $3) }
  


int_list:
  LBRACE int_list2  RBRACE { $2 }

int_list2:
  | LITERAL COMMA int_list2 { $1::$3 }
  | LITERAL { [$1] }


actuals_opt:
    /* nothing */ { [] }
  | actuals_list  { List.rev $1 }

actuals_list:
    expr                    { [$1] }
  | actuals_list COMMA expr { $3 :: $1 }
