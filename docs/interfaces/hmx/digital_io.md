---
title:  Digital I/O (HMX)
tags:
  - Digital I/O
  - HMX
---
## Overview
The HMX-specific Digital I/Os are listed below. Check the technical file for more information about the different thresholds and whether it's possible to change state (digital out).

## List of supported outputs

There are four different types of digital outputs.

- outputs with ability to sink a signal to ground
    - SINK_OUT_1
    - SINK_OUT_2
- Activate eth2 network on OBDII cable
    - Digital_output_ETH2_ACT
- outputs with ability to source VCC power (they have different maximum current)
    - SOURCE_Digital_OUT_1
    - SOURCE_Digital_OUT_2
    - SOURCE_OUT_3
    - SOURCE_OUT_4
    - SOURCE_OUT_5
    - SOURCE_OUT_6
    - SOURCE_OUT_7
    - SOURCE_OUT_8
    - SOURCE_PWR_OUT_LED_1
    - SOURCE_PWR_OUT_LED_2
- output with both an internal buzzer and the ability to connect an external buzzer.
    - SOURCE_PWR_OUT_BUZZER

## List of supported inputs

There are two types of digital inputs:

- Pull down (33k to GND)
    - Digital_input_pulldown_1
    - Digital_input_pulldown_2
- pull up (33k to VCC)
    - Digital_input_pullup_1
    - Digital_input_pullup_2
    - Digital_input_HMI_1
    - Digital_input_HMI_2

## Fault detection

The unit has fault detection that goes high if a fault is detected.

- SOURCE_1_Fault
- SOURCE_2_Fault
- SOURCE_4_Fault
- SOURCE_5_Fault
- SOURCE_6_Fault

## Sleep and wake up

For Digital in, wake-up is default on if you want to disable the inputs. one way is to change the device tree when buildding the image, the other way is to unbind the gpio-keys.
```
echo gpio-keys > /sys/bus/platform/drivers/gpio-keys/unbind
```
when wake it up bind it again if you want to use the gpio-keys.