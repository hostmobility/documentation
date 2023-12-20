---
title: LEDs (MX-V)
tags:
  - LED
  - MX-V
---

## Overview

This platform has red and greed LEDs.

**Warning:** Uncontrolled behavior of the GNSS red LED, after power on and which doesn't disappear in less than one second, indicates that the main CPU has been hanged. The coprocessor will then restart the system. If the problem persists, the platform has no working internal flash or BOR level is set to low for the coprocessor. If this happens, contact us at support@hostmobility.com and we will help you.

When power up the "func LED" red is lit when the main processor has enter u-boot state and will be turned off by linux system.

The power LED is controlled by the coprocessor and the func LED green is set up from device tree with heartbeat trigger and will blink if the system is running (average CPU load).
The power led is lit green when co-cpu is running and sometimes the co-cpu lit the red led short it is currently some debug prints and if it is solid lit it has an error.

### The following LEDs are available on the MX-V

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
