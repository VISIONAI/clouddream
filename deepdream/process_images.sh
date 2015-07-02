#!/bin/sh
# simple script to process all of the images inside the inputs/ folder

#Start a webserver at port 80 serving the output images
cd /opt/deepdream/outputs/
python -mSimpleHTTPServer 80 2>&1 > ../access.log &

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
