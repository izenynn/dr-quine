/*
 * Outside comment
 */

#include <stdio.h>

static void foo(void)
{
	(void)0;
}

int main(void)
{
	/*
	 * Inside comment
	 */

	const char *s =
		"/*%3$c * Outside comment%3$c */%3$c%3$c#include <stdio.h>%3$c%3$cstatic void foo(void)%3$c{%3$c%2$c(void)0;%3$c}%3$c%3$cint main(void)%3$c{%3$c%2$c/*%3$c%2$c * Inside comment%3$c%2$c */%3$c%3$c%2$cconst char *s =%3$c%2$c%2$c%4$c%1$s%4$c;%3$c%3$c%2$cfoo();%3$c%2$cprintf(s, s, 9, 10, 34);%3$c%3$c%2$creturn 0;%3$c}%3$c";

	foo();
	printf(s, s, 9, 10, 34);

	return 0;
}
