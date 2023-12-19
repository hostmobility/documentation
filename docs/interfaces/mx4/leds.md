---
title: LEDs (MX-4)
tags:
  - LED
  - C61
  - MX-4
  - T30
  - T30 FR
  - CT
---

## Overview

On the MX-4 platform the LEDs are configured under `/opt/hm/pic_attributes/LED` for complete list of [pic_attributes](pic_attributes.md)

All leds except the power led can be controlled from linux see [Pre configured LED behavior](#Pre configured LED behavior).

## WiFi LEDs

The green wifi LED (mx4-wifi) is setup to be lit on netdev. you can overwrite this by set it to none or another trigger. Some platform does not have the mx4-wifi-red and this led is free to be used.
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
you can use a script under /opt/hm called set_led_flash.sh
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

The power led is is green or flashing green yellow/orange if charging an internal battery. Depending on the level of charge it will change speed between the flashing green<-->yellow, until it is lit green. If the unit does not have a battery it will continue flash green<-->yellow.

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
- All LEDS(not wifi) Flashing green/off 5 Hz: The unit is in an error state. Failing to boot operating system. This is the default state when the unit is powered on.

#### FIRMWARE UPGRADE
A firmware upgrade can be followed by monitoring the LED behavior.

1. All LEDS(not wifi) Flashing green/off 1 Hz: The unit is loading/running an image ("hmupdate.img") from USB driver or /boot. DO NOT REMOVE POWER!
1. When hmupdate.img is finished the system will start up. This will be indicated by PWR LED Flashing green/off 1 Hz.
1. First boot after hmupdate.img is run we also update co-processor firmware. This is indicated by following sequence:
- FUNC LED Solid green and other LED's off. Entered co-processor bootloader and will load an application to update co processor bootloader.
- FUNC LED solid green, GPS solid green and other LED's off. Bootloader application is loaded and will update co-processor bootloader.
- FUNC LED Solid green and other LED's off. Entered co-processor bootloader and will load the final application.
- LED behavior returns to normal operation.

During the above steps GSM LED will flash when we are sending data to the co-processor for upgrade.

1. Done!

## Set LEDs (the hard way)

LED flashing is configured by sending 4 bytes on corresponding led_-file in Linux.

**The configuration of the 4 bytes:**
<table>
    <tr>
        <td>MSB</td>
        <td>Second MSB</td>
        <td>Second LSB</td>
        <td>LSB</td>
    </tr>
    <tr>
       <td>Frequency</td>
       <td>Spare</td>
       <td>Flash config</td>
       <td>Current LED</td>
   <tr>
</table>

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

Sets which LED that shall be lit upon reception of the configuration value. If only this value is set the LED will not change state until a new configuration is received, or the MX-4 is restarted.
This value can also be used to configure [oneshot](#oneshot) flashing.

### Oneshot

Oneshot flashing is configured by only configuring the wanted finishing state in the [flash config](#flash-config).
In [current LED](#current-led) the wanted starting state is configured.
In [frequency](#frequency) the wanted time for the oneshot is configured.

### Example of configuration

#### Flashing between state 1 and off, 1 second intervall.

Byte 3, frequency byte: 1s / 100ms = 10.
Byte 2, not used: 0.
Byte 1, bit 0 and bit 1 used: (1 << 1) | (1 << 0) = 3.
<table>
    <tr>
        <td>Byte 3</td>
        <td>Byte 2</td>
        <td>Byte 1</td>
        <td>Byte 0</td>
    </tr>
    <tr>
       <td>10</td>
       <td>0</td>
       <td>3</td>
       <td>0</td>
   <tr>
</table>
Puting it together:
10 << (8 * 3) | ((1 << 1) | (1 << 0)) | (8 * 1) = 167772171
In this case the flashing will start at state 0, if we want it to start at state 1 we have to set this in byte 0.
In byte 0 numerical representations of the stat is used so just add 1 to previous value.
#### Flashing between state 1 and 2, state 1 lit for 2 seconds and state 2 lit for 500 milliseconds.
Byte 3, frequency byte: 500ms / 100ms = 5.
Byte 2, frequency byte: 2s / 100ms = 20.
Byte 1, bit 1 and bit 2 used: (1 << 2) | (1 << 1) = 6.
Byte 0, initial state. State configured as initial state will get the time configured in byte 3. So set to 2 in this case.
<table>
    <tr>
        <td>Byte 3</td>
        <td>Byte 2</td>
        <td>Byte 1</td>
        <td>Byte 0</td>
    </tr>
    <tr>
       <td>5</td>
       <td>20</td>
       <td>6</td>
       <td>2</td>
   <tr>
</table>
5 << (8 * 3) | 20 << (8 * 2) | 6 << 8 | 2 = 85198338 
#### One-shot flash
To configure one-shot flash an initial state and a finishing state is configured with the time for the initial state configured in byte 3.
Initial state is configured in byte 0 and finishing state is configured in byte 1. This means that in byte 1 we can just put one state and that state will be kept until a new value is sent to the led.