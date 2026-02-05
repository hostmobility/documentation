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
### Configure wakeup source in userspace

The following list is generated using a script. Note that **paths and wakeup IDs may change** depending on your software and hardware version. If unsure, you can find the script [here](list_wakeup_source.sh) and run it on your device to get a similar output.

#### Hardware Mapping (Helper)
Use this list to identify which physical interface corresponds to which CAN interface or component:

*   **3-001e** -> **Accelerometer**
*   **1-0051** -> **RTC** (Main board w/ battery backup)
*   **30370000.snvs:snvs-rtc-lp** -> **Module RTC**
*   **spi1.2** -> **CAN4**
*   **spi1.3** -> **CAN5**
*   **spi3.0** -> **CAN0**
*   **spi3.1** -> **CAN3**
*   **308c0000.can** -> **CAN2**
*   **308d0000.can** -> **CAN1**

#### Wakeup Sources Table

| WAKEUP ID | IFACE | SET WAKEUP PATH | STATUS | EVENTS | EVENTS PATH |
|-----------|-------|--------------|--------|--------|-------------|
| wakeup0 | platform | /sys/devices/platform/soc@0/30000000.bus/30370000.snvs/30370000.snvs:snvs-powerkey/power/wakeup | enabled | 0 | /sys/class/wakeup/wakeup0/event_count |
| wakeup1 | platform | /sys/devices/platform/soc@0/30000000.bus/30370000.snvs/30370000.snvs:snvs-rtc-lp/power/wakeup | enabled | 0 | /sys/class/wakeup/wakeup1/event_count |
| wakeup10 | i2c | /sys/bus/i2c/devices/3-001e/power/wakeup | enabled | 0 | /sys/class/wakeup/wakeup10/event_count |
| wakeup11 | spi | /sys/bus/spi/devices/spi1.2/power/wakeup | enabled | 0 | /sys/class/wakeup/wakeup11/event_count |
| wakeup12 | spi | /sys/bus/spi/devices/spi1.3/power/wakeup | enabled | 0 | /sys/class/wakeup/wakeup12/event_count |
| wakeup13 | spi | /sys/bus/spi/devices/spi3.0/power/wakeup | enabled | 0 | /sys/class/wakeup/wakeup13/event_count |
| wakeup14 | spi | /sys/bus/spi/devices/spi3.1/power/wakeup | enabled | 0 | /sys/class/wakeup/wakeup14/event_count |
| wakeup2 | rtc | /sys/devices/platform/soc@0/30000000.bus/30370000.snvs/30370000.snvs:snvs-rtc-lp/rtc/rtc1/alarmtimer.0.auto/power/wakeup | enabled | 0 | /sys/class/wakeup/wakeup2/event_count |
| wakeup3 | unknown | n/a | n/a | 0 | /sys/class/wakeup/wakeup3/event_count |
| wakeup4 | unknown | n/a | n/a | 0 | /sys/class/wakeup/wakeup4/event_count |
| wakeup5 | unknown | n/a | n/a | 0 | /sys/class/wakeup/wakeup5/event_count |
| wakeup6 | gpio | /sys/devices/platform/gpio-keys/power/wakeup | enabled | 242 | /sys/class/wakeup/wakeup6/event_count |
| wakeup7 | platform | /sys/devices/platform/soc@0/30800000.bus/30800000.spba-bus/308c0000.can/power/wakeup | enabled | 0 | /sys/class/wakeup/wakeup7/event_count |
| wakeup8 | platform | /sys/devices/platform/soc@0/30800000.bus/30800000.spba-bus/308d0000.can/power/wakeup | enabled | 0 | /sys/class/wakeup/wakeup8/event_count |
| wakeup9 | i2c | /sys/bus/i2c/devices/1-0051/power/wakeup | enabled | 1060 | /sys/class/wakeup/wakeup9/event_count |

#### Examples

**Disable wakeup source (e.g., RTC):**
```bash
echo disabled > /sys/bus/i2c/devices/1-0051/power/wakeup
```
**Enable wakeup source (e.g., RTC):**
```bash
echo enabled > /sys/bus/i2c/devices/1-0051/power/wakeup
```