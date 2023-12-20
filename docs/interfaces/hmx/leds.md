---
title: LEDs (HMX)
tags:
  - LED
  - HMX
---

## Overview

This platform has red, green and yellow light-emitting diodes (LEDs) as well as special-function LEDs that are external and can be used with an external LED or other type hardware that needs an signal. See the technical specification for more details

It also features an RGB LED called "indicator" that in the current design (HM010-xxxXx-V6B) is hidden from view. If you can see it, it is blue in U-Boot and green when running Linux. Flashing in white indicates BSP re-flashing and red that something has got wrong with the flashing, see [update](../../system/update.md).

 The yellow:power is set up from device tree with heartbeat trigger and will blink if the system is running.

### The following leds are available on HMX

| Name                 | Use Case                 |
| ---------------------|--------------------------|
| blue:indicator       | Indicator RGB LED        |
| green:func           | Functional LED           |
| green:gps            | GPS-related LED          |
| green:indicator      | Indicator RGB LED        |
| green:wan            | WAN-related LED          |
| green:wlan           | WLAN-related LED         |
| :pwr_out_active      | External LED Output      |
| :pwr_out_buzzer      | External/Internal Buzzer |
| :pwr_out_equipment   | External Output          |
| :pwr_out_led_1       | External LED Output      |
| :pwr_out_led_2       | External LED Output      |
| red:func             | Functional LED           |
| red:gps              | GPS-related LED          |
| red:indicator        | Indicator RGB LED        |
| red:wan              | WAN-related LED          |
| red:wlan             | WLAN-related LED         |
| yellow:power         | Power-related LED        |
