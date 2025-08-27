#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int n = 5;

int main(void)
{
	const char *s =
		"#include <stdio.h>%3$c#include <stdlib.h>%3$c#include <string.h>%3$c%3$cint n = %5$d;%3$c%3$cint main(void)%3$c{%3$c%2$cconst char *s =%3$c%2$c%2$c%4$c%1$s%4$c;%3$c%2$cchar self[64], src[64], bin[64], cmd[256];%3$c%3$c%2$csnprintf(self, sizeof(self), %4$csully_%%d.c%4$c, n);%3$c%2$cif (strcmp(self, __FILE__) == 0)%3$c%2$c%2$c--n;%3$c%3$c%2$cif (n < 0)%3$c%2$c%2$creturn 0;%3$c%3$c%2$csnprintf(src, sizeof(src), %4$csully_%%d.c%4$c, n);%3$c%2$csnprintf(bin, sizeof(bin), %4$csully_%%d%4$c, n);%3$c%3$c%2$cFILE *f = fopen(src, %4$cw%4$c);%3$c%2$cif (f == NULL)%3$c%2$c%2$creturn 1;%3$c%3$c%2$cfprintf(f, s, s, 9, 10, 34, n);%3$c%2$cfclose(f);%3$c%3$c%2$csnprintf(cmd, sizeof(cmd), %4$cgcc %%s -o %%s%4$c, src, bin);%3$c%2$cif (system(cmd) != 0)%3$c%2$c%2$creturn 1;%3$c%3$c%2$csnprintf(cmd, sizeof(cmd), %4$c./%%s%4$c, bin);%3$c%2$cif (system(cmd) != 0)%3$c%2$c%2$creturn 1;%3$c%3$c%2$creturn 0;%3$c}%3$c";
	char self[64], src[64], bin[64], cmd[256];

	snprintf(self, sizeof(self), "sully_%d.c", n);
	if (strcmp(self, __FILE__) == 0)
		--n;

	if (n < 0)
		return 0;

	snprintf(src, sizeof(src), "sully_%d.c", n);
	snprintf(bin, sizeof(bin), "sully_%d", n);

	FILE *f = fopen(src, "w");
	if (f == NULL)
		return 1;

	fprintf(f, s, s, 9, 10, 34, n);
	fclose(f);

	snprintf(cmd, sizeof(cmd), "gcc %s -o %s", src, bin);
	if (system(cmd) != 0)
		return 1;

	snprintf(cmd, sizeof(cmd), "./%s", bin);
	if (system(cmd) != 0)
		return 1;

	return 0;
}
