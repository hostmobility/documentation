---
title: System update (T30)
tags:
  - System update
  - T30
---

## Upgrade procedure

### Prepare upgrade

* Copy `t30_hmupdate.img` to a USB memory or to `/boot` on the Linux file system

### If USB method is used

* You can add an [autoboot.sh](../../update.md#usb-method-autobootsh) script to the USB memory on the first boot after flash to perform post installation.
* Plug the USB memory into the hardware.
* Press and hold the reset button for 1 sec (all LEDs will blink green if the system has started with the reflash).

### If /boot method is used

* Set [firmware update u-boot variable](../../update.md#firmware-update-uboot-variable)

**Setting `firmware_update` to `true` will enable USB update as well if an image is present on the USB memory.**
* Reboot the unit

### Wait for upgrade to finish

* Wait 1–2 minutes until finished (until the power LED is green or blink green/orange).


*Upgrade example using /boot*
```bash
image=t30_hmupdate.img
scp "$image" dut:/boot/ && \
/opt/hm/fw_env/fw_setenv firmware_update true && \
ssh dut reboot
```
