/* instead of runtime, after 'nasm' use: gcc xy.o libsnp.c */
#include <stdio.h>
extern int _main();
int main() { return _main(); }
int _printi(int i) { return printf("%d", i); }
int _prints(char *s) { return printf("%s", s); }
int _println() { return printf("\n"); }
