---
title: Power Management (MX-4)
tags:
  - Power Management
  - MX-4
---

## Overview of Suspend Design

The MX-4 platform consists of two CPUs:

- The main CPU runs Linux and user applications.
- The co-CPU serves multiple purposes (PMIC, GPIO chip, analog inputs, hardware watchdog, etc.).

The main CPU initiates sleep/suspend mode, while wakeup can be triggered by either CPU, depending on the wakeup source (see [Wakeup](#wakeup)).

During sleep/suspend mode:

- The main CPU powers off most peripherals.
- The co-CPU runs on internal low-power RC (32 kHz) and performs cyclic sleep.
- 3.3 V and 5 V power off, specific to different MX-4 platforms.

**Warning:** Peripherals that lose power and need re-initialization after wakeup:

- SD-card (Unmount before sleep, re-mounted on wakeup)
- Wifi
- UARTS
- CAN (T30 FR optional power on/off for CAN transceivers)
- Ethernet
- Flexray

## Enter Sleep

A script, `/opt/hm/go_to_sleep.sh`, provided by Host Mobility facilitates entering sleep/suspend mode:

```bash
Usage: go_to_sleep.sh options (t:hdcCnsaD)
                -t <time in seconds> - Setup wakealarm (rtc)
                -d - Disable wake on DIGITAL-IN-2
                -a - Disable wake on START-SIGNAL
                -l <mV level> - START-SIGNAL wake-up volt level
                -c - Wake on CAN
                -n - Will renew dhcp lease
                -C - Disable suspend CAN for quicker wakeup-time"
                -s - Will suspend modem (turn off), Will not restore on wake up
                -D <time in seconds> - Will enter deep sleep.
                        Power to main CPU will be cut after specified time and it
                        will restart with a cold reboot on wake up. The application
                        is responsible of shutting down the system properly before
                        the power is cut.
                -p <wake up mask> - Mask to enable/disable wakeup sources
                -h - Print this text
```

#### Wakeup

The MX-4 platform supports various wakeup sources. Not all MX-4 platforms support all wakeup sources:

- Digital Inputs (DIGITAL-IN-2 is enabled by default as a wakeup source)
- Analog Inputs
- Wake on CAN
- Wake on RTC (wake up after x seconds)
- Wake on RING (call/SMS to modem) - Not yet supported in software
- Wake on Accelerometer - Not yet supported in software

##### Wake on Digital Inputs

By default, DIGITAL-IN-2 (rising edge) is enabled as a wakeup source, mostly due to historical reasons. To disable it, use the `-d` option with `go_to_sleep.sh`.

On some platforms, DIGITAL-IN-2 is the only digital input capable of waking up the system.

Supported digital inputs as wakeup sources, see [](../interfaces/mx4/digital_io.md#list-of-ios)

**Note:** If `-d` option is not specified, it will always set bit 4 in the wakeup mask, regardless of what you passed.

**Note:** If `-d` option is specified with -t or without any other wakeup flag (use WAKE_UP_SRC_MODEM_RING bitmask or set -l to a voltage level higer than input voltage), the system will reboot itself. See [Reset Cause](reset_cause.md)

To enable different wakeup sources and set the edge, use the `-p` option with a bitmask (see [wake up cause](wake_up_cause.md)

##### Wake on Analog Inputs

Analog inputs as wakeup sources are not managed by `go_to_sleep.sh`.

All analog inputs have four sysfs files associated with them. For example, if we take input voltage:

[Sysfs files and their purposes]

- `input_voltage` reads the value of input voltage.
- `input_voltage_calibration_u` calibrates the input for component tolerances.
- `input_voltage_threshold_high` enables wake on a high-level threshold.
- `input_voltage_threshold_low` enables wake on a low-level threshold.

Examples for wakeup setup:

```bash
# Wakeup system from sleep/suspend if input voltage is above 16 V
root@mx4-vcc-1000000:~# echo 16000 > /opt/hm/pic_attributes/input_voltage_threshold_high
```

```bash
# Wakeup system from sleep/suspend if input voltage is below 12 V
root@mx4-vcc-1000000:~# echo 12000 > /opt/hm/pic_attributes/input_voltage_threshold_low
```

```bash
# Wakeup system from sleep/suspend if input voltage is in the range of 12-16 V
root@mx4-vcc-1000000:~# echo 16000 > /opt/hm/pic_attributes/input_voltage_threshold_high
root@mx4-vcc-1000000:~# echo 12000 > /opt/hm/pic_attributes/input_voltage_threshold_low
```

```bash
# Write 0 to both threshold files to disable that specific input as wakeup source
root@mx4-vcc-1000000:~# echo 0 > /opt/hm/pic_attributes/input_voltage_threshold_high
root@mx4-vcc-1000000:~# echo 0 > /opt/hm/pic_attributes/input_voltage_threshold_low
```
User setup for analog wakeup sources is required before calling `go_to_sleep.sh`. See [Enter sleep](#enter-sleep).

##### Wake on CAN

Wake on CAN isn't supported on all MX-4 platforms. Contact Host Mobility support for compatibility information.

Enable Wake on CAN by passing `-c` to `go_to_sleep.sh` (see [Enter sleep](#enter-sleep)). However, before doing this, specific CAN buses should be enabled as wakeup sources.

By default, all CAN buses will trigger a wakeup if there is traffic on them and `-c` is passed to `go_to_sleep.sh`. For T30 FR it is possible to wake up on single specific CAN frame(`can-xcvr`).

GPIOs are used to set this up:

```bash
root@mx4-vcc-1000000:~# cat /sys/kernel/debug/gpio | grep -i wakeup
 gpio-58  (P169 - CAN0-WAKEUP  ) out lo
 gpio-59  (P171 - CAN1-WAKEUP  ) out lo
 gpio-60  (P173 - CAN2-WAKEUP  ) out lo
 gpio-61  (P175 - CAN3-WAKEUP  ) out lo
 gpio-62  (P177 - CAN4-WAKEUP  ) out lo
 gpio-63  (P179 - CAN5-WAKEUP  ) out lo
```

To disable wakeup for a specific bus, write a 1 to that GPIO's value.

```bash
# Disable wakeup on CAN0
root@mx4-vcc-1000000:~# echo 1 > /sys/class/gpio/gpio58/value

```

### Wake up cause

Read which signal that made the platform to wake up. See [wake up cause](wake_up_cause.md).

### Deep Sleep

Deep sleep mode puts the co-CPU to sleep while cutting the power rail to the main CPU. Upon wakeup, a cold reboot occurs instead of a fast resume, trading off for lower consumption during the suspended state.

Wakeup sources available from deep sleep vary across different platforms.

Enter deep sleep by passing the `-D` option to `go_to_sleep.sh`. See [Enter sleep](#enter-sleep).

**Note:** CT and CT GL does not support Deep Sleep

### Shutdown

Not all MX-4 platforms support this mode. Contact Host Mobility support for information on compatibility.

The MX-4 shutdown/cutoff state turns the system off with close to zero power consumption:

```bash
# Cutoff in 60 seconds
root@mx4-vcc-1000000:~# echo 60 > /opt/hm/pic_attributes/ctrl_on_4v
```

In this example, within 60 seconds, the system will cut the 4V power and restart only if [Start signal](../../interfaces/mx4/start_signal.md) is LOW.

Before these 60 seconds elapse, ensure the application finishes and runs `poweroff` to shut down Linux command `poweroff`