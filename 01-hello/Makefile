all:
	flex -l scan.l
	byacc -dv gram.y
	gcc lex.yy.c y.tab.c
clean:
	rm -f lex.yy.c y.tab.h y.tab.c y.output a.out
