if [ ! -d "bin" ]; then
	mkdir bin
fi

if [ -f "lex.yy.c" ]; then
	mkdir lex.yy.c
fi

if [ -f "calculator.tab.c" ]; then
	mkdir calculator.tab.c
fi

if [ -f "calculator.tab.h" ]; then
	mkdir calculator.tab.h
fi

bison -d src/calculator.y
flex src/token.l
gcc -o bin/calculator calculator.tab.c lex.yy.c -lm
rm lex.yy.c calculator.tab.c calculator.tab.h