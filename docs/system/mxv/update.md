---
title: System Update (MXV)
tags:
  - MX-V
  - Updating
---

The files themselves are:

1. A u-boot script. Depending on the platform type, the name can be `hmx_boot.scr` for HMX, `flashmx5.scr` for [#MX-V] or `*_hmupdate.img` for [#mx-4-t30-and-mx-4-c61] and CT(t20_*). This scripts is able to update all software components (Linux kernel, u-boot, file-system(distribution), co-processor firmware).
2. The image file, named `hmx-image.wic.gz`, `mx5-image.wic.gz`, etc. *For the `*_hmupdate.img` script case, the image file can be baked into the script itself.*


### Method 1. Installing (flashing) using a USB memory


#### MX-V

* copy and rename for example 'mobility-image-***.wic.gz' into mx5-image.wic.gz on the USB drive,
* copy flashmx5.scr to the USB drive,
* plug the USB drive into the MX-V,
* push and hold the reset button for 1 sec,
* wait 1–2 min until finished (until the function LED blinks green).

#### HMX (imx8mp-var-dart-hmx1)

* copy and rename '*-hostmobility-image-***.wic.gz' into hmx-image.wic.gz on the USB drive or copy to `/boot` in linux (only reset needs to be pushed),
* copy `hmx_boot.scr` to the USB drive or copy to `/boot` on the Linux file system (only reset needs to be pushed),
* plug the USB drive into the HMX,
* push and hold the reset button and the USB_BOOT, release the reset button and
* hold the USB_BOOT button down for 3 more seconds.
* The unit shall now start to flash a white LED in the middle off the box (blink 1 sec and when it start to perform the flash it blinks three times faster)
* Wait 1–2 min until finished (the LED in the middle of the box should go back to blue, then green when it is up and running in Linux. If the this LED goes red it has failed and will reset itself after 10 s).

#### MX-4 T30 and MX-4 C61

* start build image with help of mx4-deploy
* the resulting file is a `vf_hmupdate.img` (C61) or `t30_hmupdate.img` (T30) in the deploy-(machine) directory
* copy the image to the USB drive and insert it into the MX-4 machine
* push and hold the reset button for 1 sec (all LEDs will blink green if the system has started with the reflash)
* wait 1–2 min until finished (until the power LED is green or blink green/orange).

#### Using a post-install script with USB memory

* You can add an autoboot.sh script to the USB memory on the first boot after flash to perform post installation.

### Method 2. Copy the files over the network (remote install)

#### Remote install overview

The files can be put in `/boot` in a number of ways. In the case of using secure shell (SSH), you can use the `~/.ssh/config` file like this:

*Assign the unit connected with USB cable to name dut*
```
Host dut
  HostName 192.168.250.1
  User root
  StrictHostKeyChecking No
```

#### HMX

Two files are needed which are:

* hmx_boot.scr 
* hmx-image.wic.gz (*rename from IMAGE-NAME-image-imx8mp-var-dart-hmx1.wic.gz*)

*Copy files to a unit connected with a USB cable NOTE: the image file must be renamed*
```bash
image=console-hostmobility-image-imx8mp-var-dart-hmx1.wic.gz
scp "$image" dut:/boot/hmx-image.wic.gz && \
scp hmx_boot.scr dut:/boot/ && \
ssh dut reboot
```

#### MX-V

Two files are needed which are:

* hmx_boot.scr 
* mx5-image.wic.gz (*rename from image-name-platform-name-wic.gz*)

*Copy files to a unit connected with a USB cable NOTE: the image file must be renamed*
```bash
image=console-hostmobility-image-mx5.wic.gz
scp "$image" dut:/boot/mx5-image.wic.gz  && \
scp flashmx5.scr dut:/boot/ && \
ssh dut reboot
```


#### MX-4

**To trigger an update from /boot one needs to set the `firmware_update` u-boot environment variable to `true`. See below example on how to do that.**

**Setting `firmware_update` to `true` will enable USB update as well if an image is present on the USB drive.**

```bash
image=t30_hmupdate.img
scp "$image" dut:/boot/ && \
/opt/hm/fw_env/fw_setenv firmware_update true && \
ssh dut reboot
```
