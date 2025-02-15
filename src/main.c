#include "pipex.h"
#include <time.h>

int	main(int argc, char **argv)
{
	(void)argc;
	(void)argv;
	int	id = fork();

	if (id != 0)
		wait(&id);
	printf("%d", id);
	fflush(stdout);
	if (id != 0)
		printf("\n");
	return (0);
}
