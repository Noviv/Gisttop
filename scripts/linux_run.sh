export LD_LIBRARY_PATH=$(readlink -f ../libgit2/build)
echo $LD_LIBRARY_PATH
../main $@
