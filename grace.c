/*
 * Outside comment
 */

#include <stdio.h>

#define F "grace_kid.c"
#define S "/*%2$c * Outside comment%2$c */%2$c%2$c#include <stdio.h>%2$c%2$c#define F %3$cgrace_kid.c%3$c%2$c#define S %3$c%1$s%3$c%2$c#define MAIN() int main(void) { const char *s = S; FILE *f = fopen(F, %3$cw%3$c); if (f == NULL) return 1; fprintf(f, s, s, 10, 34); fclose(f); return 0; }%2$c%2$cMAIN()%2$c"
#define MAIN() int main(void) { const char *s = S; FILE *f = fopen(F, "w"); if (f == NULL) return 1; fprintf(f, s, s, 10, 34); fclose(f); return 0; }

MAIN()
