if exist "E:\Program Files (x86)\Visual Studio\VC\vcvarsall.bat" (
	echo RUNNING custom VS
	call "E:\Program Files (x86)\Visual Studio\VC\vcvarsall.bat"
    goto FOUND
) else (
	if exist "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat" (
		echo Running VS14
		call "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat"
		goto FOUND
	) else (
		if exist "C:\Program Files (x86)\Microsoft Visual Studio 12.0\VC\vcvarsall.bat" (
			echo Running VS12
			call "C:\Program Files (x86)\Microsoft Visual Studio 12.0\VC\vcvarsall.bat"
			goto FOUND
		) else (
			if exist "C:\Program Files (x86)\Microsoft Visual Studio 11.0\VC\vcvarsall.bat" (
				echo Running VS11
				call "C:\Program Files (x86)\Microsoft Visual Studio 11.0\VC\vcvarsall.bat"
				goto FOUND
			) else (
				if exist "C:\Program Files (x86)\Microsoft Visual Studio 10.0\VC\vcvarsall.bat" (
					echo Running VS10
					call "C:\Program Files (x86)\Microsoft Visual Studio 10.0\VC\vcvarsall.bat"
					goto FOUND
				) else (
					if exist "C:\Program Files (x86)\Microsoft Visual Studio 9.0\VC\vcvarsall.bat" (
						echo Running VS9
						call "C:\Program Files (x86)\Microsoft Visual Studio 9.0\VC\vcvarsall.bat"
						goto FOUND
					) else (
						echo COULD NOT FIND vcvarsall.bat!
						thisbuildfailed
					)
				)
			)
		)
	)
)

:FOUND
echo Creating clone to build with Libgit2...
more +2 ../src/main.c > ../src/main_nlg2.c

echo Building Gisttop with Libgit2...
cl ../src/main.c /I../libgit2/include /link ../libgit2/build/Debug/git2.lib /OUT:..\main.exe
copy "..\libgit2\build\Debug\git2.dll" "..\git2.dll"

echo Build Gisttop without Libgit2...
cl ../src/main_nlg2.c /I../libgit2/include /link ../libgit2/build/Debug/git2.lib /OUT:..\main_nlg2.exe

if not exist ..\main.exe OR IF not exist ..\main_nlg2.exe (
	echo DID NOT BUILD main.exe
	thisbuildfailed
)
