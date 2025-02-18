---
title: LEDs (HMM)
tags:
  - LED
  - HMM
---

## Overview

This platform has four red, green and yellow light-emitting diodes (LEDs).

LEDs are used to indicate [system flashing](../../system/update.md).

LED 1 will be yellow when entering u-boot and green when leaving. The same LED is then set up with a heartbeat trigger from device tree and blink in green light to indicate that the system is running.

### The following LEDs are available

| Name        | Overlay Typical Name | Default mode |
|-------------|----------------------|--------------|
| green:LED_1 | A                    | Heartbeat    |
| red:LED_1   | A                    | Off          |
| green:LED_2 | B                    | Off          |
| red:LED_2   | B                    | Off          |
| green:LED_3 | C                    | Off          |
| red:LED_3   | C                    | Off          |
| green:LED_4 | D                    | Off          |
| red:LED_4   | D                    | Off          |


### Default front
Overlay illustration (HM020-003711, HM020-010411)

 - 🟢 D
 - 🟢 C 
 - 🟢 B 
 - 🟢 A

### System built in modes

| Stage                             | LED 4 (Top) | LED 3 | LED 2 | LED 1 (Bottom)     |
|-----------------------------------|------------|-------|-------|---------------------|
| **Power On**                      | 🟡         | 🟡    | 🟡    | 🟡                |
| **Booting U-Boot**                | ⚫         | ⚫    | ⚫    | 🟡                |
| **Bootscript(load bootfs)**       | ⚫         | ⚫    | ⚫    | ⚫                |
| **Flashing Mode(initial USB*)**   | ⚫         | ⚫    | ⚫    | ⚫                |
| **File Load OK**                  | ⚫         | 🟢    | ⚫    | ⚫                |
| **File Load Fail(USB*)**          | ⚫         | 🔴    | ⚫    | ⚫                |
| **Flash Success**                 | 🟢         | 🟢    | ⚫    | ⚫                |
| **Booting Linux**                 |            |        | ⚫    | 🟢                |
| **Linux Running**                 | ⚫         | ⚫    | ⚫    | 🟢/⚫(blinking)  |
 - *USB= Flashing with USB memory stick
