all:
	flex -l scan.l
	byacc -dv gram.y
	gcc -o snap lex.yy.c y.tab.c
%: %.snp
	./snap $<
	nasm -felf out.asm
	gcc out.o -o $@
clean:
	rm -f lex.yy.c y.tab.h y.tab.c y.output a.out snap out.asm out.o
