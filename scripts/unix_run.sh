if [[ $1 == "-n" ]]
then
	echo - Skipping LD_LIBRARY_PATH definition...
	echo - Running Gisttop without Libgit2...

	echo ------------- START
	../main_nlg2 $@
	echo ------------- FINISH
else
	echo - Setting LD_LIBRARY_PATH for dynamic linking...
	export LD_LIBRARY_PATH=$(readlink -f ../libgit2/build)
	echo - Running Gisttop with Libgit2...

	echo ------------- START
	../main $@
	echo ------------- FINISH
fi
