#!/bin/bash
set -e

RPXC="./bin/rpxc"

mkdir -p $(dirname ${RPXC})

# Build the docker raspberry pi cross compiler
echo "Creating rpxc"
docker run sdthirlwall/raspberry-pi-cross-compiler > ${RPXC}
chmod +x ${RPXC}

sudo ${RPXC} apt update
sudo ${RPXC} apt upgrade

${RPXC} install-raspbian libudev-dev
${RPXC} install-debian pkg-config
${RPXC} install-debian python
${RPXC} install-debian python2.7
