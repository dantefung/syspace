#include <stdio.h>

int main(int argc, char *argv[])
{
	printf("Hello C-Free!\n");
	return 0;
}


long exchange(long *xp, long y) 
{
	long x = *xp;
	*xp = y;
	return x;
}
