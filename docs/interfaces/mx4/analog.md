---
title: Analog Inputs (ADC) (MX-4)
tags:
  - ADC
  - C61
  - CT
  - CT GL
  - T20
  - T30
  - T30 FR
---

## Overview

The ADC conversions are managed by the co-processor and the values are exposed as sysfiles.


- C61
    - input_voltage
    - analog_1
    - analog_2
    - [Start signals](start_signal.md)
    - More information see [IIOs](../c61/io.md)
- CT and CT GL
    - input_voltage
    - input_battery
    - analog_1 (start signal, analog in 1A&B)
    - analog_2 (4-20mA)
    - analog_3 (0-32V)
    - analog_4 (0-32V)
    - [Start signals](start_signal.md)
- T20, T30 and T30 FR
    - input_voltage
    - input_battery
    - analog_1
    - [Start signals](start_signal.md)


```bash
# ls /opt/hm/pic_attributes/ | grep -i analog
analog_1_calibration_u
analog_1_uA
analog_2_calibration_u
analog_2_uA
analog_3_calibration_u
analog_3
analog_4_calibration_u
analog_4
root@mx4-gtt:~# ls /opt/hm/pic_attributes/ | grep -i input
input_battery_calibration_u
input_battery
input_battery_threshold_high
input_battery_threshold_low
input_temperature_calibration_u
input_temperature_mC
input_voltage_calibration_u
input_voltage
input_voltage_threshold_high
input_voltage_threshold_low
```

Calibration files are not be used by end users.

#### Example reading input voltage

```bash
cat /opt/hm/pic_attributes/input_voltage
14917
```

#### Example of when Vref (ADC reference voltage) is turned off.

Vref should normally be always on but it is turned off when entering sleep
([go_to_sleep.sh](https://github.com/hostmobility/mx4/blob/master/scripts/mx4/go_to_sleep.sh)).
If you poll ADC values while entering sleep you will get some errors after Vref
has been turned off. 
**Note:** Coprocesssor firmware 2.8.2 and later (CT and T30/T30 FR) vref and other power are turned off after main processor by the coprocessor so it should not be any errors even in late state of go_to_sleep.sh. 

```bash
# echo 0 > /sys/class/gpio/gpio243/value
# cat /opt/hm/pic_attributes/input_voltage
cat: read error: Operation not permitted
```