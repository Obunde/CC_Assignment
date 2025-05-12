%{
#include <stdio.h>
#include <string.h>

int yywrap(void) { return 1; }  // End of input function
%}

%%  
[aA][bB][cC]    { printf("ABC"); }  // Replace "abc", "ABC", "Abc", etc. with "ABC"
[A-Za-z]+       { 
    char word[strlen(yytext) + 1];
    strcpy(word, yytext);
    for (int i = 0; word[i] != '\0'; i++) {
        if (word[i] == 'a' && word[i+1] == 'b' && word[i+2] == 'c') {
            word[i] = 'A'; word[i+1] = 'B'; word[i+2] = 'C';
        }
    }
    printf("%s", word);
}  // Print words, replacing "abc" inside them
[^A-Za-z]+      { printf("%s", yytext); }  // Print non-word characters (spaces, punctuation)
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

    if (yyin != stdin) fclose(yyin);
    return 0;
}
