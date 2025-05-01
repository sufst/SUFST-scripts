#!/bin/sh

#
# Usage: ./build.sh <username>/<package name>
# 
# Builds this Dockerfile image with
# the KiCad CLI and some other dependencies.
#
# While inside the directory (i.e. after 
# running `cd docker`), run this script with
#  your username and the docker image name, 
# e.g. `./build.sh username/packagename`.
#

set -e

if ! [ -f "Dockerfile" ]; then
    echo "Error: Make sure you're running this in the same directory as the Dockerfile"
    exit 1
fi

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <username>/<package name>"
    exit 1
fi

docker build -t "$1" .
docker push "$1"