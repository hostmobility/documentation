---
title: HMX Accelerometer
tags:
    - HMX
---

## Overview
The current path to find the device on linux 6.1 `/sys/bus/iio/devices/iio\:device0/`.
This product is using LIS2HH12 sensor and more information can be found at
[STMicroelectronics LIS2HH12 Sensor](https://www.st.com/en/mems-and-sensors/lis2hh12.html)

## Change sample frequency
```
cat /sys/bus/iio/devices/iio\:device0/sampling_frequency_available
10 50 100 200 400 800
echo 800 > /sys/bus/iio/devices/iio\:device0/sampling_frequency
```
## Activate data ready pin INT1
```bash
i2cset -f -y 3 0x1e 0x22 1
cat /proc/interrupts | grep lis2hh12-trigger
168:          0          0          0          0  gpio-mxc   2 Edge      lis2hh12-trigger
```

## Activate triggers
This is just an example of the registers that need to be changed to be able to activate a trigger interupt on INT1 pin. The example works for horizontal trigger point.For wake up the system from the INT1 is not yet confirmed.
```bash
#Place the device in flat position
i2cset -f -y 3 0x1e 0x20 0x3F # CTRL1: X, Y, Z enabled, ODR = 100 Hz, BDU enabled
i2cset -f -y 3 0x1e 0x21 0x00 # CTRL2: High-pass filter disabled
i2cset -f -y 3 0x1e 0x22 0x08 # CTRL3: Interrupt generator 1 on INT1 pin
i2cset -f -y 3 0x1e 0x23 0x04 # CTRL4: FS = 2g, Register address automatically incremented during a multiple byte access with a serial interface
i2cset -f -y 3 0x1e 0x24 0x00 # CTRL5: Interrupt active-high; Interrupt pins push-pull configuration
i2cset -f -y 3 0x1e 0x26 0x04 # CTRL7: Interrupt 1 latched
i2cset -f -y 3 0x1e 0x33 0x05 # IG_THS_Y1: Threshold = 250 mg [(2/256)*32 = 250 mg] =0x20 . 0x05?
								#i2cset -f -y 3 0x1e 0x33 0x00 // IG_DUR1: No duration
i2cset -f -y 3 0x1e 0x30 0x04 # IG_CFG1: Enable YLIE interrupt generation

#clear interrupt register
while true; do i2cget -f -y 3 0x1e 0x31 ; sleep 1; done;

#systemctl suspend
```


