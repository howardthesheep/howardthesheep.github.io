@echo off
echo "Setting Directory Paths..."
set hamlDir=html
set sassDir=css
set outputDir=build

echo "Creating Build Directory.."
if exist %outputDir% rmdir /S /Q %outputDir% 
if not exist %outputDir% mkdir %outputDir% 

echo "Compiling HAML"
if not exist %outputDir%\html mkdir %outputDir%\html
for /f %%f in ('dir /b %hamlDir%') do call haml --trace %hamlDir%\%%f %outputDir%\html\%%~nf.html
move %outputDir%\%hamlDir%\index.html %outputDir%\


echo "Compiling Sass"
call sass --style=compressed %sassDir%:%outputDir%\css
