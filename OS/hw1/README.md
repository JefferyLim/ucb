Jeffery Lim - 102398330
Jeli4328@colorado.edu

INSTRUCTIONS TO BUILD:
	gcc testSyscall.c -o test

INSTRUCTIONS TO RUN:
	./test number1 number2
	sudo tail /var/log/syslog
	
	example: ./test 1 2 -> gives us 1 + 2 = 3

FILE TREE
	README.md -> THIS
	testSyscall.c -> test program
	syslog -> tail of the syslog after running the test program several times
	kernelsource/ 
		Simple_add.c -> The syscall for adding two numbers, number1, number2, and returns result to pointer result
		Makefile -> Makefile for the kernel with updated syscalls at lines 44,45
		syscall_64.tbl -> Added syscalls numbers (326 and 327)
		syscalls.h -> Added syscalls to header at end


