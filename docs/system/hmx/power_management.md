---
title: Power management (HMX)
tags:
  - Power management
  - HMX
---
## Overview

This platform support this types of wake up signals and to wake up on them check [wake up](#wake-up) links.
### Suspend

#### Wake up
- [CAN0](../../interfaces/hmx/can.md)
- [CAN1](../../interfaces/hmx/can.md)
- [CAN2](../../interfaces/hmx/can.md)
- [CAN3](../../interfaces/hmx/can.md)
- [CAN4](../../interfaces/hmx/can.md)
- [CAN5](../../interfaces/hmx/can.md)
- [T1-0](../../interfaces/hmx/ethernet.md) T1 connected eth2. Not working in current rev of the HW because of not implemeted support in phy chip for 100 and 1000 based.
- [T1-1](../../interfaces/hmx/ethernet.md) T1 connected eth3. Not working in current rev of the HW because of not implemeted support in phy chip for 100 and 1000 based..
- [START_1](../../interfaces/hmx/start_signal.md)
- [START_2](../../interfaces/hmx/start_signal.md)
- [START_3](../../interfaces/hmx/start_signal.md)
- [START_4](../../interfaces/hmx/start_signal.md)
- [START_5](../../interfaces/hmx/start_signal.md)
- [Digital_input_pulldown_1](../../interfaces/hmx/digital_io.md)
- [Digital_input_pulldown_2](../../interfaces/hmx/digital_io.md)
- [Digital_input_pullup_1](../../interfaces/hmx/digital_io.md)
- [Digital_input_pullup_2](../../interfaces/hmx/digital_io.md)
- [Digital_input_HMI_1](../../interfaces/hmx/digital_io.md)
- [Digital_input_HMI_2](../../interfaces/hmx/digital_io.md)
- [RTC internal alarm (rtc1)](../../interfaces/rtc_alarm.md)
- [RTC External alarm (rtc0)](../../interfaces/rtc_alarm.md)
- [Accelerometer](../../interfaces/hmx/accelerometer.md)
- [Modem](../../interfaces/hmx/modem.md) - not supported by the software right now.

#### Digital in
Disabling digital inputs can be done with:
```
echo gpio-keys > /sys/bus/platform/drivers/gpio-keys/unbind
```
#### CAN

To activate wake up on CAN you will need to set up the channel and go bus on, if not it is disabled.
Wake up on individual CAN frame is teoretical supported.

#### Accelerometer

This has been tested to use [triggers](../../interfaces/hmx/accelerometer.md#activate-triggers) but currently not able to wake up main cpu.

#### Real time clock

[RTC alarm](../../interfaces/rtc_alarm.md)


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

