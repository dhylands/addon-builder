#!/bin/bash
set -e

RPXC="./bin/rpxc"

mkdir -p $(dirname ${RPXC})

# Build the docker raspberry pi cross compiler
echo "Creating rpxc"
docker run dhylands/raspberry-pi-cross-compiler-stretch > ${RPXC}
chmod +x ${RPXC}
