#!/bin/sh
# Simple script to process all of the images inside the inputs/ folder
# We will be running this script inside the visionai/clouddream Docker image
# Copyright vision.ai, 2015

cd /opt/deepdream

while [ true ];
do
    cd /opt/deepdream/inputs
    FILES=`ls *`
    cd - 2>&1 /dev/null
    for f in ${FILES};
    do
	echo File is $f
	if [ -e outputs/${f} ];
	then
	    echo "File already processed"
	else
	    echo "Deepdream" ${f}
	    chmod gou+r inputs/${f}
	    cp inputs/${f} input.jpg
	    python deepdream.py
	    ERROR_CODE=$?
	    echo "Error Code is" ${ERROR_CODE}
	    cp output.jpg outputs/${f}
	    rm output.jpg
	fi
    done
    sleep 1
done
