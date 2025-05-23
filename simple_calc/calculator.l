%{
#include "calculator.tab.h"
#include <stdlib.h>
%}

%%

[0-9]+      { yylval = atoi(yytext); return NUMBER; }
[ \t]       ;              // ignore whitespace
\n          { return '\n'; }
[+\-]       { return yytext[0]; }  // return '+' or '-' directly
.           { return yytext[0]; }

%%

int yywrap() {
    return 1;
}
