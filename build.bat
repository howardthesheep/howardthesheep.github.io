rem Set Directory Paths
set hamlDir=html
set sassDir=css
set outputDir=build

rem Create Build Directory
if exist %outputDir% rmdir /S /Q %outputDir% 
if not exist %outputDir% mkdir %outputDir% 

rem  Compile HAML
if not exist %outputDir%\html mkdir %outputDir%\html
call haml %hamlDir%\index.haml %outputDir%\index.html
call haml %hamlDir%\*.haml %outputDir%\html

rem Compile Sass
call sass --style=compressed %sassDir%:%outputDir%\css
