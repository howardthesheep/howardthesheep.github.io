#!/bin/bash
echo "Setting Directory Paths..."
hamlDir=html
sassDir=css
outputDir=build
imgDir=img


echo "Creating Build Directory..."
if test -d "$outputDir";
	then
		# OutputDir Exists already
		rm -rf $outputDir
fi

# Create outputDir and subdirectories
mkdir $outputDir
mkdir $outputDir/$hamlDir
mkdir $outputDir/$imgDir
mkdir $outputDir/$sassDir

echo "Moving images into Build Directory..."
cp $imgDir $outputDir/$imgDir

echo "Compiling Haml..."
for f in ./$hamlDir/*.haml; do
	# Get file name
	fname=${f##*/}
	# Remove .haml extension
	noext=${fname%.*}
	# Pump it into haml to be compiled to html...
	haml --trace $f $outputDir/$hamlDir/$noext.html
done
mv $outputDir/$hamlDir/index.html $outputDir/index.html

echo "Compiling Sass..."
sass $sassDir:$outputDir/$sassDir --trace --style=compressed
