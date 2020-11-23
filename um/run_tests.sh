#! /bin/sh
# set -x
make all
./writetests
cd tests
rm *.um
rm *.0
rm *.1
rm *.rf
rm *.mine
cd ../
mv *.um tests
mv *.0 tests
mv *.1 tests
cd tests
testFiles=$(ls *.um)
echo ""
allSucceed=1
echo "==========STARTING TESTS=========="
for testFile in $testFiles ; do
    testName=$(echo $testFile | sed -E 's/(.*).um/\1/')
    echo -n "Testing $testName..."
    if [ -e "$testName.0" ] ; then
        um "$testName.um" < "$testName.0" > "$testName.rf"
        ../um "$testName.um" < "$testName.0" > "$testName.mine"
    else
        um "$testName.um" > "$testName.rf"
        ../um "$testName.um" > "$testName.mine"
    fi
    diff "$testName.rf" "$testName.mine"
    code=$?
    if [ ! $code -eq 0 ] ; then
        echo ""
        echo "********ERROR********"
        echo "Diffing $testName.rf and $testName.mine failed."
        echo "********ERROR********"
        echo ""
        allSucceed=0
    fi
    if [ -e "$testName.1" ] ; then
        diff "$testName.rf" "$testName.1"
        code=$?
        if [ ! $code -eq 0 ] ; then
            echo ""
            echo "********ERROR********"
            echo "Diffing $testName.rf and $testName.1 failed."
            echo "********ERROR********"
            echo ""
            allSucceed=0
        fi
        diff "$testName.mine" "$testName.1"
        code=$?
        if [ ! $code -eq 0 ] ; then
            echo ""
            echo "********ERROR********"
            echo "Diffing $testName.1 and $testName.mine failed."
            echo "********ERROR********"
            echo ""
            allSucceed=0
        fi
    fi
    echo " Done!"
done
echo "==========TESTING FINISHED=========="
echo ""
if [ $allSucceed -eq 1 ] ; then
    echo "All Tests Succeeded!"
else
    echo "Some Tests Failed."
fi