%token<year> Year
%token<actor> Actor
%token Comma
%type<(year list * actor) list> file
%start file
%%
file : /* empty */ { [ ] }
    | record file { $1 :: $2 } ;

record : years Comma Actor { ($1, $3) } ;

years :
    Year { [$1] }
    | years Comma Year { $1 @ [$3] } ;
