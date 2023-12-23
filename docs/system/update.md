---
title: System update
tags:
  - System update
  - HMX
  - MX-4
  - CT
  - CT GL
  - MX-V
  - T30
  - T30 FR
  - C61
---

##  Installation or upgrade of specific software

###  Opkg package manager

`opkg` is used  to install extra packages that are not installed with the original image.

*To use it, first update the package lists*
```bash
opkg update
opkg list
```

*Example: install rsync*
```bash
opkg install rsync
```

### Editing package feeds

The files under `/etc/opkg/*` define where to get extra software. You can edit them to point to the server of your choice.
**NOTE: Make sure that the package repository you add is compatible and secure to use**

## System installation or re-installation

### System image also known as firmware

Host Mobility hardware is able to update itself with two methods using files created by the build system:

1. Put files on a USB memory stick. , plug it into the machine and press `reset-button`. *On the HMX, the USB-upgrade button must be held down during reset as well*
2. Copy the files over the network to /boot directory. and set the `firmware_update` u-boot environment variable to `true`

The files can be put in `/boot` in a number of ways. In the case of using secure shell (SSH), you can use the `~/.ssh/config` file like this:

*Assign the unit connected with USB cable to name dut*
```
Host dut
  HostName 192.168.250.1
  User roothmx
  StrictHostKeyChecking No
```

Depending on the hardware, the upgrade procedures are then slightly different:

* [System upgrade (HMX)](hmx/update.md)
* [System upgrade (MXV)](mxv/update.md)
* [System upgrade (MX-4 T30)](mx4/t30/update.md)
* [System upgrade (MX-4 C61)](mx4/c61/update.md)
* [System upgrade (MX-4 CT)](mx4/ct/update.md)

### Firmware update u-boot variable

To trigger a firmware update on certain MX-4 hardware types, a U-Boot variable needs to be set:

*Set firmware update U-Boot variable*
```bash
/opt/hm/fw_env/fw_setenv firmware_update true
```

**Setting `firmware_update` to `true` will enable USB update as well if an image is present on the USB memory.**

### USB method autoboot.sh

If a file named `autoboot.sh` is found on the USB memory the first after upgrade, it will be executed. 

This can be used to re-install and configure the unit after update.

### Persistent partition /mnt/config and run-parts

On some bulids, files stored in `/mnt/config` are kept across system re-installations.

If this is included, all executable files in `/mnt/config/update-hooks` are executed using `run-parts` on first boot. 

This can be used to re-install and configure the unit after update when updating from `/boot` directory.



