if [ ! -d "../libgit2/build" ]
then
	echo -- Building Libgit2...
	cd ../libgit2
	mkdir build && cd build
	cmake -DBUILD_CLAR=OFF ..
	cmake --build .
	cd ..
	cd ..
	cd scripts
fi

echo -- Setting up Gisttop build space...
mkdir ../src/c/nlg2

echo -- Creating clone of main...
cp ../src/c/main.c ../src/c/nlg2/main.c
touch ../src/c/nlg2/main.c.new
tail -n +3 ../src/c/nlg2/main.c > ../src/c/nlg2/main.c.new
mv ../src/c/nlg2/main.c.new ../src/c/nlg2/main.c

echo -- Creating clone of all other files...
cp -a ../src/c/*.c ../src/c/nlg2/*.c

echo -- Building Gisttop with Libgit2...
gcc -Wall -I../libgit2/include -I../src/include/*.h ../src/c/*.c -L../libgit2/build -lgit2 -o ../main

echo -- Building Gisttop without Libgit2...
gcc -Wall ../src/c/nlg2/*.c -o ../main_nlg2

echo -- Cleaning up non-Libgit2 build...
rm -rf ../src/c/nlg2
rm -rf ../src/include/nlg2
