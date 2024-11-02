# Compiler and flags
CC = gcc
CFLAGS = -Wall
LIBS = -lfl

# Build targets
TARGET = schemata
GENERATED = lex.yy.c schemata.tab.c schemata.tab.h

# Default target
all: $(TARGET)

# Build the final executable
$(TARGET): lex.yy.c schemata.tab.c
	$(CC) $(CFLAGS) schemata.tab.c lex.yy.c -o $(TARGET) $(LIBS)

# Generate parser from Bison grammar
schemata.tab.c schemata.tab.h: schemata.y
	bison -d schemata.y

# Generate lexer from Flex rules
lex.yy.c: schemata.l schemata.tab.h
	flex schemata.l

# Clean generated files
clean:
	rm -f $(TARGET) $(GENERATED)

# Run the program with test input
test: $(TARGET)
	./$(TARGET) < test.scm

# Phony targets
.PHONY: all clean test