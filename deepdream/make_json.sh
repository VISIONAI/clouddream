#!/bin/sh
# Simple script to make an images.json file from the contents of all images
# inside the outputs/ directory
#
# Generate a json file from a directory listing so that it can be consumed by
# $http inside angularjs-deckgrid
# Copyright vision.ai, 2015

#the amount of time to wait before regenerating images.json
SLEEP_TIME=5

make_json () {

cd outputs

rm temp.json 2>/dev/null
echo -n "[" > temp.json

files=`ls *jpg 2>/dev/null`
nfiles=`ls *jpg 2>/dev/null | wc -l`
counter=1
for f in $files;
do
    id=$counter
    name=$f
    src="/outputs/$f"
    echo -n "{\"id\":\"$id\",\"name\":\"$name\",\"src\":\"$src\"}" >> temp.json
    if [ "$id" != "$nfiles" ]; then
	echo -n "," >> temp.json
    fi
    counter=`expr $counter + 1`
done
echo -n "]" >> temp.json
mv temp.json images.json

cd - 2>&1 /dev/null
echo "Finished processing " `expr $counter - 1` "files"
}

cd `dirname $0`


#Start the infinite for loop which will keep regenerating image.json
while [ true ];
do
    echo "Making images.json"
    make_json;
    sleep ${SLEEP_TIME};
done
