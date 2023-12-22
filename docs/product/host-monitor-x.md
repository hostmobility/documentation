---
title: Hardware Platform Host Monitor X
tags:
    - HMX
---
## Abstract

Host Monitor X is the next generation telematics computer for modern automotive development.

## Feature summary 

| Feature | Summary 
| --- | --- 
| CPU | NXP i.MX 8M Plus (64 bit) with Cortex M7 co-processor
| [Accelerometer](../interfaces/accelerometer.md) | 3-axis
| Bluetooth | Optional
| Buzzer | Internal and power for external
| [CAN](../interfaces/can.md) | 6x CAN-FD
| Ethernet |  2x 100/1000 Base-T1 (Rosenberger), 2x 100-BaseTx (RJ45 and MX34)
| External Logging | µSD Card
| GPS | Included in modem, external antenna
| Housing | Aluminium/plastic
| Start Signals | External input, 2.5-36V (5 inputs)
| Internal Storage | 64 GB eMMC
| [LEDs](../interfaces/leds.md) | 5 red+green (yellow in combination), 1 RGB  
| [Modem](../interfaces/modem.md) | 5G or 4G, M2 connector
| Nominal Voltage | 12-24V
| Operating Temperature | -40C to +65C
| Operating System | Yocto Kirkstone, Linux kernel 6.1
| Power Consumption @12V | < 1 mA in "Off", 25 mA  in "Suspend to RAM"
| Protection | IP30
| RAM | 4 GB DDR4
| [Real Time Clock](../interfaces/) | Yes, backed up by CR2032 coin cell battery
| SIM | nanoSIM
| Low power mode | Suspend to RAM. Wakes on CAN, digital inputs, accelerometer, RTC, and start signals
| Size without connectors | 164x164x30mm
| UPS | 3 seconds supercap power
| USB | USB 3.0 OTG type C, USB 2.0 host type A
