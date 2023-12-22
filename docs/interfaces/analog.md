---
title: Analog inputs (ADC)
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
Many of our products have analog inputs. On the MX-4 platform they are accessible under `/opt/hm/pic_attributes/` (see below). Otherwise we use the standard [Linux Industrial I/O Subsystem](https://wiki.analog.com/software/linux/docs/iio/iio). You can then access the ADC from `sysfs`, typically `/sys/bus/iio/devices/iio\:device*/`.

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
MX-4
```
cat /opt/hm/pic_attributes/analog_1
```