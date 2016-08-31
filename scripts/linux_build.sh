if [[ ! -d "../libgit2/build" ]]
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

echo -- Building Gisttop...
gcc -Wall -I../libgit2/include ../src/main.c -L../libgit2/build -lgit2 -o ../main
