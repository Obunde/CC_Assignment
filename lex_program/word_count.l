%{
#include <stdio.h>
#include <ctype.h>

int word_count = 0;    // Total number of words
int total_size = 0;    // Total size of words
int yywrap(void) { return 1; }  // End of input function
%}

%%  
[ \t\n]+       { /* Ignore whitespace */ } 
[A-Za-z]+      { word_count++; total_size += yyleng; }
.              { /* Ignore other characters */ }
%%

int main(int argc, char *argv[]) {
    if (argc > 1) {
        FILE *file = fopen(argv[1], "r");
        if (!file) {
            printf("Error: Cannot open file %s\n", argv[1]);
            return 1;
        }
        yyin = file;
    }

    yylex();  // Run the lexer

    printf("Total words: %d\n", word_count);
    printf("Total size of words: %d characters\n", total_size);

    if (yyin != stdin) fclose(yyin);
    return 0;
}
