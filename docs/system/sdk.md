---
title: Software development kits (SDKs)
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

Reference SDKs are available at 
[hostmobility.org/sdk](https://hostmobility.org/sdk). 

Legacy toolchains are available at [hostmobility.org:8008/tools](http://hostmobility.org:8008/tools/).

## Building

SDKs are built for a specific system image using `bitbake -c populate_sdk <image-name>`. See [sdk](sdk.md).

## Installation

The SDK is installed by running the installer from the build step above. An installation folder is requested and you can use any directory that you have write access to, e.g. `~/sdk` in your home directory.

## Usage

Source the `enviroment-setup` folder where you installed the SDK

Example:
```bash
. ~/sdk/hmx-kirkstone/environment-setup-armv8a-fslc-linux 
```

This will set the environment variables for the compiler, linker, etc.

For example, the kernel headers can be found in `SDKTARGETSYSROOT` (the option needs to be set in the image).

Access kernel headers, e.g. when compiling external modules:
```bash
export KDIR=$SDKTARGETSYSROOT/usr/src/kernel
```

