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

echo -- Creating clone to build without Libgit2...
cp ../src/c/main.c ../src/c/main_nlg2.c
touch ../src/c/main_nlg2.c.new
tail -n +3 ../src/c//main_nlg2.c > ../src/c/main_nlg2.c.new
mv ../src/c/main_nlg2.c.new ../src/c/main_nlg2.c

echo -- Building Gisttop with Libgit2...
gcc -Wall -I../libgit2/include -I../src/include/*.h ../src/c/*.c -L../libgit2/build -lgit2 -o ../main

echo -- Building Gisttop without Libgit2...
gcc -Wall -I../src/include/*.h ../src/c/main_nlg2.c -o ../main_nlg2

echo -- Cleaning up non-Libgit2 build...
rm ../src/c/main_nlg2.c
