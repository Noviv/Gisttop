if [[ ! -d "../libgit2/build" ]]; then
	-- echo Building Libgit2...
	cd ../libgit2
	mkdir build && cd build
	cmake -DBUILD_CLAR=OFF ..
	cmake --build .
	cd ..
	cd ..
	cd scripts
fi

echo -- Building Gisttop without Libgit2...
export GISTTOP_BUILD_WITH_LIBGIT2=0
gcc -Wall -I../libgit2/include ../src/main.c -L../libgit2/build -lgit2 -o ../main

echo -- Building Gisttop with Libgit2...
export GISTTOP_BUILD_WITH_LIBGIT2=1
gcc -Wall -I../libgit2/include ../src/main.c -L../libgit2/build -lgit2 -o ../main

echo -- Cleaning up Gisttop build system...
export GISTTOP_BUILD_WITH_LIBGIT2=
