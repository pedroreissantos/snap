LIB=util
CFLAGS=-g
CC=gcc
lib$(LIB).a: node.o tabid.o main.o
	ar crv $@ $?
clean:
	rm -f lib$(LIB).a *.o a.out core
