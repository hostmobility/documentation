---
title:  MX-4 Start signals
tags:
    - T30
    - T30 FR
    - MX-4
    - CT
    - CT GL
    - C61
---

## Read start signal

All products based on the MX-4 platform can read the start signal. The output is in millivolt.
```bash
root@mx4-t30-29009999:~# cat /opt/hm/pic_attributes/start_signal
21351
```

## T30 and T30 FR

These machines have two external start signals and one "Start Signal Slide Switch" located between two D-sub connectors. The Start Signal Slide Switch is marked INT (internal) and EXT (external). Sliding the switch to INT enables start at power on, without the need of an external start signal. This switch can also be read from Linux user space.
```
# Modern way:
gpioget $(gpiofind 'start switch')
# Old way:
cat /sys/class/gpio/gpio$( grep 'start switch' /sys/kernel/debug/gpio | cut -d '-' -f2 | cut -d ' ' -f1 )/value

## CT and CT GL

The majority of units have two start signals. The older ones, HMP069-5(3,1), have only one. The signal names are ANALOG-IN-1 and ANALOG-IN-2 on the connector. See the technical specification for more details.

## C61

This product has one start signal located on the D-sub 15.




