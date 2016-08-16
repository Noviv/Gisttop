# Gisttop
desktop application that sends notifications when git repos are updated

# Build Status
Gisttop only tests build on the *build* branch.

OS | *master*
:---:|:---:
Windows | [![Build status](https://ci.appveyor.com/api/projects/status/0ogt6aq5h0hsibwx?svg=true)](https://ci.appveyor.com/project/Noviv/gisttop)
Linux | [![Build Status](https://travis-ci.org/Noviv/Gisttop.svg?branch=master)](https://travis-ci.org/Noviv/Gisttop)

# X-platform Building
## Windows
~~~~
cl main.c /I.../libgit2/include /link .../libgit2/build/Debug/git2.lib /OUT:main.exe
~~~~
## Linux (from the *scripts* directory)
~~~~
./build_linux.sh
~~~~
