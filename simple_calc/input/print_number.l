%{
#include "print_number.tab.h"
%}

%%
[0-9]+      { yylval = atoi(yytext); return NUMBER; }
[ \t]       ;                // ignore spaces/tabs
\n          { return '\n'; } // return newline
.           { return yytext[0]; } // unknown character
%%

int yywrap() {
    return 1;
}
