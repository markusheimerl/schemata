#include "circuit.h"
#include <string.h>

void start_graph(FILE* fp) {
    fprintf(fp, "digraph Circuit {\n");
    fprintf(fp, "  rankdir=LR;\n");
    fprintf(fp, "  node [shape=none];\n");
    fprintf(fp, "  edge [dir=none];\n");
}

void add_component(FILE* fp, const char* type, const char* id) {
    if (strcmp(type, "transistor") == 0) {
        // Special case for transistors with 3 pins
        fprintf(fp, "  %s [label=<<table border=\"0\" cellborder=\"1\" cellspacing=\"0\">\n", id);
        fprintf(fp, "    <tr><td port=\"pin1\">1</td><td rowspan=\"2\">%s<br/>%s</td><td port=\"pin2\">2</td></tr>\n",
                id, type);
        fprintf(fp, "    <tr><td></td><td port=\"pin3\">3</td></tr>\n");
        fprintf(fp, "    </table>>];\n");
    } else {
        // Standard 2-pin components
        fprintf(fp, "  %s [label=<<table border=\"0\" cellborder=\"1\" cellspacing=\"0\">\n", id);
        fprintf(fp, "    <tr><td port=\"pin1\">1</td><td>%s<br/>%s</td><td port=\"pin2\">2</td></tr>\n",
                id, type);
        fprintf(fp, "    </table>>];\n");
    }
}

void add_connection(FILE* fp, const char* from_component, const char* from_pin,
                   const char* to_component, const char* to_pin) {
    // Connect components using their ports
    fprintf(fp, "  %s:%s -> %s:%s;\n", 
            from_component, from_pin, to_component, to_pin);
}

void end_graph(FILE* fp) {
    fprintf(fp, "}\n");
}