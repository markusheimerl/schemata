# Compiler and flags
CC = gcc
CFLAGS = -Wall -g
LIBS = -lfl

# Build targets
TARGET = schemata
GENERATED = lex.yy.c schemata.tab.c schemata.tab.h
OBJECTS = circuit.o

# Default target
all: $(TARGET)

# Build the final executable
$(TARGET): lex.yy.c schemata.tab.c $(OBJECTS)
	$(CC) $(CFLAGS) -o $(TARGET) schemata.tab.c lex.yy.c $(OBJECTS) $(LIBS)

# Generate parser from Bison grammar
schemata.tab.c schemata.tab.h: schemata.y
	bison -d schemata.y

# Generate lexer from Flex rules
lex.yy.c: schemata.l schemata.tab.h
	flex schemata.l

# Compile circuit.c
circuit.o: circuit.c circuit.h
	$(CC) $(CFLAGS) -c circuit.c

# Clean generated files
clean:
	rm -f $(TARGET) $(GENERATED) $(OBJECTS) circuit.dot circuit.png

# Generate and view circuit diagram
view: $(TARGET)
	./$(TARGET) < test.scm
	dot -Tpng circuit.dot -o circuit.png

# Phony targets
.PHONY: all clean view