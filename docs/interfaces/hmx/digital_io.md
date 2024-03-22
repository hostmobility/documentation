---
title:  Digital I/O (HMX)
tags:
  - Digital I/O
  - HMX
---
## Overview
The HMX-specific Digital I/Os are listed below. Check the technical file for more information about the different thresholds and whether it's possible to change state (digital out).

## List of supported outputs

There are four different types of digital outputs.

- outputs with ability to sink a signal to ground
- outputs with the ability to source VCC power (they have different maximum current), either controlled by software or always on.
- output with both an internal buzzer and the ability to connect an external buzzer.


| Hardware Name         | Software Name | Software group | Connected to          | Source Type                          |
|-----------------------|---------------|----------------|-----------------------|--------------------------------------|
| SINK_OUT_1            | OUT_SINK1     | gpiod          |                       | Sink                                 |
| SINK_OUT_2            | OUT_SINK2     | gpiod          |                       | Sink                                 |
| Digital_output_ETH2_ACT| ETH2_ACT     | gpiod          |                       | Source (Special)                     |
| SOURCE_Digital_OUT_1  | OUT_SOURCE1   | gpiod          |                       | Source (VCC power)                   |
| SOURCE_Digital_OUT_2  | OUT_SOURCE2   | gpiod          |                       | Source (VCC power)                   |
| SOURCE_OUT_3          |               |                | SOURCE_OUT_7          | Source (Always powered)              |
| SOURCE_OUT_4          | pwr_out_active| gpio-leds      | SOURCE_OUT_5, SOURCE_OUT_6 | Source (VCC power)             |
| SOURCE_OUT_5          | pwr_out_active| gpio-leds      | SOURCE_OUT_4, SOURCE_OUT_6 | Source (VCC power)             |
| SOURCE_OUT_6          | pwr_out_active| gpio-leds      | SOURCE_OUT_4, SOURCE_OUT_5 | Source (VCC power)             |
| SOURCE_OUT_7          |               |                | SOURCE_OUT_3          | Source (Always powered)              |
| SOURCE_OUT_8          | pwr_out_equipment| gpio-leds   |                       | Source (VCC power)                   |
| SOURCE_PWR_OUT_LED_1  | pwr_out_led_1 | gpio-leds      |                       | Source (VCC power)                   |
| SOURCE_PWR_OUT_LED_2  | pwr_out_led_2 | gpio-leds      |                       | Source (VCC power)                   |
| SOURCE_PWR_OUT_BUZZER | pwr_out_buzzer| gpio-leds      |                       | Source (VCC power, Buzzer)           |


Example usage:
```bash
#gpio-leds
echo 1 > /sys/class/leds/:pwr_out_led_1/brightness
#gpiod
gpioset $(gpiofind OUT_SINK1)=1
```

## List of supported inputs

There are two types of digital inputs with pull up or pull down resistor.

| Hardware Name           | Software Name | Software group | Input Type          |
|-------------------------|---------------|----------------|---------------------|
| Digital_input_pulldown_1| IN_PULLDOWN1  | gpiod          | Pull-down (33k to GND)|
| Digital_input_pulldown_2| IN_PULLDOWN2  | gpiod          | Pull-down (33k to GND)|
| Digital_input_pullup_1  | IN_PULLUP1    | gpiod          | Pull-up (33k to VCC)  |
| Digital_input_pullup_2  | IN_PULLUP2    | gpiod          | Pull-up (33k to VCC)  |
| Digital_input_HMI_1     | IN_HMI1       | gpiod          | Pull-up (33k to VCC)  |
| Digital_input_HMI_2     | IN_HMI2       | gpiod          | Pull-up (33k to VCC)  |


## Fault detection

The unit has fault detection that goes high if a fault is detected(gpiod).

| Fault Name (software name)       | Connected to                   |
|------------------|--------------------------------|
| SINK_FAULT       | SINK_OUT_1, SINK_OUT_2         |
| SOURCE_1_FAULT   | SOURCE_Digital_OUT_1           |
| SOURCE_2_FAULT   | SOURCE_Digital_OUT_2           |
| SOURCE_4_FAULT   | SOURCE_OUT_4, SOURCE_OUT_5, SOURCE_OUT_6 |
| SOURCE_5_FAULT   | SOURCE_PWR_OUT_BUZZER          |
| SOURCE_6_FAULT   | SOURCE_OUT_8                   |


## Sleep and wake up

For Digital in, wake-up is default on. If you want to disable the inputs one way is to change the device tree when building the image, the other is to unbind the gpio-keys.
```
echo gpio-keys > /sys/bus/platform/drivers/gpio-keys/unbind
```
After waking up, you can bind it again if you want to use the gpio-keys.