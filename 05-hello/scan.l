%{
#include "node.h" /* for Node in yylval from the %union of gram.y */
#include "y.tab.h"
#include <string.h>
%}
%%
print           return PRINT;
\"[^"]*\"       yytext[yyleng-1]=0; yylval.s = strdup(yytext+1); return STR;
[a-zA-Z][a-zA-Z0-9]*  yylval.s = strdup(yytext); return ID;
[ \n\t\r]+      ;
\/\/.*          ;
.               return *yytext;
%%
int yywrap() { return 1; }
