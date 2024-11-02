%{
#include <stdio.h>
#include <stdlib.h>
#include "circuit.h"

FILE* dot_file;
int yylex(void);
void yyerror(const char *s);
%}

%union {
    char* string;
}

%token COMPONENT CONNECTION PROPERTY
%token <string> TYPE ID VALUE

%%
schematic: {
    dot_file = fopen("circuit.dot", "w");
    start_graph(dot_file);
} 
components connections {
    end_graph(dot_file);
    fclose(dot_file);
} ;

components: component
          | components component ;

component: COMPONENT TYPE ID properties {
    add_component(dot_file, $2, $3);
    free($2);  // Free allocated strings
    free($3);
} ;

connections: connection
           | connections connection ;

connection: CONNECTION ID ID {
    add_connection(dot_file, $2, $3);
    free($2);  // Free allocated strings
    free($3);
} ;

properties: property
          | properties property ;

property: PROPERTY ID VALUE {
    free($2);  // Free allocated strings
    free($3);
} ;
%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main(void) {
    return yyparse();
}