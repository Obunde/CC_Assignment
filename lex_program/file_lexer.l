%{
#include <stdio.h>
int yylex();   // Declare yylex function
int yywrap(void) { return 1; }  // Tells Flex there is no more input
%}

%%
[ \t\n]+       { /* Ignore whitespace */ }
if             { printf("Keyword: IF\n"); }
else           { printf("Keyword: ELSE\n"); }
then           { printf("Keyword: THEN\n"); }
[A-Za-z][A-Za-z0-9]* { printf("Identifier: %s\n", yytext); }
[0-9]+(\.[0-9]+)?    { printf("Number: %s\n", yytext); }
"<"            { printf("Relational Operator: <\n"); }
"<="           { printf("Relational Operator: <=\n"); }
"="            { printf("Relational Operator: =\n"); }
"<>"           { printf("Relational Operator: <>\n"); }
">"            { printf("Relational Operator: >\n"); }
">="           { printf("Relational Operator: >=\n"); }
.              { printf("Unrecognized character: %s\n", yytext); }  // Handle invalid input
%%

int main(int argc, char *argv[]) {
    if (argc > 1) {
        FILE *file = fopen(argv[1], "r");
        if (!file) {
            printf("Error: Cannot open file %s\n", argv[1]);
            return 1;
        }
        yyin = file;  // Set input source to file
    }
    
    yylex();  // Run lexer
    
    if (yyin != stdin) fclose(yyin);
    return 0;
}
