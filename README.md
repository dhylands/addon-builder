# Addon builder

[![Build Status](https://travis-ci.org/mozilla-iot/addon-builder.svg?branch=master)](https://travis-ci.org/mozilla-iot/addon-builder)

Addon builder for the Web of Things gateway/

This repository will build addons for OSX, Linux, and Raspberry Pi variants
of the gateway.

Use the trigger-build.sh script to initiate a build. Modifying
any of the files in this repository and pushing them will also
trigger a build of all of the adapters.

# trigger-build.sh

The trigger-build.sh will trigger a travis job to start
building an image. You can check the progress by watching
https://travis-ci.org/mozilla-iot/addon-builder

If you only want to build for one adapter, you can pass that adapter on
the command line.
```
./trigger-build.sh gpio-adapter
```

# Deployed tarballs

The tarballs that are built will be deployed to mozilla-gateway-addons AWS bucket. URLs to the addons will be printed at the end of the job. You can
also view all of the addons by using:
```
aws s3 ls s3://mozilla-gateway-addons/
```

# Building the docker cross compiler image

To build the docker image, do the following steps:
```
git clone https://github.com/mozilla-iot/docker-raspberry-pi-cross-compiler.git
cd docker-raspberry-pi-cross-compiler
git checkout rpxc-stretch
export RPXC_IMAGE=dhylands/raspberry-pi-cross-compiler-stretch
./build.sh
docker push ${RPXC_IMAGE}
```
If you're not dhylands then you'll need to change the username appropriately,
and also modify the create-rpxc.sh script in this repository.
