%{
#include "schemata.tab.h"
#include <string.h>
extern char* strdup(const char*);
%}

%%
"component"             { return COMPONENT; }
"connection"           { return CONNECTION; }
"property"             { return PROPERTY; }
"resistor"|"capacitor"|"inductor"|"transistor" { yylval.string = strdup(yytext); return TYPE; }
[R][1-9][0-9]*        { yylval.string = strdup(yytext); return ID; }
"pin1"|"pin2"         { yylval.string = strdup(yytext); return PIN; }
[a-zA-Z_][a-zA-Z0-9_]* { yylval.string = strdup(yytext); return ID; }
[0-9]+[uU]?[fF]?      { yylval.string = strdup(yytext); return VALUE; }
[ \t\n]               { /* skip whitespace */ }
.                     { printf("Unknown character: %s\n", yytext); }
%%

int yywrap(void) {
    return 1;
}