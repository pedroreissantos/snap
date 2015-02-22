%{
#include <stdio.h>
#include <stdlib.h>
#include "node.h"
#include "tabid.h"
extern int yyselect(Node*);
%}
%union { char *s; Node *n; int i; }
%token PRINT
%token<i> INT
%token<s> STR ID
%type<n> decls decl instrs instr strs str expr
%token NIL INSTRS PROG DECLS STRS EXPR
%%
file: decls '{' instrs '}'    { yyselect(binNode(PROG, $1, $3)); }
    ;
decls:                  { $$ = nilNode(NIL); }
     | decls decl       { $$ = binNode(DECLS, $1, $2); }
     ;
decl: ID '=' STR ';'    { $$ = binNode('=', strNode(ID, $1), strNode(STR, $3)); IDnew(STR, $1, 0); }
    | ID '=' INT ';'    { $$ = binNode('=', strNode(ID, $1), intNode(INT, $3)); IDnew(INT, $1, 0); }
    ;
instrs:                 { $$ = nilNode(NIL); }
      | instrs instr    { $$ = binNode(INSTRS, $1, $2); }
      ;
instr: PRINT strs ';'   { $$ = uniNode(PRINT, $2); }
     ;
strs: str
    | expr
    | strs ',' str      { $$ = binNode(STRS, $1, $3); }
    | strs ',' expr     { $$ = binNode(EXPR, $1, $3); }
    ;
str: ID                 { $$ = strNode(ID, $1); if (IDfind($1, 0) != STR) yyerror("variable type is not a string"); }
   | STR                { $$ = strNode(STR, $1); }
   ;
expr: ID                { $$ = strNode(ID, $1); if (IDfind($1, 0) != INT) yyerror("variable type is not an integer"); }
    | INT               { $$ = intNode(INT, $1); }
    | expr '+' expr     { $$ = binNode('+', $1, $3); }
    ;
