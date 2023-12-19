---
title: Yocto Build System
tags:
  - HMX
  - MX-4
  - CT
  - MX-V
  - T30
  - T30 FR
  - C61
  - Development
---

## Overview

The operating system running on Host Mobility Hardware and most of the tools are built from source. The build system used for this is the [Yocto Build System](https://www.yoctoproject.org/). This combines software written by Host Mobility with free software from software and hardware developers all over the world.  

## Building with Yocto

* To build packages and images, a Linux system is needed.  The quickest way is to use our Docker build script:

*Clone mobility-poky-platform*
```bash
git clone git@github.com:hostmobility/mobility-poky-platform.git && cd mobility-poky-platform
```

*Build image for specific machine*
```bash
DL_DIR=$HOME/YOCTO_DOWNLOADS # Store downloads for reuse
scripts/bygg \
  --repo-sync \
  --delete-conf \
  --manifest-file kirkstone.xml \
  --machine imx8mp-var-dart-hmx1 \
  --image console-hostmobility-image \
```

*See [Building with Docker](yocto-build-with-docker.md) for details.*

## Native build environment 

* You can also build using a [Native build environment](yocto-build-manually.md) (without Docker).

## Packages and Images

The Yocto system takes care of building software and its dependecies from recipe files in the meta- folders. The results are:

* Packages (`*.ipk`) that can be installed on the hardware.  
From the packages, 
* System images (*.wic.gz or .img), created from packages, deployed to the hardware for full system upgrade.

## Package server

We have chosen the `ipk` format which are installed with the `opkg` tool. 

Typically, the .`ipk` files are not installed manually but are uploaded to a server. 

We provide a package server at [hostmobility.org](https://hostmobility.org/).

## Yocto details

The software and configurations written Host Mobility is hosted on [Host Mobility Github pages](https://github.com/hostmobility). They fall into a number of categories:

### Yocto metadata

*Recipes for use by bitbake and has a "meta-" prefix.*

* [meta-hostmobility-bsp](https://github.com/hostmobility/meta-hostmobility-bsp) - Host Mobility Hardware dependent recipes, e.g. kernel, u-boot and more.
* [meta-mobility-poky-distro](https://github.com/hostmobility/meta-mobility-poky-distro) - System configuration and software.

### Versioned build system

*Xml files with recipe repo versions.*

* [mobility-poky-platform](https://github.com/hostmobility/mobility-poky-platform) - Manifest files for Poky.
* [hostmobility-bsp-platform](https://github.com/hostmobility/hostmobility-bsp-platform) - Legacy manifest files for Ångström.

### Software source

*Source for drivers and tools*

* [hm-commercial](https://github.com/hostmobility/hm-commercial) - Source for drivers and tools for HMX and MX-V.
* [mx4-commercial](https://github.com/hostmobility/mx4-commercial) - Source for drivers and tools for mx-4.

