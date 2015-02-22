%{
#include <stdio.h>
#include <stdlib.h>
#include "node.h"
#include "tabid.h"
extern int trace;
extern int yyselect(Node*);
#ifndef YYDEBUG
#define yyname 0
#endif
%}
%union { char *s; Node *n; }
%token PRINT
%token<s> STR ID
%type<n> decls decl instrs instr strs str
%token NIL INSTRS PROG DECLS STRS
%%
file: decls '{' instrs '}'    { Node *n = binNode(PROG, $1, $3); if (trace) printNode(n, 0, (char**)yyname); yyselect(n); }
    ;
decls:                  { $$ = nilNode(NIL); }
     | decls decl       { $$ = binNode(DECLS, $1, $2); }
     ;
decl: ID '=' STR ';'    { $$ = binNode('=', strNode(ID, $1), strNode(STR, $3)); IDnew(STR, $1, 0); }
    ;
instrs:                 { $$ = nilNode(NIL); }
      | instrs instr    { $$ = binNode(INSTRS, $1, $2); }
      ;
instr: PRINT strs ';'   { $$ = uniNode(PRINT, $2); }
     ;
strs: str
    | strs ',' str      { $$ = binNode(STRS, $1, $3); }
    ;
str: ID                 { $$ = strNode(ID, $1); IDfind($1, 0); }
   | STR                { $$ = strNode(STR, $1); }
   ;
