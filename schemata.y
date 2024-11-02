%{
#include <stdio.h>
#include <stdlib.h>
%}

%token COMPONENT CONNECTION PROPERTY TYPE ID VALUE

%%

schematic: components connections ;

components: component
          | components component ;

component: COMPONENT TYPE ID properties ;

connections: connection
           | connections connection ;

connection: CONNECTION ID ID ;

properties: property
          | properties property ;

property: PROPERTY ID VALUE ;

%%

int yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
    return 0;
}

int main() {
    return yyparse();
}
