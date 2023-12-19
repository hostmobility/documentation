---
title: LEDs
tags:
  - LED
  - HMX
  - C61
  - MX-4
  - MX-V
  - T30
  - T30 FR
  - CT
---

## Overview
LEDs are typically accessed through the [Linux LED subsystem API](https://docs.kernel.org/leds/leds-class.html).

(*For MX-4, refer to [mx4-leds](mx4/leds.md).*)

## Set LED
```
echo heartbeat > /sys/class/leds/red:gps/trigger
# On
echo 1 >  /sys/class/leds/mx4-wifi/brightness
echo 1 >  /sys/class/leds/mx4-wifi-red/brightness
# Off
echo 0 >  /sys/class/leds/mx4-wifi/brightness
echo 0 >  /sys/class/leds/mx4-wifi-red/brightness
```

## Platform specific

- [hmx-leds](hmx/leds.md)
- [mxv-leds](mxv/leds.md)
- [mx4-leds](mx4/leds.md)
