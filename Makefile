all:
	for i in [0-9]*; do make -C $$i; done
x64:
	if [ -f 02-hello/gram32.y ]; then echo "already in 64-bit mode"; exit 1; fi
	mv 02-hello/gram.y 02-hello/gram32.y; mv 02-hello/x86_64.y 02-hello/gram.y 
	for i in */code64.brg; do mv `dirname $$i`/code.brg `dirname $$i`/code32.brg; mv $$i `dirname $$i`/code.brg; done
	for i in */Makefile; do sed -e "s/-felf/-felf64/" < $$i > tmp; mv tmp $$i; done
	sed -e "s/SYS=linux32/SYS=linux64/" < runtime/Makefile > tmp; mv tmp runtime/Makefile
x32:
	if [ -f 02-hello/x86_64.y ]; then echo "already in 32-bit mode"; exit 1; fi
	mv 02-hello/gram.y 02-hello/x86_64.y; mv 02-hello/gram32.y  02-hello/gram.y
	for i in */code32.brg; do mv `dirname $$i`/code.brg `dirname $$i`/code64.brg; mv $$i `dirname $$i`/code.brg; done
	for i in */Makefile; do sed -e "s/-felf64/-felf/" < $$i > tmp; mv tmp $$i; done
	sed -e "s/SYS=linux64/SYS=linux32/" < runtime/Makefile > tmp; mv tmp runtime/Makefile
clean:
	for i in [0-9]* lib runtime; do make -C $$i clean; done
	rm -f librun.a runtime/librun.a
