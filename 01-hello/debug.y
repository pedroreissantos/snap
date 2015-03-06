%{
#include <stdio.h>
#include <stdlib.h>
#define YYDEBUG 1
extern int yylineno;
%}
%union { char *s; }
%token PRINT
%token<s> STR
%%
file: '{' instrs '}'
    ;
instrs:
      | instrs instr
      ;
instr: PRINT STR ';'
     ;
%%
int yyerror(char *s) { fprintf(stderr, "%d: %s\n", yylineno, s); return 0; }

int main() { yydebug = 1; return yyparse(); }
