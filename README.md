# Gisttop
desktop application that sends notifications when git repos are updated


# X-platform Building
## Windows
~~~~
cl /I.../libgit2/include /LIBPATH:.../build /Femain.exe main.c
~~~~
## Linux
~~~~
gcc -I.../libgit2/include main.c -L.../libgit2/build -lgit2 -o main
~~~~
