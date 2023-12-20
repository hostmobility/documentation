---
title: Analog Inputs (ADC)
tags:
  - ADC
  - C61
  - MX-V
  - CT
  - CT GL
  - T30
  - T30 FR
---

## Overview
Many of our platforms has analog inputs and beside **MX4** we use standard iio more about it can be found from this link [Industrial Input/Output (iio) framework](https://wiki.analog.com/software/linux/docs/iio/iio).
You can access the adc from `sysfs` with typycal path /sys/bus/iio/devices/iio\:device*/

## Platform specific

- [MX-4](mx4/analog.md)
    - [MX-4 T30/T30fr](mx4/analog.md)
    - [C61 IO](c61/io.md)
    - [CT](mx4/analog.md)
- [MX-V](mxv/analog.md)

## Example

IIO
```
cat /sys/bus/iio/devices/iio:device0/*DIG_IN_AN_8_raw
```
MX4
```
cat /opt/hm/pic_attributes/analog_1
```