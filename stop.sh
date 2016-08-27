#!/bin/sh
#
# Start the docker container which will keep looking for images inside
# the inputs/ directory and spew out results into outputs/

CONTAINER=deepdream_enter
STOP_CONTAINER=''
REMOVE_CONTAINER=''
TRUE='true'

RUNNING=$(docker inspect --format="{{ .State.Running }}" $CONTAINER 2> /dev/null)

if [ $? -eq 0 ]; then
    REMOVE_CONTAINER=$CONTAINER
    if [ "$RUNNING" = "$TRUE" ]; then
        STOP_CONTAINER=$CONTAINER
    fi
fi

docker stop deepdream-files deepdream-compute deepdream-json ${STOP_CONTAINER}
docker rm deepdream-files deepdream-compute deepdream-json ${REMOVE_CONTAINER}
