#!/bin/sh
#
# Start the docker container which will keep looking for images inside
# the inputs/ directory and spew out results into outputs/

#run the json builder in a loop
./deepdream/make_json.sh &

./deepdream/serve_files.sh &

docker run -t -i --rm --name deepdream-compute -v `pwd`/deepdream:/opt/deepdream visionai/clouddream /bin/bash -c "cd /opt/deepdream && ./process_images.sh"
