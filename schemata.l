%{
#include "schemata.tab.h"
#include <string.h>
%}

%%

"component"             { return COMPONENT; }
"connection"            { return CONNECTION; }
"property"              { return PROPERTY; }
"resistor"|"capacitor"|"inductor"|"transistor" { return TYPE; }
[R][1-9][0-9]*          { return ID; }             // Matches identifiers like R1, R2, etc.
[a-zA-Z_][a-zA-Z0-9_]*  { return ID; }             // Matches names like resistance, capacitance, etc.
[0-9]+[uU]?[fF]?        { return VALUE; }          // Matches numerical values, with optional units (e.g., 100, 10uF)
[ \t\n]                 { /* skip whitespace */ }
.                       { printf("Unknown character: %s\n", yytext); }

%%
