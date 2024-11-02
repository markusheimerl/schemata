#include "circuit.h"

void start_graph(FILE* fp) {
    fprintf(fp, "digraph Circuit {\n");
    fprintf(fp, "  rankdir=LR;\n");
    fprintf(fp, "  node [shape=box];\n");
}

void add_component(FILE* fp, const char* type, const char* id) {
    fprintf(fp, "  %s [label=\"%s\\n(%s)\"];\n", id, id, type);
}

void add_connection(FILE* fp, const char* from, const char* to) {
    fprintf(fp, "  %s -> %s;\n", from, to);
}

void end_graph(FILE* fp) {
    fprintf(fp, "}\n");
}