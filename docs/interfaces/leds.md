---
title: LEDs
tags:
  - LED
  - HMM
  - HMX
  - C61
  - MX-4
  - MX-V
  - T30
  - T30 FR
  - CT
  - CT GL
---

## Overview
LEDs are typically accessed through the [Linux LED subsystem API](https://docs.kernel.org/leds/leds-class.html).

All LEDs can be used as you wish and they are just named except the "Power" LED.

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

- [HMM](hmm/leds.md)
- [HMX](hmx/leds.md)
- [MX-V](mxv/leds.md)
- [Mx4](mx4/leds.md)
