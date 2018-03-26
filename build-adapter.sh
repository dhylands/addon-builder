#!/bin/bash
#
# This script builds a single adapter and its dependencies.
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.*

set -e

SCRIPT_NAME=$(basename $0)
ADDON_ARCH="$1"

NVM_VERSION="v0.33.8"
NODE_VERSION="--lts"

if [ -z "${ADDON_ARCH}" ]; then
  echo "Usage: ${SCRIPTNAME} addon-arch"
  exit 1
fi

echo "Building ADDON_ARCH=${ADDON_ARCH} ADAPTER=$(basename $(pwd))"

if [ -f "package.json" ]; then
  if [ "${ADDON_ARCH}" == "linux-arm" ]; then
    # Install and configure nvm & node inside the docker container we're running in
    curl -o- https://raw.githubusercontent.com/creationix/nvm/${NVM_VERSION}/install.sh | bash

    # The following 2 lines are installed into ~/.bashrc by the above,
    # but on the RPi, sourcing ~/.bashrc winds up being a no-op (when sourced
    # from a script), so we just run it here.
    export NVM_DIR="${HOME}/.nvm"
    [ -s "${NVM_DIR}/nvm.sh" ] && source "${NVM_DIR}/nvm.sh"  # This loads nvm
    # We need to install the version of node into the container
    nvm install ${NODE_VERSION}
    nvm use ${NODE_VERSION}
  fi

  # On Travis, yarn won't yet be installed, but if run locally on a dev
  # machine, it most likely will.
  if ! type yarn >& /dev/null; then
    npm install -g yarn
  fi
  rm -rf node_modules
fi

if [ "${ADDON_ARCH}" == "linux-arm" ]; then
  # setup cross-compiler
  SYSROOT=/rpxc/sysroot
  OPTS="--sysroot=${SYSROOT}"
  export CC="arm-linux-gnueabihf-gcc ${OPTS}"
  export CXX="arm-linux-gnueabihf-g++ ${OPTS}"
fi

ADDON_ARCH=${ADDON_ARCH} ./package.sh
for TARFILE in *-${ADDON_ARCH}*.tgz; do
  sha256sum "${TARFILE}" > "${TARFILE}.sha256sum"
  mv "${TARFILE}" ../addons/
  mv "${TARFILE}.sha256sum" ../addons/
done
