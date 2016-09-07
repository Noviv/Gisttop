#define USING_LIBGIT2

#ifdef __APPLE__
#error Apple is not yet tested
#endif

//x-platform headers
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
//sys headers
#include <sys/types.h>
#include <sys/stat.h>
//io headers
#ifdef _WIN32
#include <io.h>
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

//check if a directory exists
bool _dir_exist(const char* path);

//start notification loop
void loop(const char* repo_path);

int main(int argc, char* argv[]) {
	if (argc < 2) {
		printf("usage: main [-n] <git directory>\n");
		printf("\t <git directory> path to monitored git directory\n");
		return 0;
	}

#ifdef USING_LIBGIT2
	git_libgit2_init();
#endif

	printf("git repo: %s\n", argv[argc - 1]);

	if (_dir_exist(argv[argc - 1]) == false) {
		printf("does not exist\n");
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
		printf("is not a git repo\n");
		return 0;
	}

	loop(argv[argc - 1]);

#ifdef USING_LIBGIT2
	git_libgit2_shutdown();
#endif

	return 0;
}

void loop(const char* repo_path) {
#ifdef USING_LIBGIT2
	int error;
	git_repository* repo = NULL;
	git_remote* remote = NULL;

	error = git_repository_open_ext(&repo, repo_path, GIT_REPOSITORY_OPEN_NO_SEARCH, NULL);

	if (error < 0) {
		const git_error* e = giterr_last();
		printf("error %d/%d: %s\n", error, e->klass, e->message);
		return;
	}

	//do loopy stuff
	error = git_remote_lookup(&remote, repo, "origin");
	error = git_remote_fetch(remote, NULL, NULL, NULL);

	//check stuff

	git_repository_free(repo);
#endif
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
