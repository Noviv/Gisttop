
if [[ $LD_LIBRARY_PATH != *"$(realpath ../libgit2/build)"* ]]; then export $LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(realpath ../libgit2/build); fi
gcc -Wall -I../libgit2/include ../src/main.c -L../libgit2/build -lgit2 -o ../main