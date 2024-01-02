---
title: MX-V Modem
tags:
  - Modem
  - MX-V
---

## Overview 

The MX-V has a modem from Quectel called EG25 with a GPS receiver.

## Starting/Enabling modem

The modem is turned off by default. To enable it, set the GPIO control line to 1.

```bash
root@mxv-pt:~# gpioinfo modem_control
gpiochip8 - 4 lines:
	line   0: "MODEM_ENABLE_ON" unused input active-high
	line   1: "MODEM_RESET" unused input active-high
	line   2: "MODEM_POWER_ENABLE" unused input active-high
	line   3: "MODEM_STATUS_ON" unused input active-high
```

To find out if the modem is on, read the `MODEM_STATUS_ON` GPIO.


```bash
root@mxv-pt:~# gpioget $(gpiofind MODEM_STATUS_ON)
0
```

Set `MODEM_ENABLE_ON` to 1:
```bash
gpioset $(gpiofind MODEM_ENABLE_ON)=1
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
root@mxv-pt:~# lsusb | grep Quectel
Bus 001 Device 006: ID 2c7c:0125 Quectel Wireless Solutions Co., Ltd. EC25 LTE modem
```

## Production settings(default)
- Sim card detect 
  - AT+QSIMDET=1,1 
    - Need restart to take affect
  - AT+QSIMSTAT?
    - 0 Off, 1 On first parameter
- Audio codec (TLV320AIC3104)
  - AT+QDAI=5,0,0,4,0,1
- GPS (not confirmed)
  - AT+QGPSCFG="autogps",1
  - AT+QGPSCFG="nmeasrc",1
- Activate diversity antenna  
  - AT+QCFG="diversity" 1


## [Test SIM card](../modem/quectel.md#test-sim-card)

## [GPS](../modem/quectel.md#gps)

## [Use WvDial to get a broadband connection](../modem/quectel.md#use-wvdial-to-get-a-broadband-connection)

## [Audio](../modem/quectel.md#audio)

