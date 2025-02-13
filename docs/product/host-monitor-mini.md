---
title: Platform Host Monitor Mini
tags:
    - HMM
---
![](hmm-box.png)
![](hmm_back-box.png)
## Abstract

Host Monitor Mini is an industrial Linux-based edge-computing device in
DIN-rail enclosure.

## Features lists 

### Feature for Hm020

| Feature | Description
| --- | ---
| Housing | galvanized metal, 110(117)x134(153)x32mm (in parenthesis connector front to back din-rail clip)
| Operating Temperature | -5C to +65C 
| Nominal Voltage | 24V
| Operating System | Yocto Scarthgap, Linux kernel 6.6 
| Protection | IP20 
| [Low power mode](../system/power_management.md)  | Suspend to RAM. 

### Feature summary for HM020-010411

This product is shipped with a custom distribution/BSP and an application called Liam.

| Feature | Description
| --- | ---
| CPU | Texas Instruments AM625 Solo 1.4 GHz A53 (64 bit) with Cortex M4F 400Mhz co-processor 
| RAM | 512 MB DDR4
| Internal Storage | 4 GB eMMC
|Interface| Description|
| [Ethernet](../interfaces/ethernet.md) |  1 x 100/1000 Base-T1 
| [GPS](../interfaces/hmm/modem.md) | Included in modem, external antenna
| [LEDs](../interfaces/leds.md) | 4 x red+green (yellow in combination)
| [Modem](../interfaces/modem/modem.md) | Quectel EG21 GL
| [Real Time Clock](../interfaces/rtc.md) | No battery mounted; please use network time
| [RS-232](../interfaces/serial.md) | 1 x RS-232 bus 
| SIM | nanoSIM, hot-swap
| [USB](../interfaces/hmm/usb.md) | USB 2.0 OTG type C
| [WIFI](../interfaces/wifi.md) | 802.11 b/g/n WiFi |

### Feature summary for HM020-003711

| Feature | Description
| --- | ---
| CPU | Texas Instruments AM625 Solo 1.4 GHz A53 (64 bit) with Cortex M4F 400Mhz co-processor 
| RAM | 512 MB DDR4
| Internal Storage | 4 GB eMMC
|Interface| Sumary|
| [CAN](../interfaces/can.md) | 2 x CAN-FD
| [Ethernet](../interfaces/ethernet.md) |  1 x 100/1000 Base-T1
| [GPS](../interfaces/hmm/modem.md) | Included in modem, external antenna connector (SMA)
| [HSM](../interfaces/hsm.md) | Hardware security module
| [LEDs](../interfaces/leds.md) | 4 x red+green (yellow in combination)
| [Modem](../interfaces/modem/modem.md) | Quectel EG25 GL
| [Real Time Clock](../interfaces/rtc.md) | System time keeper and wakeup, power backed up by CR1225 coin cell battery
| [RS-232](../interfaces/serial.md) | 1 x RS-232 bus
| [RS-485](../interfaces/serial.md) | 1 x RS-485 bus
| SIM | nanoSIM, hot-swap
| [USB](../interfaces/hmm/usb.md) | USB 2.0 OTG type C
| [Universal I/O](../interfaces/hmm/digital_io.md) | with individual modes | 
| [WIFI](../interfaces/wifi.md) | 802.11 b/g/n WiFi* | Optional/Bluetooth

### Feature(s) on request 

