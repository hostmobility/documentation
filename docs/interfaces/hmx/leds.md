---
title: LEDs (HMX)
tags:
  - LED
  - HMX
---

## Overview

This platform has red, green and yellow LEDs and special function leds that are external(connectors outputs).

This platform also have a RGB led called indicator, that currently design(HM010-xxxXx-V6B) are hidden from view. If you can see it it is blue on u-boot and green on running linux. white flashing indicate bsp reflashing and red if something has got wrong with the flashing, see [update](../../system/update.md).

All leds can be used as you like and they are just named. the yellow:power is setup from device tree with heartbeat trigger and will blink if the system is running.

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
