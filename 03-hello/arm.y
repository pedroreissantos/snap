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
file: '{' instrs '}'    { fprintf(out, "\tmov r0, #0\n\tldmfd sp!, {pc}\n"); }
    ;
instrs:                 { fprintf(out, ".extern printf\n.section .text\n.align 2\n.global main\n.type main, %%function\nmain:\n\tstmfd sp!, {lr}\n"); }
      | instrs instr    { /* no code between instructions */ }
      ;
instr: PRINT STR ';'    { lbl++; fprintf(out, ".section .rodata\n.align 2\n_L%d: .ascii \"%s\"\n\t.asciz \"\\n\"\n.section .text\n\tldr r0, =_L%d\n\tbl printf\n", lbl, $2, lbl); }
     ;
%%
int yyerror(char *s) { fprintf(stderr, "%d: %s\n", yylineno, s); return 0; }

int main(int argc, char *argv[]) {
  if (argc > 1)
    if ((yyin = fopen(argv[1], "r")) == 0) {
      perror(argv[1]);
      return 2;
    }
  if ((out = fopen(argc > 2 ? argv[2] : "out.s", "w")) == 0) {
    perror(argv[1]);
    return 2;
  }
  return yyparse();
}
