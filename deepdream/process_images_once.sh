#!/bin/bash
# Simple script to process all of the images inside the inputs/ folder
# We will be running this script inside the visionai/clouddream Docker image
# Copyright vision.ai, 2015

cd /opt/deepdream/inputs
find . -type f -not -path '*/\.*' -print0 | while read -d $'\0' f; do
    if [[ "$(basename $(pwd))" == *'inputs'* ]]; then
        cd /opt/deepdream
    fi
    if [ -e "outputs/${f}" ]; then
        echo "File ${f} already processed"
    else
        echo "Deepdream  ${f}"
        chmod gou+r "inputs/${f}"
        cp "inputs/${f}" input.jpg
        python deepdream.py
        ERROR_CODE=$?
        echo -e "Error Code is: ${ERROR_CODE}\n\n"
        dirname_f="$(dirname "$f")"
        [[ -d "inputs/$dirname_f" && "$dirname_f" != '.' && "$dirname_f" != *'/deepdream/'* && ! -d "outputs/$dirname_f" ]] && mkdir -p "outputs/${dirname_f}"
        cp output.jpg "outputs/${f}"
        rm output.jpg
        echo "Just created outputs/${f}"
    fi
done
