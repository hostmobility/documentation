---
title: System update (MX-V)
tags:
  - System update
  - MX-V
---

## Upgrade procedure

### Prepare upgrade

* Copy the file `*-image-mx5-pt*.rootfs.wic.gz` to `mx5-image.wic.gz`
* Copy `flashmx5.scr` and `mx5-image.wic.gz` to a USB memory or to `/boot` on the Linux file system

### If USB method is used

* You can add an [autoboot.sh](../update.md#usb-method-autobootsh) script to the USB memory on the first boot after flash to perform post installation.
* Plug the USB memory into the hardware.
* Press and hold the `RESET` button for 1 second.

### If /boot method is used

* Reset or reboot the unit.

### Wait for upgrade to finish

* Wait 1–2 min until finished (until the function LED blinks green).


*Upgrade example using /boot*
```bash
image=console-hostmobility-image-mx5-pt-20230123170836.rootfs.wic.gz
scp "$image" dut:/boot/mx5-image.wic.gz && \
scp flashmx5.scr dut:/boot/ && \
ssh dut reboot
```

