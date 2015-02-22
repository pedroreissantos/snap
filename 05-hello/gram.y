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
%token<s> STR ID
%type<n> decls decl instrs instr strs str
%token NIL INSTRS PROG DECLS STRS
%%
file: decls '{' instrs '}'    { yyselect(binNode(PROG, $1, $3)); }
    ;
decls:                  { $$ = nilNode(NIL); }
     | decls decl       { $$ = binNode(DECLS, $1, $2); }
     ;
decl: ID '=' STR ';'    { $$ = binNode('=', strNode(ID, $1), strNode(STR, $3)); }
    ;
instrs:                 { $$ = nilNode(NIL); }
      | instrs instr    { $$ = binNode(INSTRS, $1, $2); }
      ;
instr: PRINT strs ';'   { $$ = uniNode(PRINT, $2); }
     ;
strs: str
    | strs ',' str      { $$ = binNode(STRS, $1, $3); }
    ;
str: ID                 { $$ = strNode(ID, $1); }
   | STR                { $$ = strNode(STR, $1); }
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
