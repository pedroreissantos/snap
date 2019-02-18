all:
	flex -l scan.l
	byacc -dv gram.y
	pburg -T code.brg
	gcc -I../lib -o snap lex.yy.c y.tab.c yyselect.c ../lib/node.c
	make -C ../runtime install
%: %.snp
	./snap $<
	nasm -felf64 out.asm
	gcc -o out out.o ../runtime/librun.a
clean:
	rm -f lex.yy.c y.tab.h y.tab.c y.output yyselect.c a.out snap out.asm out.o
