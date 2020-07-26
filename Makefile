calc:calculator.y
	yacc -d calculator.y

calcl:calculator.l
	lex calculator.l

run:y.tab.c
	gcc y.tab.c -o example -ll -ly

start:
	./example < exampleprog.cl
