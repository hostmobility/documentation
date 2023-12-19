---
title: LEDs (MX-V)
tags:
  - LED
  - MX-V
---

## Overview

This platform has red and greed LEDs.

All leds can be used as you like and they are just named.

**Warning:** GNSS led can be lit when powered and if it not turn off in 1 sec the main cpu has been hanged, the co-cpu will restart the system and if it continues the unit has failed to boot u-boot.

Start up the func led red is lit when enter u-boot state and off in linux.

The power led is controlled buy the co-cpu and the func led green is setup from device tree with heartbeat trigger and will blink if the system is running.
The power led is lit green when co-cpu is runing and somtimes the co-cpu lit the red led short it is currently some debug prints and if it is solid lit it has an error.

### The following leds are available on HMX

| Name                 | Use Case               |
| ---------------------|------------------------|
| func_led_green       | Functional LED (Green) |
| func_led_red         | Functional LED (Red)   |
| gps_led_green        | GNSS LED (Green)        |
| gps_led_red          | GNSS LED (Red)          |
| modem_led_green      | LTE LED (Green)      |
| modem_led_red        | LTE LED (Red)        |
| wifi_led_green       | Wi-Fi LED (Green)      |
| wifi_led_red         | Wi-Fi LED (Red)        |
