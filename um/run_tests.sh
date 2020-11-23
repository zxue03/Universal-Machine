#! /bin/sh
make all
./writetests
mv *.um tests
mv *.0 tests
mv *.1 tests
cd tests
testFiles=$(ls *.um)
echo $testFiles
