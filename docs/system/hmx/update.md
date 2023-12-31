---
title: System update (HMX)
tags:
  - System update
  - HMX
---


## Upgrade procedure

### Prepare upgrade

* Copy the file `***-image-imx8mp-var-dart-hmx1.wic.gz` to `hmx-image.wic.gz`
* Copy `hmx_boot.scr` and `hmx-image.wic.gz` to a USB memory or to `/boot` on the Linux file system

### *If USB method is used*

* Plug the USB memory into the HMX
* Press and hold the `USB_BOOT` button
* Press and release the the `RESET` button while holding the `USB_BOOT` button 
* You can add an [autoboot.sh](../update.md#usb-method-autobootsh) script to the USB memory on the first boot after flash to perform post installation.

### If /boot method is used

* Reset or reboot the unit

### Wait for upgrade to finish

* The unit shall now start to flash a white LED in the middle of the box (blink 1 sec and when it start to perform the flash it blinks three times faster)
* Wait 1–2 min until finished (the LED in the middle of the box should go back to blue, then green when it is up and running in Linux. If this LED goes red it has failed and will reset itself after 10 s).


*Upgrade example using /boot*
```bash
image=console-hostmobility-image-imx8mp-var-dart-hmx1.wic.gz
scp "$image" dut:/boot/hmx-image.wic.gz && \
scp hmx_boot.scr dut:/boot/ && \
ssh dut reboot
```
