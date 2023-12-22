---
title: Power management (HMX)
tags:
  - Power management
  - HMX
---
## Overview

This platform supports suspend and a long range of wake-up signals. See the individual [wake up](#wake-up) links below.
### Suspend

Click on target interface to read more about how to set up the sleep and wake up.

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

Shutdown/cutoff state turns the system off with close to zero power consumption. And it will only work if both internal and external [Start signals](../../interfaces/hmx/start_signal.md) are LOW/off.

```bash
shutdown -h now
#or
poweroff
```

