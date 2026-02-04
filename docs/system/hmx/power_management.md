---
title: Power management (HMX)
tags:
  - Power management
  - HMX
---
## Overview

This platform supports suspend and a long range of wake-up signals. See the individual [wake up](#wake-up) links below.
### Suspend

Click on the target interface to read more about how to set up sleep and wake up.

#### Wake up

- [CAN0](../../interfaces/hmx/can.md#sleep-and-wake-up)
- [CAN1](../../interfaces/hmx/can.md#sleep-and-wake-up)
- [CAN2](../../interfaces/hmx/can.md#sleep-and-wake-up)
- [CAN3](../../interfaces/hmx/can.md#sleep-and-wake-up)
- [CAN4](../../interfaces/hmx/can.md#sleep-and-wake-up)
- [CAN5](../../interfaces/hmx/can.md#sleep-and-wake-up)
- [T1-0](../../interfaces/hmx/ethernet.md#sleep-and-wake-up)
- [T1-1](../../interfaces/hmx/ethernet.md#sleep-and-wake-up)
- [START_1](../../interfaces/hmx/start_signal.md)
- [START_2](../../interfaces/hmx/start_signal.md)
- [START_3](../../interfaces/hmx/start_signal.md)
- [START_4](../../interfaces/hmx/start_signal.md)
- [START_5](../../interfaces/hmx/start_signal.md)
- [Digital_input_pulldown_1](../../interfaces/hmx/digital_io.md#sleep-and-wake-up)
- [Digital_input_pulldown_2](../../interfaces/hmx/digital_io.md#sleep-and-wake-up)
- [Digital_input_pullup_1](../../interfaces/hmx/digital_io.md#sleep-and-wake-up)
- [Digital_input_pullup_2](../../interfaces/hmx/digital_io.md#sleep-and-wake-up)
- [Digital_input_HMI_1](../../interfaces/hmx/digital_io.md#sleep-and-wake-up)
- [Digital_input_HMI_2](../../interfaces/hmx/digital_io.md#sleep-and-wake-up)
- [RTC internal alarm (rtc1)](../../interfaces/rtc_alarm.md)
- [RTC External alarm (rtc0)](../../interfaces/rtc_alarm.md)
- [Accelerometer](../../interfaces/hmx/accelerometer.md#sleep-and-wake-up)
- [Modem](../../interfaces/hmx/modem.md#sleep-and-wake-up)


#### Enter suspend
```
systemctl suspend
```
### Shutdown

Shutdown/cut-off state turns the system off with close to zero power consumption. It will only work if both internal and external [Start signals](../../interfaces/hmx/start_signal.md) are LOW/off.

```bash
shutdown -h now
#or
poweroff
```

### Check wakeup source

Most of the signals would be registerd in /sys/class/wakeup and the folowing example gives the temporary name: name: and event_count. Check the counter before enter suspend.
For gpio-keys there is just one counter so START signals and Digital input should be checked in '/dev/input/event'.


```bash
for d in /sys/class/wakeup/wakeup*; do 
    echo -n "$(basename $d): $(cat $d/name) -> " && cat $d/event_count; 
done
```

Example output from a scarthgap system
```
wakeup0: 30370000.snvs:snvs-powerkey -> 0
wakeup1: 30370000.snvs:snvs-rtc-lp -> 0
wakeup10: 3-001e -> 0 (Accelerometer)
wakeup11: spi1.2 -> 0 (CAN)
wakeup12: spi1.3 -> 0 (CAN)
wakeup13: spi3.0 -> 0 (CAN)
wakeup14: spi3.1 -> 0 (CAN)
wakeup2: alarmtimer.0.auto -> 0
wakeup3: mmc2 -> 0
wakeup4: mmc0 -> 0
wakeup5: mmc1 -> 0
wakeup6: gpio-keys -> 242
wakeup7: 308c0000.can -> 0
wakeup8: 308d0000.can -> 0
wakeup9: 1-0051 -> 946 (RTC)
```