See [Production Variant Definition](#production-variant-definition) if your variant is already a product available for sale.

| Feature           | Summary                                                   | Mounted/Optional                      |
|-------------------|-----------------------------------------------------------|---------------------------------------|
| CPU               | TI AM625 1.4 GHz A53 (64-bit) with Cortex M4 400MHz co-processor | Solo / Optional dual or quad   |
| RAM               | 512 MB DDR4                                               | - / 1GB or 2GB option                 |
| Internal Storage  | 4 GB eMMC                                                 | - / 4GB to 16GB                       |
| External Storage  | µSD Card                                                  | Optional / -                          |


| Interface                                 | Description                                   | Mounted/Optional                        |
|-------------------------------------------|-----------------------------------------------|-----------------------------------------|
| [Bluetooth](../interfaces/bluetooth.md)   | Bluetooth Low Energy 5.2*                     | Optional / Wi-Fi                       |
| [CAN](../interfaces/can.md)               | 2 x CAN-FD                                     | Optional / -                           |
| [Ethernet](../interfaces/ethernet.md)     | 1 x 100/1000 Base-T1                           | Always / -                             |
| [GPS](../interfaces/hmm/modem.md)         | Included in modem, external antenna           | Always / -                             |
| [HSM](../interfaces/hmm/hsm.md)           | Hardware security module                        | Optional / -                           |
| [LEDs](../interfaces/leds.md)             | 4 x red+green (yellow in combination)           | Always / -                             |
| [Modem](../interfaces/modem/modem.md)     | Quectel EG21 GL                               | Always / Optional EG25 GL              |
| [Real Time Clock](../interfaces/rtc.md)   | System time keeper and wakeup                 | Optional / Optional power-backed by CR1225 coin cell battery |
| [RS-232](../interfaces/serial.md)         | 1 x RS-232 bus                                | Always / -                             |
| [RS-485](../interfaces/serial.md)         | 1 x RS-485 bus                                | Optional / -                           |
| SIM                                       | NanoSIM, hot-swap                             | Always / -                             |
| [USB](../interfaces/hmm/usb.md)           | USB 2.0 OTG Type-C                            | Always / -                             |
| [Universal I/O](../interfaces/hmm/io.md)  | With individual modes                         | Optional / -                           |
| [WIFI](../interfaces/wifi.md)             | 802.11 b/g/n WiFi*                            | Optional / Bluetooth                   |

* *You can only choose either BLE or WiFi as there is only one SMA connector in this design.


## Production variant definition

The product part numbers start with HM020-\*\*\*\*\*-revision, read from right to left. For the first variant number, the processor module is followed by the modem. If no other parameters are stated, the part number will be HM010-00011-revision.

### Processor module

Position in field: xxxxxX

| Processor ID | Module Part Number      | Additional Details                   | 
|--------------|-------------------------|--------------------------------------|
| 0            | No module               |                                      |
| 1            | hMOD0014 (Arena)        | Verdin AM62 Solo 512MB WB (WiFi) IT  |
| 2            | - (Arena)               | Verdin AM62 Dual 1GB WB IT           |
| 2            | - (Arena)               | Verdin AM62 Dual 1GB WB IT           |
| 2            | - (Arena)               | Verdin AM62 Quad 2GB WB IT           |

### Modem type (mounted on PCBA)

Position in field: xxxxXx

| Modem ID | Module Part Number     | Additional Details      |
|----------|------------------------|-------------------------|
| 0        | No module              |                         |
| 1        | -                      | EG21 LTE Cat 1 global   |
| 2        | -                      | EG25 LTE Cat 4 global   |
| n…       |                        |                         |

### CAN-FD, WLAN/BT, UNIV I/O and serial port features

Position in field: xxxXxx

| Variant ID | Feature CAN | Feature RS-485 | Feature UNIV I/O + RS-485 | Feature WLAN/BT | PCBA      
|------------|------------|----------------|---------------------------|----------------|------------|
| 0          | No         | No             | No                        | -              | HMP1031-1  |
| 1          | No         | Yes            | 2 x UNIV I/O + RS-485     | -              | HMP1031-2  |
| 2          | CAN1+2     | No             | No                        | -              | HMP1031-3  |
| 3          | CAN1+2     | Yes            | 2 x UNIV I/O + RS-485     | -              | HMP1031-4  |
| 4          | No         | No             | No                        | WLAN           | HMP1031-11 |
| 5          | No         | Yes            | 2 x UNIV I/O + RS-485     | WLAN           | HMP1031-12 |
| 6          | CAN1+2     | No             | No                        | WLAN           | HMP1031-13 |
| 7          | CAN1+2     | Yes            | 2 x UNIV I/O + RS-485     | WLAN           | HMP1031-14 |
| 8          | No         | No             | No                        | BT             | HMP1031-11 |
| 9          | No         | Yes            | 2 x UNIV I/O + RS-485     | BT             | HMP1031-12 |
| A          | CAN1+2     | No             | No                        | BT             | HMP1031-13 |
| B          | CAN1+2     | Yes            | 2 x UNIV I/O + RS-485     | BT             | HMP1031-14 |


### SIM Card module

Position in field: xxXxxx

| Variant ID | SD-Card Receptacle | Nano-SIM Card | Additional Details                        |
|------------|--------------------|---------------|-------------------------------------------|
| 0          | Not fitted         | Not fitted    | No SIM Card and no mass-storage option    |
| 1          | Not fitted         | Fitted        | With SIM card, no mass-storage option     |
| 2          | Fitted             | Not fitted    | No SIM card, with mass-storage option     |
| 3          | Fitted             | Fitted        | With SIM card and mass-storage option     |


### Custom BSP/OS
Position in field: XXxxxx

This is for customers that want extra installation of software, additional labels or similar within design limitations.

| Customer ID | Customer Tweaks | Description                   
|-------------|-----------------|--------------------------------------------------------------------|
| 0           | Default         | No customization, only delivered with our reference BSP            |
| 1           | <Reserved>      | Reserved for customer using the Liam application and a custom BSP  |                
| n           | <Reserved>      | -                                                                  |

  
### List of known products

| Products   | Product part number | Description                  
|------------|---------------------|---------------------------------------------------|
| Default    | HM020-003711        | Only delivered with our reference BSP             |
| <Reserved> | HM020-010411        | Reserved for customer using the Liam application  |

**Note:** For SETEK employees, update this page after making changes to the internal document 900126-HM Mini Variant definitions and encoding.


## Connectors and buttons

[![Connectors and buttons](tbd.PNG)](../assets/tbd.PDF)

## Technical specification

Please contact [support](../support.md) to receive a detailed technical specification for this hardware.
