---
title: Accelerometer (MX-4)
tags:
  - Accelerometer
  - C61
  - MX-4
  - MX-V
  - T30
  - T30 FR
  - CT
  - CT GL
---

## Overview
The current path to find the device on linux 6.1 `/sys/bus/iio/devices/iio\:device0/`.
This product is using MMA8452Q sensor and more information can be found at
[NXP Semiconductors MMA8452Q Sensor](https://www.nxp.com/docs/en/data-sheet/MMA8452Q.pdf)


## Wakeup from suspend
Not yet supported in software.

## For Linux 3.1 system

## Wakeup from suspend
Not yet supported in software.

### Examples
Path in sysfs: /sys/class/sensor/mma/ <br>
Read x,y,z: value_{x,y,z} <br>

Interrupts from the accelerometer are routed to two GPIOs on the Colibri
module. The GPIOs are not exported.
Data ready is routed to INT1, other interrupts are routed to INT2.
INT1 is the first mma interrupt seen in /proc/interrupts.

All data generated from interrupts are accessed via chardevs.
lsinput and input-event are part of package input-utils.
```bash
lsinput
/dev/input/event0
   bustype : (null)
   vendor  : 0x0
   product : 0x0
   version : 0
   name    : "mma845x"
   bits ev : EV_SYN EV_ABS

/dev/input/event1
   bustype : (null)
   vendor  : 0x0
   product : 0x0
   version : 0
   name    : "Accl1"
   bits ev : EV_SYN EV_KEY EV_ABS EV_MSC
```
mma845x is for coordinate data. Accl1 is for configured interrupts.


Most of the possibilities mentioned in the mma8452 datasheet are available for
configuration via the driver sysfs interface.  

Example for testing transient interrupts.
```bash
cd /sys/class/sensor/mma/transitent_detection0
echo enable,enable,enable > enable
echo 1 > threshold # set lowest possible threshold for transient
input-events 1
# Move the device to generate a movement transient
# Output:
dev/input/event1
   bustype : (null)
   vendor  : 0x0
   product : 0x0
   version : 0
   name    : "Accl1"
   bits ev : EV_SYN EV_KEY EV_ABS EV_MSC

waiting for events
00:18:33.808626: EV_KEY KEY_LEFTSHIFT pressed
00:18:33.808629: EV_KEY KEY_G pressed
00:18:33.808633: EV_KEY KEY_G released
00:18:33.808635: EV_KEY KEY_LEFTSHIFT released
00:18:33.808639: EV_ABS ??? 96
00:18:33.808643: EV_ABS ??? 0
00:18:33.808644: EV_SYN code=0 value=0

Test to set the auto_wakeup or change the sample rate
echo disable > /sys/class/sensor/mma/auto_wakeup
cat /sys/class/sensor/mma/auto_wakeup
echo enable > /sys/class/sensor/mma/auto_wakeup
cat /sys/class/sensor/mma/auto_wakeup

supported sample rate in 3.1.10
cat /sys/class/sensor/mma/supported_odr
800.0;400.0;200.0;100.0;50.0;12.500;6.250;1.560

test maximum and minimum
echo 800.0 > /sys/class/sensor/mma/odr
cat /sys/class/sensor/mma/odr

echo 1.560 > /sys/class/sensor/mma/odr
cat /sys/class/sensor/mma/odr

```
