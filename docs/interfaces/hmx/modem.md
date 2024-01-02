---
title: HMX Modem
tags:
  - Modem
  - HMX
---

## Overview 

The HMX has a modem from Quectel called EM05 with a GPS receiver.

## Starting/Enabling modem

The modem is turned on by default. To disable it, set the GPIO MODEM_PWR to 0.
To reset it use MODEM_RST and set it to 0, then back to 1 after a second.

```bash
root@10210100023:~# gpioinfo | grep MODEM
        line  10:  "MODEM_PWR"       unused   input  active-high
        line  20:  "MODEM_RST"       unused   input  active-high

gpioset $(gpiofind MODEM_PWR)=0
```
```

* The modem takes about 10 seconds to start and register itself with the kernel. It then takes up to one minute before it is registered in the linux usb list.

* Check USB TTY device to see if it has shown up.


```bash
find /dev -name "ttyUSB*"
```

```bash
/dev/ttyUSB3
/dev/ttyUSB2
/dev/ttyUSB1
/dev/ttyUSB0
```

* The modem also shows up with the `lsusb` command.

```bash
root@10210100023:~# lsusb | grep Quectel
Bus 001 Device 007: ID 2c7c:030a Quectel Wireless Solutions Co., Ltd. Quectel EM05-G
```

## Production settings(default)
- Sim card detect 
  - AT+QSIMDET=1,1 
    - Needs a restart to take effect
  - AT+QSIMSTAT?
    - 0 Off, 1 On first parameter
- GPS (not confirmed)
  - AT+QGPSCFG="autogps",1
  - AT+QGPSCFG="nmeasrc",1

## [Test SIM card](../modem/quectel.md#test-sim-card)

## [GPS](../modem/quectel.md#gps)

## [Use WvDial to get a broadband connection](../modem/quectel.md#use-wvdial-to-get-a-broadband-connection)

## Sleep and wake up

When the modem has a URC to report, a WOWWAN# pin signal will wake up the host.
To be able to power down the modem, set QSCLK to 1
```bash
echo -ne "AT+QSCLK=1\r\n" | microcom -X /dev/ttyUSB2 -t 100

**Note:** Not verified to work, support case issued where this pin never goes from state low to high.





