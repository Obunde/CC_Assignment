%{
#include <stdio.h>
#include <stdlib.h>

int yylex();
void yyerror(const char *s);
%}

%token NUMBER
%left '+' '-'

%%

input:
      /* empty */
    | input expr '\n'   { printf("Result = %d\n", $2); }
    ;

expr:
      expr '+' expr     { $$ = $1 + $3; }
    | expr '-' expr     { $$ = $1 - $3; }
    | NUMBER            { $$ = $1; }
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    printf("Enter expressions like '5+3-2' or '5 + 3 - 2', press Ctrl+D to exit\n");
    return yyparse();
}
