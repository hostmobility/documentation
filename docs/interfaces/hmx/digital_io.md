---
title:  Host Monitor x Digital I/O
tags:
    - HMX
---
## Overview
  Hmx has specific Digital IOs and below is a list of those that is supported. 
  Check technical file for more information about the diffrent thersholds and if it possible to change state (digital out)

## List of supported outputs

There is four diffrent types of digital outputs.

- outputs with possible to sink a signal to gnd 
    - SINK_OUT_1
    - SINK_OUT_2
- Activate eth2 network on OBDII cable
    - Digital_output_ETH2_ACT
- outputs with possible to source VCC power (they have diffrent maximium current)
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
- output with both an internal buzzer and possible to connect a external buzzer.
    - SOURCE_PWR_OUT_BUZZER

## List of supported inputs

Two types of digital inputs.

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
