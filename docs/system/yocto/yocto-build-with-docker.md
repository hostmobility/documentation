---
title: Yocto Build (With Docker)
tags:
  - Development
  - HMX
  - MX-4
  - CT
  - CT GL
  - MX-V
  - T30
  - T30 FR
  - C61
---

## Build scripts

Building with Yocto requires many software tools and those need to have correct versions. To create this build environment, Docker can be used to great advantage. 

To help launching a build in Docker, we provide a couple of scripts in [mobility-poky-platform/scripts](https://github.com/hostmobility/mobility-poky-platform/tree/master/scripts) that automate much of the build tasks.

This requires only installation of Docker before starting the build.

### [bygg](https://github.com/hostmobility/mobility-poky-platform/blob/master/scripts/bygg) script example
```bash
DL_DIR=/YOCTO_DOWNLOADS 
scripts/bygg \ 
  --repo-sync \
  --manifest-file kirkstone \
  --delete-conf \
  --distro poky \
  --machine imx8mp-var-dart-hmx1 \
  --image console-hostmobility-image
```
### [bygg](https://github.com/hostmobility/mobility-poky-platform/blob/master/scripts/bygg) build with custom distro



To make this work we recommend using a manifest file based on our kirkstone.xml (or newer) together with your custom distro layer. In the distro layer, you will need to set up two files: conf and bblayer.conf. The latter must include your distro so that the build can include your bb(append) recipes.

To start the build you need to target the conf folder with --templateconf when you use the 'bygg' script.

Example usage:

```bash
DL_DIR=$HOME/YOCTO_DOWNLOADS # Store downloads for reuse
scripts/bygg \
  --repo-sync \
  --delete-conf \
  --manifest-file kirkstone-'custom'.xml \
  --machine imx8mp-var-dart-hmx1 \
  --image console-hostmobility-image \
  --templateconf sources/meta-your-custom-distro/conf/templates/hmx \
```

### [bid (build-in-docker)](https://github.com/hostmobility/mobility-poky-platform/blob/master/scripts/bid) script example (older way than bygg not recommended for new users)

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
