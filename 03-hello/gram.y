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
file: '{' instrs '}'    { fprintf(out, "\tmovq $0, %%rax\n\tret\n"); }
    ;
instrs:                 { fprintf(out, ".extern printf\n.section .text\n.align 8\n.global main\n.type main, %%function\nmain:\n"); }
      | instrs instr    { /* no code between instructions */ }
      ;
instr: PRINT STR ';'    { lbl++; fprintf(out, ".section .rodata\n.align 8\n_L%d:\t.ascii \"%s\"\n\t.byte 10\n\t.byte 0\n.section .text\n\tmovq $0, %%rax\n\tmovq $_L%d, %%rdi\n\tcall printf\n", lbl, $2, lbl); }
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
