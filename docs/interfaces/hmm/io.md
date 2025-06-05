---
title: IOs (HMM)
tags:
  - ADC
  - Digital I/O
  - HMM
---

## Overview

The Host Monitor Mini platform has optionally two analog inputs that share connector pins with two digital outputs and two digital inputs.  
Analog In (ADC) can detect short circuits or monitor signals within the supported voltage range. Please consult the detailed technical documentation for more exact limits.
These pins can also be used to measure current consumption from 0-20mA.

## IO Modes

| IO | Digital In | Digital Out (source or sink activate) | Analog In | Current Consumption Mode (activate)|
|----|-----------|------------|-----------|--------------------------|
| IO1 | `$(gpioget $(gpiofind digital-in-0))` | `gpioset $(gpiofind digital-out-sink-0)=1`<br>`gpioset $(gpiofind digital-out-source-0)=1` | `cat /sys/bus/iio/devices/iio:device0/in_voltage3_raw` | `gpioset $(gpiofind enable-analog-in-20ma-0)=1` |
| IO2 | `$(gpioget $(gpiofind digital-in-1))` | `gpioset $(gpiofind digital-out-sink-1)=1`<br>`gpioset $(gpiofind digital-out-source-1)=1` | `cat /sys/bus/iio/devices/iio:device0/in_voltage2_raw` | `gpioset $(gpiofind enable-analog-in-20ma-1)=1` |
