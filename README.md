Compiler development with flex, byacc e pburg
Pedro Reis dos Santos
January 2015

Envirnment: linux (32 or 64 bits)
Tools: flex, byaac, pburg, gcc, make, nasm.

Before you begin, please ensure that all the tools are installed and acessible through the PATH environment variable.
The distribution is prepared for 32 bit operating systems.
The 32 bit distribution can be used in a 64 bit environment by adding the options '-m32' to 'gcc' (gg -m32) and '-m elf_i386' to 'ld' (ld -m elf_i386), while using '-felf32' in 'nasm'.
In order to produce 64 bit code, only usable in 64 bit machines, execute 'make x64' in the main directory. If you want to switch back into the 32 bit compiler do 'make x32'.

The document howto.txt includes a description of the development objectives and file contents of each directory.
Please follow the numerical order of the directories.
Each directory includes a Makefile, but not all the development possibilities are covered by the Makefile.
Look at the files used in each directory as well as the diferences to the previous directory.
The global objectives of each directory are stated below.

01-hello lex + yacc; syntax only with and without debug; print one string
02-hello generate nasm-i386 syntax directed with gcc runtime
03-hello generate gas-arm syntax directed with gcc runtime (use android or GNUarm)
04-hello burg selection with Node syntax tree
05-hello declaration of global string variables and print lists of strings (literal and variables)
06-hello symbol table controls duplicate global ids and missing print variables
07-add   new integer data type, with declaration of global integers and print of integer sum  expressions
08-add   optimize 'add' with integer literals, strength-reduce and constant-folding
09-add   via mnemonics ( compile with -DviaARM or -DviaAMD64 or -DviaI386GAS for other processors )
