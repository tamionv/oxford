%{
open Tree
%}

%token <int> INT
%token <string> VAR
%token <int -> int -> int> BINOP
%token <int -> int> UNOP
%token LET

%type <Tree.ast> expr
%start expr 

%%
expr:
    INT { IntLeaf $1 }
    | VAR { VarLeaf $1 }
    | UNOP expr { UnaryOp ($1, $2) }
    | BINOP expr expr { BinaryOp ($1, $2, $3) }
    | LET VAR expr expr { Let ($2, $3, $4) }
;


