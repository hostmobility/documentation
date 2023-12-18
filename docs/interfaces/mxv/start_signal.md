---
title:  Start signals
tags:
    - MX-V
---
## Overview

This unit has two start signals named KL15 and only one is needed to start the unit.
Read the start signal and the output is in millivoltage.

```bash
cat /sys/bus/iio/devices/iio:device0/in_voltage5_KL15_AN_raw
24234
```