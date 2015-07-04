#!/bin/bash
# Simple script to process all of the images inside the inputs/ folder
# We will be running this script inside the visionai/clouddream Docker image
# Copyright vision.ai, 2015

while [ true ];
do
    ./process_images_once.sh
    sleep 1
done
