#!/bin/sh
#A simple docker script to enter into the container with caffe and other shell scripts
docker run -t -i --rm --name deepdream-enter --volumes-from=deepdream-compute visionai/clouddream /bin/bash
