---
title: System update (C61)
tags:
  - System update
  - C61
---

## Upgrade procedure

### Prepare upgrade

* Copy `vf_hmupdate.img` to a USB memory or to `/boot/vf_boot.scr` on the Linux file system (renaming the file in the latter case only)

### If USB method is used

* You can add an [autoboot.sh](../../update.md#usb-method-autobootsh) script to the USB memory on the first boot after flash to perform post installation.
* Plug the USB memory into the hardware.
* Press and hold the reset button for 1 sec (all LEDs will blink green if the system has started with the reflash).

### If /boot method is used

* Reboot the unit

### Wait for upgrade to finish

* Wait 1–2 minutes until finished (until the power LED is green or blink green/orange).


*Upgrade example using /boot*
```bash
image=kirkstone-poky/38/jenkins-Release-kirkstone-poky-38-mx4-c61/vf_hmupdate.img
scp "$image" dut:/boot/vf_boot.scr && \
ssh dut reboot
```
