.SUFFIXES: .brg .asm

COMPILER=snap
RUNTIME=../runtime/librun.a
UTIL=../lib/libutil.a

CC=gcc
CFLAGS=-g -I../lib -DYYDEBUG
LEX=flex
LFLAGS=-l
YACC=byacc
YFLAGS=-dv
BURG=pburg
BFLAGS=-T
LDLIBS=-L ../lib -lutil

all: $(COMPILER) $(RUNTIME)
$(COMPILER): scan.o gram.o code.o $(UTIL)
	$(LINK.c) -o $@ $^
$(UTIL):
	make -C ../lib
$(RUNTIME):
	make -C ../runtime install
.brg.c:
	$(BURG) $(BFLAGS) $< $@
%: %.snp
	./snap $<
	nasm -felf64 $*.asm
	gcc $*.o -o $@ ../runtime/librun.a
code.c: gram.c
scan.c: gram.c
clean:
	rm -f y.tab.h y.output snap *.asm *.o scan.c gram.c code.c
