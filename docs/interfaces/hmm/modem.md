---
title: HMM Modem
tags:
  - Modem
  - HMM
---

## Overview 

The Host Monitor Mini comes with a global LTE modem from Quectel with a GPS receiver (EG21 or EG25).

## Starting/Enabling modem

The modem is turned off by default. To enable it, set the GPIO named:

```bash
	MODEM_ENABLE_ON
	MODEM_RESET
	MODEM_STATUS_ON,
	MODEM_RECOVERY_ENABLE
```

To find out if the modem is on, read the `MODEM_STATUS_ON` GPIO.


```bash
gpioget $(gpiofind MODEM_STATUS_ON)
0 # means it is ON
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
lsusb | grep Quectel
Bus 001 Device 006: ID 2c7c:0125 Quectel Wireless Solutions Co., Ltd. EC25 LTE modem
```

## Production settings (default)
- Sim card detect 
  - AT+QSIMDET=1,0 
    - Need restart to take affect
- GPS (not confirmed if it is persistant)
  - AT+QGPSCFG="autogps",1
  - AT+QGPSCFG="nmeasrc",1


## [Test SIM card](../modem/quectel.md#test-sim-card)

## [GPS](../modem/quectel.md#gps)

## [Use WvDial to get a broadband connection](../modem/quectel.md#use-wvdial-to-get-a-broadband-connection)

## Set modem into recovery mode

Additionally, this platform can put the modem in recovery mode for forcible software updates using the MODEM_RECOVERY_ENABLE pin. This mode can also been enabled by AT commands. Use the QFirehose application compiled for aarch64 to update the modem firmware.

