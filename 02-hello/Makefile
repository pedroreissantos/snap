all:
	flex -l scan.l
	byacc -dv gram.y
	gcc -o howto lex.yy.c y.tab.c
%: %.how
	./howto $<
	nasm -felf out.asm
	gcc out.o -o $@
clean:
	rm -f lex.yy.c y.tab.h y.tab.c y.output a.out howto out.asm out.o
