echo - Building Gisttop
./linux_build.sh

echo - Setting LD_LIBRARY_PATH for dynamic linking...
export LD_LIBRARY_PATH=$(readlink -f ../libgit2/build)

echo - Running Gisttop...
echo ---------------- START
../main $@
echo ---------------- FINISH
