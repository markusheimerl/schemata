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
%token <string> TYPE ID VALUE PIN PROP_NAME

%%
schematic: {
    dot_file = fopen("circuit.dot", "w");
    start_graph(dot_file);
} 
statements {
    end_graph(dot_file);
    fclose(dot_file);
} ;

statements: statement
         | statements statement
         ;

statement: component_decl
        | connection_decl
        | property_decl
        ;

component_decl: COMPONENT TYPE ID {
    add_component(dot_file, $2, $3);
    free($2);
    free($3);
} ;

connection_decl: CONNECTION ID PIN ID PIN {
    add_connection(dot_file, $2, $3, $4, $5);
    free($2);
    free($3);
    free($4);
    free($5);
} ;

property_decl: PROPERTY PROP_NAME VALUE {
    // Store properties if needed
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