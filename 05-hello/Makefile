all:
	flex -l scan.l
	byacc -dv gram.y
	pburg -T code.brg
	gcc -I../lib -o snap lex.yy.c y.tab.c yyselect.c ../lib/node.c
	make -C ../runtime install
%: %.snp
	./snap $<
	nasm -felf out.asm
	ld -o out out.o ../librun.a
clean:
	rm -f lex.yy.c y.tab.h y.tab.c y.output yyselect.c a.out snap out.asm out.o
