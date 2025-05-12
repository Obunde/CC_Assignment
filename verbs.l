%{
#include <stdio.h>
%}

%%
is|am|are|were|was|be|being|been|do|does|did|will|would|should|can|could|has|have|had|go { 
    printf("Recognized Verb: %s\n", yytext); 
}
. ; /* Ignore other characters */
%%

int main() {
    yylex();
    return 0;
}

int yywrap() {
    return 1;
}
