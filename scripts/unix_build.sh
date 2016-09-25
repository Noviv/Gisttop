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
cp ../src/main.c ../src/main_nlg2.c
touch ../src/main_nlg2.c.new
tail -n +3 ../src/main_nlg2.c > ../src/main_nlg2.c.new
mv ../src/main_nlg2.c.new ../src/main_nlg2.c

echo -- Building Gisttop with Libgit2...
gcc -Wall -I../libgit2/include ../src/main.c -L../libgit2/build -lgit2 -o ../main

echo -- Building Gisttop without Libgit2...
gcc -Wall ../src/main_nlg2.c -o ../main_nlg2

echo -- Cleaning up non-Libgit2 build...
rm ../src/main_nlg2.c
