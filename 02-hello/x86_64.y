%{
#include <stdio.h>
#include <stdlib.h>
extern int yylineno;
extern FILE *yyin;
static int lbl;
static FILE *out;
%}
%union { char *s; }
%token PRINT
%token<s> STR
%%
file: '{' instrs '}'    { fprintf(out, "\tmov rax, 0\n\tret\n"); }
    ;
instrs:                 { fprintf(out, "extern printf\nsegment .text\nalign 8\nglobal main:function\nmain:\n"); }
      | instrs instr    { /* no code between instructions */ }
      ;
instr: PRINT STR ';'    { lbl++; fprintf(out, "segment .rodata\nalign 8\n_L%d: db '%s', 10, 0\nsegment .text\n\tmov rax, 0\n\tmov edi, $_L%d\n\tcall printf\n", lbl, $2, lbl); }
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
