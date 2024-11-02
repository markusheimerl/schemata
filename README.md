# schemata
Blueprints in Code, Circuits in Syntax

1. Install dependencies
```
sudo apt update && sudo apt install -y bison flex
```

2. Generate parser + lexer and compile
```
bison -d schemata.y && flex schemata.l && gcc schemata.tab.c lex.yy.c -o schemata -lfl
```

3. Check schematic text representation for correct syntax
```
./schemata < test.scm
```