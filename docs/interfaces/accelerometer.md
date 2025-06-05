---
title: Accelerometer
tags:
  - Accelerometer
  - HMM
  - HMX
  - C61
  - MX-4
  - MX-V
---

## Overview

The accelerometer is presented as an industrial i/o device(iio). It can be
found at `/sys/bus/iio/devices/iio\:device0/in_accel_*`

## Platform specific

- [HMX](hmx/accelerometer.md)
- [MX-4 T30/T30fr](mx4/accelerometer.md)
- [C61](mx4/accelerometer.md)
- [MX-4](mx4/accelerometer.md)
- [MX-V](mx4/accelerometer.md)
- [CT](mx4/accelerometer.md)

## Example

```bash
root@mxv-pt:~# cat /sys/bus/iio/devices/iio\:device0/in_accel_*
0.000000
0.250000 0.500000 1.000000 2.000000
4
4 32 2
50.000000
0.009577
0.038307 0.019154 0.009577
0
18
0
31
0
1037
cat /sys/bus/iio/devices/iio:device0/in_accel_x_raw
cat /sys/bus/iio/devices/iio:device0/in_accel_y_raw
cat /sys/bus/iio/devices/iio:device0/in_accel_z_raw
```

