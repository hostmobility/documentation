---
title:  Mx4 start signals
tags:
    - T30
    - T30 FR
    - MX-4
    - CT
    - CT GL
    - C61
---

## Read start signal

All mx4 can read the start signal.And the output is in millivoltage.
```bash
root@mx4-t30-29009999:~# cat /opt/hm/pic_attributes/start_signal
21351
```

## T30 and T30Fr

This unit has two external start signals and one "Start Signal Slide Switch" located between two Dsub connectors. Start Signal Slide Switch is marked INT and EXT and sliding the switch to INT will start the unit without need of external start signal. Also this switch can be read from linux user space.
```
#old way
cat /sys/class/gpio/gpio$( grep 'start switch' /sys/kernel/debug/gpio | cut -d '-' -f2 | cut -d ' ' -f1 )/value
#or
gpioget $(gpiofind 'start switch')
```

## CT and CT GL

Most of the units have two start signals, older HMP069-5(3,1) has only one. The signal name are ANALOG-IN-1 and ANALOG-IN-2 on the connector. see technical documentation for more details.

## C61

This unit has one start signal located on the Dsub15.




