---
title: Tachometer
tags:
  - Tachometer
  - CT
  - CT GL
  - T30
  - T30 FR
  - MX-V
---

## Overview

This input is designed for use with a tachometer output. The coprocessor counts the number of pulses registered on this input, making it available to the system.

## MX-4
- **CT**
    - Supports slow signal changes; can be used as a digital input.

- **CT GL**
    - From hm001-1-P1C, tachometer will work up to 20kHz.
    - hm001-1-P1B and older support slow signal changes.

- **T30 and T30 FR**
    - Support slow signal changes; can be used as a digital input.

### Examples

- **Read**

```
cat /opt/hm/pic_attributes/c3_counter
```

- **Reset counter**

```
echo 0 > /opt/hm/pic_attributes/c3_counter
```

## MX-V
Supported up to 20kHz.

### Example

- **Read**

```
cat /sys/bus/iio/devices/iio:device0/in_voltage24_TACHOMETER_VALUE_raw
```
