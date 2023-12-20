---
title: Power management (MX-4)
tags:
  - Power management
  - MX-4
---

#### Overview of suspend design

The MX-4 platform consists of two cpu's:
- The main CPU which runs Linux and where user applications are run
- The co-cpu which is a multi purpose CPU (PMIC, gpio-chip, analog inputs, hardware watchdog and more)

The main CPU is the one that always initiates sleep/suspend mode.

Wakeup on the other hand could be that main CPU wakes up co-cpu or co-cpu wakes up main CPU (this depends on wakeup source. See [Wakeup](#wakeup)).

When sleep/suspend mode is entered
- The main CPU will enter a mode where most of its peripherals are powered off.
- The co-cpu will run on internal low power RC (32 kHz) and run a cyclic sleep
- 3.3 V is turned off. Consumers differ across different MX-4 platforms
- 5 V is turned off. Consumers differ across different MX-4 platforms

List of periphials that will lose power and that need to be re-initalized after wakeup:
- SD-card - Application should umount SD-card before entering sleep/suspend. Re-mount is handled by platform on wakeup.
- Wifi
- UARTS
- CAN
- Ethernet

#### Enter sleep

Host Mobility provides a script to easy enter sleep/suspend mode. The script is `/opt/hm/go_to_sleep.sh`.

```bash
Usage: go_to_sleep.sh options (t:D:hdcnsal:p:)
                -t <time in seconds> - Setup wakealarm (rtc)
                -d - Disable wake on DIGITAL-IN-2
                -a - Disable wake on START-SIGNAL
                -l <mV level> - START-SIGNAL wake-up volt level
                -c - Wake on CAN
                -n - Will renew dhcp lease
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

The MX-4 platform supports a lot different wakeup sources. Below is a list off supported wakeup sources.
Note that not all MX-4 platforms supports all wakeup sources.
- Digital Inputs (DIGITAL-IN-2 is enabled by default as wakeup source)
- Analog Inputs
- Wake on CAN
- Wake on RTC(wake up after x seconds)
- Wake on RING (call/SMS to modem) - Not yet supported in software
- Wake on Accelerometer - Not yet supported in software

##### Wake on Digital Inputs

By default DIGITAL-IN-2 (rising edge) is enabled as wakeup source. This is mostly for historical reasons. To disable it one can pass `-d` option to `go_to_sleep.sh`.

On some platforms DIGITAL-IN-2 is the only digital input that is capable to wake up the system.

If your output of `cat /sys/kernel/debug/gpio | grep digital` looks like below

```
GPIOs 238-273, spi/spi3.0, mx4_digitals:
 gpio-238 (digital-out-1       ) out lo
 gpio-239 (digital-out-2       ) out lo
 gpio-240 (digital-out-3       ) out lo
 gpio-241 (digital-out-4       ) out lo
 gpio-242 (digital-out-5 / 4-20) out lo
 gpio-243 (digital-out-6       ) out lo
 gpio-250 (digital-in-1 / sc   ) in  hi
 gpio-251 (digital-in-2 / sc   ) in  hi
 gpio-252 (digital-in-3 / sc   ) in  hi
 gpio-253 (digital-in-4 / sc   ) in  hi
 gpio-254 (digital-in-5 / sc   ) in  lo
 gpio-255 (digital-in-6        ) in  lo
```
Then your system is capable of having all digital inputs as wakeup sources.

To enable different wakeup sources and to set edge, the `-p` option is used. The `-p` takes an argument which should be a bitmask of following.

```
#define WAKE_UP_TRIGGER_CAN             (1UL << 0)
#define WAKE_UP_TRIGGER_DIN_1_F         (1UL << 1)
#define WAKE_UP_TRIGGER_DIN_1_R         (1UL << 2)
#define WAKE_UP_TRIGGER_DIN_2_F         (1UL << 3)
#define WAKE_UP_TRIGGER_DIN_2_R         (1UL << 4)
#define WAKE_UP_TRIGGER_DIN_3_F         (1UL << 5)
#define WAKE_UP_TRIGGER_DIN_3_R         (1UL << 6)
#define WAKE_UP_TRIGGER_DIN_4_F         (1UL << 7)
#define WAKE_UP_TRIGGER_DIN_4_R         (1UL << 8)
#define WAKE_UP_TRIGGER_DIN_5_F         (1UL << 9)
#define WAKE_UP_TRIGGER_DIN_5_R         (1UL << 10)
#define WAKE_UP_TRIGGER_DIN_6_F         (1UL << 11)
#define WAKE_UP_TRIGGER_DIN_6_R         (1UL << 12)
#define WAKE_UP_TRIGGER_MODEM_RING      (1UL << 13)
#define WAKE_UP_TRIGGER_START_SWITCH_F  (1UL << 14)
#define WAKE_UP_TRIGGER_START_SWITCH_R  (1UL << 15)
#define WAKE_UP_TRIGGER_MIN_1_F         (1UL << 16)
#define WAKE_UP_TRIGGER_MIN_1_R         (1UL << 17)
#define WAKE_UP_TRIGGER_MIN_2_F         (1UL << 18)
#define WAKE_UP_TRIGGER_MIN_2_R         (1UL << 19)
```

NOTE! If `-d` option is not specified it will always set bit 4 in the wakeup mask, regardless of what you passed.

##### Wake on Analog Inputs

Analog inputs as wakeup sources are not handled by `go_to_sleep.sh`.

All analog inputs have four sysfs files associated with them. If we take input voltage as an example:
```bash
root@mx4-vcc-1000000:/sys/bus/spi/devices/spi3.0# ls input_voltage*
input_voltage_calibration_u      input_voltage_threshold_high
input_voltage                 input_voltage_threshold_low
```

- `input_voltage` is the file where we read the value of input voltage.
- `input_voltage_calibration_u` is used internally by Host Mobility to calibrate the input for component tolerances.
- `input_voltage_threshold_high` is used to enable wake on a high level threshold
- `input_voltage_threshold_low` is used to enable wake on low level threshold.

Some wakeup setup examples:

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
User has to setup analog wakeup sources prior to calling `go_to_sleep.sh`. See [Enter sleep](#enter-sleep)

##### Wake on CAN

Wake on CAN is not supported by all MX-4 platforms. Contact Host Mobility support to see if your platform supports this.

Wake on CAN is enabled by passing `-c` to `go_to_sleep.sh`. See [Enter sleep](#enter-sleep). But prior to doing this one has
to enable which specific CAN buses should be enabled as wakeup source.

By default all CAN buses will trigger a wakeup if there is traffic on them and `-c` is passed to `go_to_sleep.sh`

GPIO's are used to set this up.

```bash
root@mx4-vcc-1000000:~# cat /sys/kernel/debug/gpio | grep -i wakeup
 gpio-58  (P169 - CAN0-WAKEUP  ) out lo
 gpio-59  (P171 - CAN1-WAKEUP  ) out lo
 gpio-60  (P173 - CAN2-WAKEUP  ) out lo
 gpio-61  (P175 - CAN3-WAKEUP  ) out lo
 gpio-62  (P177 - CAN4-WAKEUP  ) out lo
 gpio-63  (P179 - CAN5-WAKEUP  ) out lo
```

To disable wakeup for a specific bus one has to write a 1 to that GPIO's value.

```bash
# Disable wakeup on CAN0
root@mx4-vcc-1000000:~# echo 1 > /sys/class/gpio/gpio58/value

```

### Deep Sleep

Deep sleep mode means that we put the co-cpu in a sleep mode while cutting the power rail to the main CPU. This means that upon wake up we will have a cold reboot instead of a fast resume, this trade off is for lower consumtion during the suspended state.

Wakeup sources available from deep sleep vary on different platforms.

Deep sleep is entered by passing the -D option to `go_to_sleep.sh`. See [Enter sleep](#enter-sleep)

### Shutdown

This mode is not supported by all MX-4 platforms. Contact Host Mobility support to see if your platform supports this.

The MX-4 shutdown/cutoff state is where system is turned off with close to zero power consumption.

```bash
# Cutoff in 60 seconds
root@mx4-vcc-1000000:~# echo 60 > /opt/hm/pic_attributes/ctrl_on_4v
```

The above means that in 60 seconds we will cut the 4 V which the whole system
runs on and the system will only restart if ANALOG-IN-1 is HIGH.

Before these 60 seconds run out the application should have finished and
run the command `poweroff` to shutdown Linux.

```bash
root@mx4-vcc-1000000:~# echo 60 > /opt/hm/pic_attributes/ctrl_on_4v
root@mx4-vcc-1000000:~# poweroff
Sending SIGTERM to remaining processes...
Sending SIGKILL to remaining processes...
Unmounting file systems.
Unmounting /sys/fs/fuse/connections.
All filesystems unmounted.
Deactivating swaps.
All swaps deactivated.
Detaching loop devices.
All loop devices detached.
Detaching DM devices.
All DM devices detached.
[  239.327263] System halted.
```