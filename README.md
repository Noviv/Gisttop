'# Gisttop
desktop application that sends notifications when git repos are updated

# Build Status
Gisttop only tests build on the *build* branch.

OS | *master*
:---:|:---:
Windows | (no build system)
Linux | [![Build Status](https://travis-ci.org/Noviv/Gisttop.svg?branch=master)](https://travis-ci.org/Noviv/Gisttop)

# X-platform Building
## Windows
~~~~
cl main.c /I.../libgit2/include /link .../libgit2/build/Debug/git2.lib /OUT:main.exe
~~~~
## Linux
~~~~
gcc -I.../libgit2/include main.c -L.../libgit2/build -lgit2 -o main
~~~~
