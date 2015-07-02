#!/bin/sh
# Serve the entire directory using NGINX on port 80

cd `dirname $0`
docker run --name deepdream-files -v `pwd`:/usr/share/nginx/html:ro -d -p 80:80 nginx
cd - 2>/dev/null
