#ifndef CIRCUIT_H
#define CIRCUIT_H

#include <stdio.h>

void start_graph(FILE* fp);
void add_component(FILE* fp, const char* type, const char* id);
void add_connection(FILE* fp, const char* from_component, const char* from_pin, 
                   const char* to_component, const char* to_pin);
void end_graph(FILE* fp);

#endif