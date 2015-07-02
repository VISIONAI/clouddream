#!/bin/sh
# Simple script to process all of the images inside the inputs/ folder
# We will be running this script inside the visionai/clouddream Docker image
# Copyright vision.ai, 2015

cd /opt/deepdream

while [ true ];
do
    cd /opt/deepdream/inputs
    FILES=`ls *jpg`
    cd - 2> /dev/null
    for f in ${FILES};
    do
	echo File is $f
	if [ -e outputs/${f} ];
	then
	    echo "File already processed"
	else
	    echo "Deepdream" ${f}
	    cp inputs/${f} input.jpg
	    echo "pwd is" `pwd`
	    python deepdream_single.py
	    cp output.jpg  outputs/${f}
	fi
    done
    sleep 1
done
