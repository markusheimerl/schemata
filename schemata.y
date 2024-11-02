%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "circuit.h"

FILE* dot_file;
int yylex(void);
void yyerror(const char *s);
%}

%union {
    char* string;
}

%token COMPONENT CONNECTION PROPERTY
%token <string> TYPE ID VALUE PIN

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
    free($2);
    free($3);
} ;

connections: connection
           | connections connection ;

connection: CONNECTION ID PIN ID PIN {
    // Parse component and pin identifiers
    add_connection(dot_file, $2, $3, $4, $5);
    free($2);
    free($3);
    free($4);
    free($5);
} ;

properties: property
          | properties property ;

property: PROPERTY ID VALUE {
    free($2);
    free($3);
} ;
%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main(void) {
    return yyparse();
}