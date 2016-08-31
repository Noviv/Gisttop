echo - Building Gisttop
./linux_build.sh

if [[ $1 == "-n" ]]
then
	echo - Skipping LD_LIBRARY_PATH definition...
else
	echo - Setting LD_LIBRARY_PATH for dynamic linking...
	export LD_LIBRARY_PATH=$(readlink -f ../libgit2/build)
fi

echo - Running Gisttop...
echo ---------------- START
../main $@
echo ---------------- FINISH
