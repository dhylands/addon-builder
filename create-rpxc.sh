#!/bin/bash
set -e
set -x

RPXC="./bin/rpxc"

mkdir -p $(dirname ${RPXC})

# Build the docker raspberry pi cross compiler
echo "Creating rpxc"
docker run dhylands/raspberry-pi-cross-compiler-stretch > ${RPXC}
chmod +x ${RPXC}

#sudo ${RPXC} apt update
#sudo ${RPXC} apt upgrade

#${RPXC} install-raspbian libudev-dev
#${RPXC} install-debian pkg-config
#${RPXC} install-debian python
#${RPXC} install-debian python2.7
#${RPXC} install-debian unzip
