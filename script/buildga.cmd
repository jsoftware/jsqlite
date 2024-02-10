@rem build windows on github actions

cd makemsvc\jconsole
IF "%~1"=="x86" GOTO L02A
nmake -f makefile.win CC=clang-cl x64=1 clean
nmake -f makefile.win CC=clang-cl x64=1
IF %ERRORLEVEL% NEQ 0 EXIT /b %ERRORLEVEL%
GOTO L02B
:L02A
nmake -f makefile.win CC=clang-cl x64=0 clean
nmake -f makefile.win CC=clang-cl x64=0
IF %ERRORLEVEL% NEQ 0 EXIT /b %ERRORLEVEL%
:L02B
cd ..
cd jdll
IF "%~1"=="x86" GOTO L03A
nmake -f makefile.win CC=clang-cl x64=1 clean
nmake -f makefile.win CC=clang-cl x64=1
IF %ERRORLEVEL% NEQ 0 EXIT /b %ERRORLEVEL%
GOTO L03B
:L03A
nmake -f makefile.win CC=clang-cl x64=0 clean
nmake -f makefile.win CC=clang-cl x64=0
IF %ERRORLEVEL% NEQ 0 EXIT /b %ERRORLEVEL%
:L03B
cd ..

IF "%~1"=="x86" GOTO L06A
copy lib\jsqlite3.dll ..\j64
GOTO L06B
:L06A
copy lib\jsqlite3.dll ..\j32\.
:L06B
