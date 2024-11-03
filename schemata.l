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
[R|C|I|T][1-9][0-9]*    { yylval.string = strdup(yytext); return ID; }
"pin1"|"pin2"|"pin3"         { yylval.string = strdup(yytext); return PIN; }
[0-9]+("."[0-9]+)?[kKmMuUnNpP]?[ΩFHL]? { yylval.string = strdup(yytext); return VALUE; }
"resistance"|"capacitance"|"inductance" { yylval.string = strdup(yytext); return PROP_NAME; }
[ \t\n]               { /* skip whitespace */ }
.                     { printf("Unknown character: %s\n", yytext); }
%%

int yywrap(void) {
    return 1;
}