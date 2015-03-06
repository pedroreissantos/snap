%{
#include <stdio.h>
#include <stdlib.h>
#include "node.h"
extern int yylineno;
extern FILE *yyin;
extern int yyselect(Node*);
FILE *out;
%}
%union { char *s; Node *n; }
%token PRINT
%token<s> STR
%type<n> instrs instr
%token NIL INSTRS
%%
file: '{' instrs '}'    { yyselect($2); }
    ;
instrs:                 { $$ = nilNode(NIL); }
      | instrs instr    { $$ = binNode(INSTRS, $1, $2); }
      ;
instr: PRINT STR ';'    { $$ = strNode(PRINT, $2); }
     ;
%%
int yyerror(char *s) { fprintf(stderr, "%d: %s\n", yylineno, s); return 0; }

int main(int argc, char *argv[]) {
  if (argc > 1)
    if ((yyin = fopen(argv[1], "r")) == 0) {
      perror(argv[1]);
      return 2;
    }
  if ((out = fopen(argc > 2 ? argv[2] : "out.asm", "w")) == 0) {
    perror(argv[1]);
    return 2;
  }
  return yyparse();
}
