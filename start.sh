#!/bin/sh
docker run -t -i -p 80:80 --rm --name deepdream -v `pwd`/deepdream:/opt/deepdream e24e75f11ea5 /bin/bash -c "cd /opt/deepdream && ./process_images.sh"
