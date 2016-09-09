#define USING_LIBGIT2

//x-platform headers
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
//sys headers
#include <sys/types.h>
#include <sys/stat.h>
//platform specific headers
#ifdef _WIN32
#include <io.h>
#include <windows.h>
#else
#include <unistd.h>
#endif

//non-system headers
#ifdef USING_LIBGIT2
#include "git2.h"
#endif

typedef int bool;
#define true 1
#define false 0

// UTILITY FUNCTIONS
//check if a directory exists
bool _dir_exist(const char* path);

// PROGRAM FLOW FUNCTIONS
//init Gisttop and Libgit2 (if necessary)
void init();

//start notification loop
void loop(const char* repo_path);

//shutdown Gisttop and Libgit2 (if necessary)
void shutdown();

int main(int argc, char* argv[]) {
	if (argc < 2) {
		printf("usage: main <git directory>\n");
		printf("\t <git directory> path to monitored git directory\n");
		return 0;
	}

	init();

	printf("Starting Gisttop with directory: %s\n", argv[argc - 1]);

	if (_dir_exist(argv[argc - 1]) == false) {
		printf("Directory does not exist!\n");
		return 0;
	}

#ifdef USING_LIBGIT2
	if (git_repository_open_ext(NULL, argv[argc - 1], GIT_REPOSITORY_OPEN_NO_SEARCH, NULL) != 0) {
#else
	char* checkdir = (char*) malloc(1 + strlen(argv[argc - 1]) + strlen("/.git"));
	strcpy(checkdir, argv[argc - 1]);
	strcat(checkdir, "/.git");
	if (_dir_exist(checkdir) == false) {
#endif
		printf("Directory is not a git repository!\n");
		return 0;
	}

	loop(argv[argc - 1]);

	shutdown();

	return 0;
}

bool _dir_exist(const char* path) {
#ifdef _WIN32
//win32
	if (_access(path, 0) == 0) {
		struct stat status;
		stat(path, &status);
		return (status.st_mode & S_IFDIR) != 0;
	}
	return false;
#else
//linux
	struct stat status;
	stat(path, &status);
	return S_ISDIR(status.st_mode);
#endif
}

void init() {
#ifdef _WIN32
	
#endif

#ifdef USING_LIBGIT2
	git_libgit2_init();
#endif
}

void loop(const char* repo_path) {
	printf("Starting Gisttop notifications...\n");
#ifdef USING_LIBGIT2
	//TODO Libgit2 implemenentation of notification loop
#else
	//TODO system implementation of notification loop
#endif
}

void shutdown() {
#ifdef USING_LIBGIT2
	git_libgit2_shutdown();
#endif
}
