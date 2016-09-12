#define USING_LIBGIT2

//x-platform headers
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdarg.h>
#include <time.h>
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

//send test notification
void notify(const char* msg, ...);

// PROGRAM FLOW FUNCTIONS
//init Gisttop and Libgit2 (if necessary)
void gisttop_init();

//start notification loop
void loop(const char* repo_path);

//shutdown Gisttop and Libgit2 (if necessary)
void gisttop_shutdown();

void loop(const char* repo_path) {
	notify("Starting Gisttop notifications...");
#ifdef USING_LIBGIT2
	//TODO Libgit2 implemenentation of notification loop
#else
	//TODO system implementation of notification loop
#endif
}

void gisttop_shutdown() {
#ifdef USING_LIBGIT2
	git_libgit2_shutdown();
#endif
}

int main(int argc, char* argv[]) {
	if (argc < 2) {
		notify("usage: main <git directory>\n%s", "\t <git directory> path to git directory");
		return 0;
	}

	gisttop_init();

	notify("Starting Gisttop with directory: %s", argv[argc - 1]);

	if (_dir_exist(argv[argc - 1]) == false) {
		notify("Directory does not exist!");
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
		notify("Directory is not a git repository!");
		return 0;
	}

	loop(argv[argc - 1]);

	gisttop_shutdown();

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
//unix
	struct stat status;
	stat(path, &status);
	return S_ISDIR(status.st_mode);
#endif
}

time_t timer;
char t_buffer[26];
struct tm* tm_info;

void notify(const char* msg, ...) {
	//format input string
	char f_msg[100];
	va_list args;
	va_start(args, msg);
	vsnprintf(f_msg, sizeof(f_msg), msg, args);
	va_end(args);

	//grab timestamp
	time(&timer);
	tm_info = localtime(&timer);
	strftime(t_buffer, 26, "%H:%M:%S", tm_info);

	printf("[Gisttop] at %s says:\n\t%s\n", t_buffer, f_msg);
}

void gisttop_init() {
#ifdef USING_LIBGIT2
	git_libgit2_init();
#endif
}
