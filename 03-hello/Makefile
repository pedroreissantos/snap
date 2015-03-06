S=.s # use 'make S=.asm' for nasm generated code

all:
	flex -l scan.l
	byacc -dv gram.y
	gcc -o howto lex.yy.c y.tab.c
%: %.how
	./howto $<
	# gcc out$S -o $@ # let gcc assemble and link
	as -o out.o out$S # call the assembler directly
	gcc out.o -o $@   # use gcc to link (bootstrap and libc)
clean:
	rm -f lex.yy.c y.tab.h y.tab.c y.output a.out howto out.asm out.s out.o
