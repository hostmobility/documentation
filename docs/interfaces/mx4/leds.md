---
title: LEDs (MX-4)
tags:
  - LED
  - C61
  - MX-4
  - T30
  - T30 FR
  - CT
  - CT GL
---

## Overview

On the MX-4 platform the LEDs are configured under `/opt/hm/pic_attributes/LED`. See [pic_attributes](pic_attributes.md) for a complete list of attributes.

All LEDs except power can be controlled from within Linux (see [Pre configured LED behavior](#Pre configured LED behavior)).

## WiFi LEDs

The green WiFi LED (mx4-wifi) is set up to be lit on netdev. You can overwrite this by setting it to none or another trigger. Some platforms do not have the mx4-wifi-red and this led is free to be used as you like.
```
echo none > /sys/class/leds/mx4-wifi/trigger
# On
echo 1 >  /sys/class/leds/mx4-wifi/brightness
echo 1 >  /sys/class/leds/mx4-wifi-red/brightness
# Off
echo 0 >  /sys/class/leds/mx4-wifi/brightness
echo 0 >  /sys/class/leds/mx4-wifi-red/brightness
```

## Script to set LEDs
You can use the script `/opt/hm/set_led_flash.sh`.
```
root@mx4-t30-29009999:~# /opt/hm/set_led_flash.sh
Usage: /opt/hm/set_led_flash.sh <index> <color> <freq>

index = 2 - GSM LED
index = 3 - GPS LED
index = 4 - FUNC LED
index = 5 - BUZZER

color = 0 - led off
color = 1 - blink off/green
color = 2 - blink off/orange
color = 3 - blink green/orange

freq = 0 - no blink
freq = 1-255 - Flashing with frequency; freq * 100 milliseconds
```
### Pre configured LED behavior

#### PWR

The power LED is is green or flashing green yellow/orange if charging an internal battery. Depending on the level of charge it will change speed between the flashing green ↔ yellow until it is lit green. If the unit does not have a battery it will continue to flash green ↔ yellow.

- Solid green when running on supply voltage and battery charge state is above 60 %.
- Flashing green/yellow 1 Hz: Battery charge status is 41-60 % and charging.
- Flashing green/yellow 2 Hz: Battery charge status is 21-40 % and charging.
- Flashing green/yellow 4 Hz: Battery charge status is 0-20 % and charging.
- Solid yellow when running on battery and the battery is above 60 %
- Flashing yellow/off 1 Hz: Battery charge status is 41-60 %.
- Flashing yellow/off 2 Hz: Battery charge status is 21-40 %.
- Flashing yellow/off 4 Hz: Battery charge status is 0-20 %.
- Flashing green/off 1 Hz: The unit is in boot process

#### STANDBY STATE
- One-shot PWR LED green/off (on 30 ms) approximately every 20 seconds.

#### ERROR STATE
- All LEDs (except WiFi) flashing green/off 5 Hz: The unit is in an error state. Failing to boot operating system. This is the default state when the unit is powered on.

#### FIRMWARE UPGRADE
A firmware upgrade can be followed by monitoring the LED behavior.

1. All LEDs (except WiFi) flashing green/off 1 Hz: The unit is loading/running an image ("hmupdate.img") from USB driver or /boot. DO NOT REMOVE POWER!
1. When hmupdate.img is finished the system will start up. This will be indicated by PWR LED Flashing green/off in 1 Hz.
1. First boot after hmupdate.img is run we also update the coprocessor firmware. This is indicated by the following sequence:
- FUNC LED Solid green and other LEDs off. Entered coprocessor bootloader and will load an application to update coprocessor bootloader.
- FUNC LED solid green, GPS solid green and other LEDs off. Bootloader application is loaded and will update coprocessor bootloader.
- FUNC LED Solid green and other LEDs off. Entered coprocessor bootloader and will load the final application.
- LED behavior returns to normal operation.

During the above steps the GSM LED will flash when we are sending data to the coprocessor for upgrade.

1. Done!

## Set LEDs (the hard way)

LED flashing is configured by writing 4 bytes to the corresponding led_-file in Linux.

**The configuration of the 4 bytes:**

| MSB         | Second MSB  | Second LSB  | LSB          |
|-------------|-------------|-------------|--------------|
| Frequency   | Spare       | Flash config| Current LED  |


### Frequency

Frequency is configured according to:

- 0 - Flashing off
- 1-255 - Flashing with frequency; _value * 100 milliseconds_

If only no alternative frequency is configured the time for each state will be the same. If different times are wanted also use alternative frequency.

### Alternative frequency

- 0 - No alternative frequency.
- 1-255 - Flashing with frequency; _value * 100 milliseconds_

### Flash config

A bitmask configures which states that shall be included in the flashing sequence.

- Bit 0 - LED is off.
- Bit 1 - LED first state.
- Bit 2 - LED second state.

### Current LED

Sets which LED shall be lit upon reception of the configuration value. If only this value is set the LED will not change state until a new configuration is received, or the MX-4 is restarted.
This value can also be used to configure [oneshot](#oneshot) flashing.

### Oneshot

Oneshot flashing is configured by only configuring the wanted finishing state in the [flash config](#flash-config).
In [current LED](#current-led) the wanted starting state is configured.
In [frequency](#frequency) the wanted time for the oneshot is configured.

### Example of configuration

#### Flashing pattern calculation

- **Frequency Calculation:**
  - Byte 3, frequency byte: 1 second / 100 milliseconds = 10.

- **Unused Byte:**
  - Byte 2: Not used, set to 0.

- **Bits in Byte 1:**
  - Bit 0 and bit 1 used: \( (1 << 1) | (1 << 0) = 3 \).

### Resultant values

| Byte 3 | Byte 2 | Byte 1 | Byte 0 |
|--------|--------|--------|--------|
| 10     | 0      | 3      | 0      |

### Concatenating bytes

- Full Value Calculation:
    -  10 << (8 * 3) | ((1 << 1) | (1 << 0)) | (8 * 1) = 167772171

- Adjustment for Initial State:
    - To start the flashing at state 0: \( 167772171 \)
    - To start the flashing at state 1: Add 1 to the value in Byte 0.

#### Flashing between State 1 and State 2

State 1 lit for 2 seconds and state 2 lit for 500 milliseconds.

- Frequency calculations:
    - Byte 3, frequency byte for State 1: \( 500ms/ 100ms = 5 \)
    - Byte 2, frequency byte for State 2: \( 2 seconds /100ms = 20 \)
    - Byte 1, bits 1 and 2 used: \( (1 << 2) | (1 << 1) = 6 \)
    - Byte 0, initial state configured as State 2: Set to 2 in this case.

### Resultant configuration

| Byte 3 | Byte 2 | Byte 1 | Byte 0 |
|--------|--------|--------|--------|
| 5      | 20     | 6      | 2      |

### Calculation

5 << (8 * 3) | 20 << (8 * 2) | 6 << 8 | 2 = 85198338

#### One-shot flash configuration

To configure a one-shot flash, an initial state and a finishing state are set with the time for the initial state configured in **Byte** 3.

The initial state is specified in **Byte** 0, and the finishing state is specified in **Byte** 1.

This means that in **Byte** 1, only one state needs to be defined, and that state will persist until a new value is sent to the LED.
