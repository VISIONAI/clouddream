#!/bin/sh
#
# Start the docker container which will keep looking for images inside
# the inputs/ directory and spew out results into outputs/

docker stop deepdream-files deepdream-compute deepdream-json deepdream-enter
docker rm deepdream-files deepdream-compute deepdream-json deepdream-enter
