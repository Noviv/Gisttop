dir/s/b vcvarsall.bat
cl ../src/main.c /I../libgit2/include /link ../libgit2/build/Debug/git2.lib /OUT:main.exe