---
title: Yocto Build System
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

## Overview

The operating system running on Host Mobility hardware and most of the tools are built from source. The build system used for this is the [Yocto Build System](https://www.yoctoproject.org/). It combines software written by Host Mobility with free software from developers all over the world.

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

To get more information about what you can do with it, run scripts/bygg --help.

## Native build environment 

* You can also build using a [native build environment](yocto-build-manually.md) (without Docker).

## Packages and images

The Yocto system takes care of building software and its dependecies from recipe files in the meta- folders. The results are:

* Packages (`*.ipk`) that can be installed on the hardware.  
From the packages, 
* System images (*.wic.gz or .img), created from packages, deployed to the hardware for full system upgrade.

## Package server

For our reference distributions we use the `ipk` package format and the `opkg` tool.

Typically, .`ipk` files are not installed manually but uploaded to a server.

We provide a package server at [hostmobility.org](https://hostmobility.org/).

## Yocto details

The software and configurations written by Host Mobility are hosted on [Host Mobility's GitHub repositories](https://github.com/hostmobility). They fall into a number of categories:

### Yocto metadata

Recipes for use by bitbake that have a "meta-" prefix.

* [meta-hostmobility-bsp](https://github.com/hostmobility/meta-hostmobility-bsp) – Host Mobility hardware dependent recipes, e.g. kernel, u-boot and more.
* [meta-mobility-poky-distro](https://github.com/hostmobility/meta-mobility-poky-distro) – System configuration and software.

### Versioned build system

XML files with recipe repo versions.

* [mobility-poky-platform](https://github.com/hostmobility/mobility-poky-platform) – manifest files for Poky
* [hostmobility-bsp-platform](https://github.com/hostmobility/hostmobility-bsp-platform) – legacy manifest files for Ångström

### Software source

Source code for drivers and tools.

* [hm-commercial](https://github.com/hostmobility/hm-commercial) – source for drivers and tools for HMX and MX-V
* [mx4-commercial](https://github.com/hostmobility/mx4-commercial) – source for drivers and tools for MX-4

