---
title: System update (HMM)
tags:
  - System update
  - HMM
---


## Upgrade procedure

### Prepare upgrade

* Rename the file `***-image-verdin-am62-hmm.wic.gz` to `hmm-image.wic.gz`
* Copy `hmm_boot.scr` and `hmm-image.wic.gz` to a USB memory.
* It is also possible to update by copying `hmm-image.wic.gz` to `/boot` or  `/`  on the Linux file system

### If the USB method is used

* Plug the USB memory into the HMM
* Press and release the the `RESET` button 
* You can add an [autoboot.sh](../update.md#usb-method-autobootsh) script to the USB memory on the first boot after flash to perform post installation.

### If /boot method is used

* Reset or reboot the unit, make sure to file sync the system if using reset button.

### Wait for upgrade to finish

* The unit shall now set LED 3 (C) to green if it was successful in loading the wic.gz fil into RAM or red if it failed, in which case the device will reset itself after 10 seconds.

* The unit shall now set LED 4 (D) to green if it was successful in writing the wic.gz file or red for 10 seconds before reset.

***NOTE*** Detailed LED behavior can be found [here](../interfaces/hmm/leds.md



*Upgrade example using /boot*
```bash
image=console-hostmobility-image-verdin-am62-hmm.wic.gz
scp "$image" dut:/boot/hmm-image.wic.gz && \
ssh dut reboot
```
### Update u-boot and spl

  TODO description for a /opt/hm/boot_flash.sh script.