---
title: Software Development
tags:
  - HMX
  - MX-4
  - CT
  - MX-V
  - T30
  - T30 FR
  - C61
---



## Overview

The source code for all of our software is on [Host Mobility Github pages](https://github.com/hostmobility)

https://github.com/hostmobility

https://github.com/hostmobility/meta-hostmobility-bsp

## Building with Yocto

The operating system on Host Mobility Hardware is built using the [Yocto Build System](https://www.yoctoproject.org/)


## Bygg script 
Since building with Yocto can be quite complex, we have [mobility-poky-platform](https://github.com/hostmobility/mobility-poky-platform.git) which automates much of the build tasks.

This requires only installation of Docker before starting the build

*Build example*
```bash
DL_DIR=/YOCTO_DOWNLOADS 
scripts/bygg \ 
  --manifest-file kirkstone \
  --delete-conf \
  --distro poky \
  --machine imx8mp-var-dart-hmx1 \
  bitbake console-hostmobility-image
```

Host Mobility Hardware run a Linux based system. As such, software is usually built from source. The target architechure is ARM32 and ARM64.

## Host Mobility poky platform

You can choose to build Yocto/Open Embedded the regular way or using our custom build-in-docker ("bid") script.

## Regular Host Mobility Yocto/OE-core setup

To simplify installation we provide a [repo](http://code.google.com/p/git-repo) manifest which manages the different git repositories
and the versions used.

Before proceeding, please take a look at [The Build Host Packages](http://www.yoctoproject.org/docs/2.3/mega-manual/mega-manual.html#packages) in the Yocto Manual.

Install the repo bootstrap binary:

```
sudo apt-get install repo
```

or

```
mkdir ~/bin
PATH=~/bin:$PATH
curl http://commondatastorage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
chmod a+x ~/bin/repo
```

Create a directory for your `mobility-bsp-platform` setup to live in and clone the meta information.
```
mkdir mobility-bsp-platform
cd mobility-bsp-platform
repo init -u https://github.com/hostmobility/mobility-poky-platform -b master
repo init -m kirkstone-next.xml
repo sync --force-sync
```

Set up environment variables:
```
export DIR_WORK=$PWD/../
export BUILD_TAG=*yourTag*
export PLATFORM_VERSION="$(git -C $DIR_WORK.repo/manifests rev-parse --short HEAD)"
export PLATFORM_VERSION_DETAILS="$(repo forall -c 'echo $REPO_PATH\nLREV: $REPO_LREV\nRREV: $REPO_RREV; git diff --stat -b $REPO_LREV..HEAD ; echo -n "Commit: " ; git rev-parse HEAD ; echo -n "Uncommited changes: " ; git status -b -s ; git diff --stat -b ; echo ')"
echo "building with repo versions: $PLATFORM_VERSION"
export BB_ENV_PASSTHROUGH_ADDITIONS="$BB_ENV_PASSTHROUGH_ADDITIONS BUILD_TAG PLATFORM_VERSION PLATFORM_VERSION_DETAILS"
export TEMPLATECONF=$PWD/../sources/meta-mobility-poky-distro/conf
```
**NOTE!** You will need to perform these exports for each new session. If you already have
a build directory, it will be untouched and only the environment variables will be set.

Start baking!
```
$ source sources/poky/oe-init-build-env build;
$ bitbake {image}
```

where `{image}` is replaced by, for example, `console-mobility-image`, `bitbake mobility-image` or `mobility-image-chromium`.

The build result will end up in the `mobility-bsp-platform/build/tmp/deploy/images/` directory.


## Building in Docker

You can build this platform without installing the Yocto build tools directly on the host.
To do so, you can use our custom [bid](https://github.com/hostmobility/mobility-poky-platform/blob/master/scripts/bid) (build-in-docker) script.

Usage:
```
$ git clone git@github.com:hostmobility/mobility-poky-platform.git
$ cd mobility-poky-platform
$ mkdir ~/YOCTO_DOWNLOADS
$ scripts/bid [options] [build command]
```

### Example build commands for the mx4-c61 machine

Sync repositories using the kirkstone manifest file and the master branch:

```
$ scripts/bid -s -f kirkstone.xml -a master -m mx4-c61 bash
```

Do the same as above but build the Linux kernel:

```
$ scripts/bid -f kirkstone.xml -a master -m mx4-c61 -d poky bitbake virtual/kernel
```

The same as above but build a complete image:

```
$ scripts/bid -f kirkstone.xml -a master -m mx4-c61 -d poky bitbake console-hostmobility-image
```

## Installing (flashing) using a USB drive

### MX-V

* copy and rename 'mobility-image-***.wic.gz' into mx5-image.wic.gz on the USB drive,
* copy flashmx5.scr to the USB drive,
* plug the USB drive into the MX-V,
* push and hold the reset button for 1 sec,
* wait 1–2 min until finished (until the function LED blinks green).

### HMX (imx8mp-var-dart-hmx1)
* copy and rename 'console-hostmobility-image-***.wic.gz' into hmx-image.wic.gz on the USB drive or copy to /boot in linux(only reset needs to be pushed),
* copy hmx_boot.scr to the USB drive or copy to /boot in linux(only reset needs to be pushed),
* plug the USB drive into the hmx,
* push and hold the reset button and the USB_BOOT, release the reset button and.
* hold the USB_BOOT button down for 3 more second.
* the unit shall now start to flash a white led in the middle off the box (blink in 1 sec and when it start to perform the flash it blinks three times faster)
* wait 1–2 min until finished (led in the middle off the box should go back to blue then green when it is up and running in linux, if the this led goes red it has failed and will reset itself after 10sec).

### MX-4 t30 and MX-4 c61
* start build image with help of mx4-deploy
* the result file is a vf_hmupdate.img(c61) or t30_hmupdate.img(t30) in deploy-(machine) folder.
* copy '**hmupdate.img' into hmx-image.wic.gz on the USB drive
* push and hold the reset button for 1 sec,(all leds will blink green if the system has started with the reflash)
* wait 1–2 min until finished (until the pwr LED is green or blink green/orange).

### use post install script with USB memory
* you can add a autoboot.sh script to the USB memory drive on the first boot after flash to perform post installation.



