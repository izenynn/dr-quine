/*
 * Outside comment
 */

#include <stdio.h>

#define F "grace_kid.c"
#define S "/*%3$c * Outside comment%3$c */%3$c%3$c#include <stdio.h>%3$c%3$c#define F %4$cgrace_kid.c%4$c%3$c#define S %4$c%1$s%4$c%3$c#define MAIN() int main(void) { const char *s = S; FILE *f = fopen(F, %4$cw%4$c); if (f == NULL) return 1; fprintf(f, s, s, 9, 10, 34); fclose(f); return 0; }%3$c%3$cMAIN()%3$c"
#define MAIN() int main(void) { const char *s = S; FILE *f = fopen(F, "w"); if (f == NULL) return 1; fprintf(f, s, s, 9, 10, 34); fclose(f); return 0; }

MAIN()
