#!/bin/sh
docker run -t -i -p 80:80 --rm --name deepdream -v `pwd`/deepdream:/opt/deepdream visionai/clouddream /bin/bash -c "cd /opt/deepdream && ./process_images.sh"
