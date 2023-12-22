---
title: System update (CT)
tags:
  - System update
  - CT
---

## Upgrade procedure

### Prepare upgrade

* Copy `t20_hmupdate.img` to a USB memory or to `/boot` on the Linux file system

### If USB method is used

* You can add an [autoboot.sh](../../update.md#usb-method-autobootsh) script to the USB memory on the first boot after flash to perform post installation.
* Plug the USB memory into the hardware.
* Press and hold the reset button for 1 sec (all LEDs will blink green if the system has started with the reflash).

### If /boot method is used

* **To trigger an update from /boot one needs to set the `firmware_update` u-boot environment variable to `true`. See below example on how to do that.**

**Setting `firmware_update` to `true` will enable USB update as well if an image is present on the USB memory.**
* Reboot the unit

### Wait for upgrade to finish

* Wait 1–2 minutes until finished (until the power LED is green or blink green/orange).


*Upgrade example using /boot*
```bash
image=t20_hmupdate.img
scp "$image" dut:/boot/ && \
/opt/hm/fw_env/fw_setenv firmware_update true && \
ssh dut reboot
```
