# schemata
Blueprints in Code, Circuits in Syntax

```
sudo apt update && sudo apt install -y bison flex
```

```
bison -d schemata.y && flex schemata.l && gcc schemata.tab.c lex.yy.c -o schemata -lfl
```

```
./schemata < test.scm
```