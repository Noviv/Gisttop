if exist E:\Program Files (x86)\Visual Studio\VC\vcvarsall.bat (
	call "E:\Program Files (x86)\Visual Studio\VC\vcvarsall.bat"
    goto FOUND
) else (
	if exist C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat (
		call "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat"
		echo Running VS14
		goto FOUND
	) else (
		if exist C:\Program Files (x86)\Microsoft Visual Studio 12.0\VC\vcvarsall.bat (
			call "C:\Program Files (x86)\Microsoft Visual Studio 12.0\VC\vcvarsall.bat"
			echo Running VS12
			goto FOUND
		) else (
			if exist C:\Program Files (x86)\Microsoft Visual Studio 11.0\VC\vcvarsall.bat (
				call "C:\Program Files (x86)\Microsoft Visual Studio 11.0\VC\vcvarsall.bat"
				echo Running VS11
				goto FOUND
			) else (
				if exist C:\Program Files (x86)\Microsoft Visual Studio 10.0\VC\vcvarsall.bat (
					call "C:\Program Files (x86)\Microsoft Visual Studio 10.0\VC\vcvarsall.bat"
					echo Running VS10
					goto FOUND
				) else (
					if exist C:\Program Files (x86)\Microsoft Visual Studio 9.0\VC\vcvarsall.bat (
						call "C:\Program Files (x86)\Microsoft Visual Studio 9.0\VC\vcvarsall.bat"
						echo Running VS9
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
cl ../src/main.c /I../libgit2/include /link ../libgit2/build/Debug/git2.lib /OUT:..\main.exe
copy "..\libgit2\build\Debug\git2.dll" "..\git2.dll"

if not exist ..\main.exe (
	echo DID NOT BUILD main.exe
	thisbuildfailed
)