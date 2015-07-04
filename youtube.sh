#!/bin/sh 
#
# Script to Download a Youtube movie, extract frames, process them
# with deepdream, and generate a resulting movie.
#
# Usage:
# ./youtube.sh https://www.youtube.com/watch?v=XXXXXXXX

if [ "$#" -ne 1 ]; then
    #Charlie bit my Finger movie is the default
    URL=https://www.youtube.com/watch?v=DDZQAJuB3rI
else
    URL=$1
fi

echo "URL is" $URL

docker stop deepdream-json deepdream-compute deepdream-files 2> /dev/null
docker rm deepdream-json deepdream-compute deepdream-files 2> /dev/null
mkdir /tmp/images 2>/dev/null
rm /tmp/images/* 2> /dev/null
rm deepdream/inputs/* 2>/dev/null
rm deepdream/outputs/* 2>/dev/null
rm /tmp/video.mp4 2>/dev/null

docker run -it --rm -v /tmp:/tmp jbergknoff/youtube-dl -o /tmp/video.mp4 $URL
docker run -it --rm -v /tmp:/tmp aquarius212/ffmpeg /bin/bash -c "ffmpeg -i /tmp/video.mp4 -r 1 -t 100 -f image2 /tmp/images/image-%05d.jpg"
cp /tmp/images/image*jpg deepdream/inputs/

PORT=8000
docker run --name deepdream-files -v `pwd`/deepdream:/usr/share/nginx/html:ro -d -p ${PORT}:80 nginx
docker run -d --name deepdream-json -v `pwd`/deepdream:/opt/deepdream ubuntu:14.04 /bin/bash -c "cd /opt/deepdream && ./make_json.sh"
docker run -it --rm --name deepdream-compute -v `pwd`/deepdream:/opt/deepdream visionai/clouddream /bin/bash -c "cd /opt/deepdream && ./process_images_once.sh 2>&1 > log.html"


cp -R deepdream/outputs /tmp/
rm /tmp/out.mp4 2> /dev/null
docker run -it --rm -v /tmp:/tmp aquarius212/ffmpeg /bin/bash -c "ffmpeg -f image2 -r 1 -i /tmp/outputs/image-%05d.jpg -b 600k -vf \"scale=trunc(iw/2)*2:trunc(ih/2)*2\" /tmp/out.mp4"
cp /tmp/out.mp4 deepdream/
