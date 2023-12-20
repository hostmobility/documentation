---
title: System Update
tags:
  - HMX
  - MX-4
  - CT
  - MX-V
  - T30
  - T30 FR
  - C61
  - Updating
---

## Overview

Host Mobility hardware is able to update itself with two methods. Either by putting the update files on a memory stick and plug it into the hardware or by copying them over the network to /boot directory.

## Installing (flashing) using a USB drive

### MX-V

* copy and rename 'mobility-image-***.wic.gz' into mx5-image.wic.gz on the USB drive,
* copy flashmx5.scr to the USB drive,
* plug the USB drive into the MX-V,
* push and hold the reset button for 1 sec,
* wait 1–2 min until finished (until the function LED blinks green).

### HMX (imx8mp-var-dart-hmx1)

* copy and rename '*-hostmobility-image-***.wic.gz' into hmx-image.wic.gz on the USB drive or copy to /boot in linux(only reset needs to be pushed),
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

## Installing system remotely

### HMX

Two files are needed which are:

* hmx_boot.scr 
* hmx-image.wic.gz (*rename from image-name-platform-name-wic.gz*)

*Copy files to a unit connected with a USB cable*
```bash
scp console-hostmobility-image-imx8mp-var-dart-hmx1.wic.gz root@192.168.250.1:/boot/hmx-image.wic.gz
scp hmx_boot.scr root@192.168.250.1:/boot/
```


