//x-platform headers
#include <stdio.h>
#include <string.h>
//sys headers
#include <sys/types.h>
#include <sys/stat.h>
//io headers
#ifdef _WIN32
#include <io.h>
#else
#include <unistd.h>
#endif

//git headers
#include "git2.h"

typedef int bool;
#define true 1
#define false 0

bool _dir_exist(const char* path) {
	struct stat path_stat;
	stat(path, &path_stat);
	return S_ISDIR(path_stat.st_mode);
}

bool _file_exist(const char* path) {
	struct stat path_stat;
	stat(path, &path_stat);
	return S_ISREG(path_stat.st_mode);
}

int main(int argc, char* argv[]) {
	if (argc < 2) {
		printf("need more args\n");
		return 0;
	}

	printf("git repo: %s\n", argv[1]);

	if (_dir_exist(argv[1]) == false) {
		printf("does not exist\n");
		return 0;
	}

	char* testdir = strcat(argv[1], "/.git");

	printf("newdir: %s\n", testdir);

	if (_dir_exist(testdir) == false) {
		printf("is not a git repo\n");
		return 0;
	}

	git_libgit2_init();

	git_libgit2_shutdown();
	return 0;
}
