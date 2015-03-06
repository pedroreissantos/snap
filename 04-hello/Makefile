all:
	flex -l scan.l
	byacc -dv gram.y
	pburg -T code.brg
	gcc -I../lib -o howto lex.yy.c y.tab.c yyselect.c ../lib/node.c
%: %.how
	./howto $<
	nasm -felf out.asm
	gcc out.o -o $@
clean:
	rm -f lex.yy.c y.tab.h y.tab.c y.output yyselect.c a.out howto out.asm out.o
