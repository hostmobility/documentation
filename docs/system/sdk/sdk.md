---
title: Software development kits (SDKs)
tags:
  - SDK
  - Development
  - HMX
  - MX-V
  - T30
  - T30 FR
  - C61
---

## Overview

Reference SDKs are to be made available at [hostmobility.org/sdk](https://hostmobility.org/sdk).

## Building

SDKs are built for a specific system image using `bitbake -c populate_sdk <image-name>`.

*example with MACHINE set to imx8mp-var-dart-hmx1*
```bash
bitbake -c populate_sdk console-hostmobility-image
```

The installer has now been built. Its name is based on the architechture, image name and poky
version. In this case, the name is
`poky-glibc-x86_64-console-hostmobility-image-cortexa53-crypto-imx8mp-var-dart-hmx1-toolchain-4.0.13.sh`

**Note:** the console-hostmobility-image should include more packages for more debugging purpose:
- IMAGE_INSTALL
    - gdb, for debug on target machine
    - gdbserver, for debug on target machine
    - glibc-dbg, for debug on target machine
    - packagegroup-sdk-target

## Installation

The SDK is installed by running the installer from the build step above. 


*Set the file as executable*
```bash
chmod +x poky-glibc-x86_64-console-hostmobility-image-cortexa53-crypto-imx8mp-var-dart-hmx1-toolchain-4.0.13.sh 
```

*Run the installer*
```bash
./poky-glibc-x86_64-console-hostmobility-image-cortexa53-crypto-imx8mp-var-dart-hmx1-toolchain-4.0.13.sh
```


*Select directory where to install the SDK*
```
Poky (Yocto Project Reference Distro) SDK installer version 4.0.13
==================================================================
Enter target directory for SDK (default: /opt/poky/4.0.13): ~/sdk/
You are about to install the SDK to "/home/mattias/sdk". Proceed [Y/n]? Y
Extracting SDK.................................................................^Bn................................................................................................................................................................done
Setting it up...done
SDK has been successfully set up and is ready to be used.
Each time you wish to use the SDK in a new shell session, you need to source the environment setup script e.g.
 $ . /home/mattias/sdk/environment-setup-cortexa53-crypto-poky-linux
```

## Usage and test

To get generate source code for a sample application, save the following in a file named `program.c`.

```C
#include <stdio.h>

int main(int argc, char *argv[])
{
    for (int i = 0; i < argc; i++) {
        printf("%d: %s\n", argc, argv[i]);
  }
}
```


*Source the `enviroment-setup` directory where you installed the SDK.*

```bash
. ~/sdk/hmx-kirkstone/environment-setup-armv8a-fslc-linux
```

*run make*
```bash
make --no-silent  program
```
*Make is now aware of the cross-compiler through the environment.*
```
aarch64-poky-linux-gcc  -mcpu=cortex-a53 -march=armv8-a+crc+crypto -mbranch-protection=standard -fstack-protector-strong  -O2 -D_FORTIFY_SOURCE=2 -Wformat -Wformat-security -Werror=format-security --sysroot=/home/mattias/sdk/sysroots/cortexa53-crypto-poky-linux  -O2 -pipe -g -feliminate-unused-debug-types   -Wl,-O1 -Wl,--hash-style=gnu -Wl,--as-needed  -Wl,-z,relro,-z,now  program.c   -o program
```

*Example: access kernel headers e.g. when compiling external modules*
```bash
export KDIR=$SDKTARGETSYSROOT/usr/src/kernel
```

