c:
cd \
for /f "delims=" %%a in ('dir C:\vcvarsall.bat /s /b') do set exeLcn=%%a
"%exeLcn%"
cl ../src/main.c /I../libgit2/include /link ../libgit2/build/Debug/git2.lib /OUT:main.exe