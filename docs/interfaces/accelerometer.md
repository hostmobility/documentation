# Accelerometer

## Overview

The accelerometer is presented as an industrial i/o device(iio). It can be
found at `/sys/bus/iio/devices/iio\:device0/in_accel_*`

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
```

