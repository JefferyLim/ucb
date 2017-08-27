#include <stdio.h>
#include <sys/syscall.h>
#include <unistd.h>

long syscall(long number, ...);

int main(int argc, char ** argv){

	//input arguments are used to add the two numbers
	if(argc != 3){
		printf("error: use ./test number1 number2 where number1 and number2 are the two numbers to be added \n");
		return -1;
	}

	//syscall 326 represents hello world
	if(syscall(326) == 0){
		printf("sys_helloworld successful\n");
	}

	//convert argv to number1 and number2
	int number1 = atoi(argv[1]);
	int number2 = atoi(argv[2]);
	int* result = 0;
	
	//call syscall 327, which is Simple_add		
	if(syscall(327, number1, number2, &result) == 0){
		printf("sys_Simple_add successful\n");
		printf("Added %d + %d = %d\n", number1, number2, result); 
	}

	printf("Check syslog with sudo tail /var/log/syslog\n");
	
	return 0;
}
