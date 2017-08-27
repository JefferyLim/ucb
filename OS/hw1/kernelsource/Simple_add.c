#include <linux/kernel.h>
#include <linux/linkage.h>

asmlinkage long sys_Simple_add(int number1, int number2, int* result)
{
	printk(KERN_ALERT "Adding: %d + %d\n", number1, number2);
	*result = number1 + number2;
	printk(KERN_ALERT "Result: %d\n", *result);
	return 0;
}
