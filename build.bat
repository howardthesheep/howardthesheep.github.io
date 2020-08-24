@echo off
echo Setting Directory Paths...
set hamlDir=html
set sassDir=css
set outputDir=build
set imgDir=img
set jsDir=js

echo.
echo Creating Build Directory..
if exist %outputDir% rmdir /S /Q %outputDir% 
if not exist %outputDir% mkdir %outputDir% 

echo.
echo Moving images into Build Directory...
robocopy %imgDir% %outputDir%\%imgDir% /E /NJH /NJS /NFL /NDL

echo.
echo Moving js into Build Directory...
robocopy %jsDir% %outputDir%\%jsDir% /E /NJH /NJS /NFL /NDL

echo.
echo Compiling HAML
if not exist %outputDir%\html mkdir %outputDir%\html
for /f %%f in ('dir /b %hamlDir%') do call haml --trace %hamlDir%\%%f %outputDir%\html\%%~nf.html
move %outputDir%\%hamlDir%\index.html %outputDir%\

echo.
echo Compiling Sass
call sass --style=compressed %sassDir%:%outputDir%\css
