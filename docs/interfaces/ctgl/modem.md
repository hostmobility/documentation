---
title: CT GL Modem
tags:
  - Modem
  - CT GL
---

## Overview 

The C61 has a modem from Quectel called EG25-G with a GPS receiver.

## Starting/Enabling

**Note:**  The modem is turned off by default.
```
echo 1 > /opt/hm/pic_attributes/ctrl_modem_on
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

# Status ON

Example showing a modem start and running.

```bash
/opt/hm/modem_status.sh
******* MODEM STATUS DUMP *******

ctrl_modem_status: 1342177491

Modem state     ON
Ctrl state:     ON

SLED:           0
SLED Mon:       ON

Modem EMG/reset:        0

Current state:  on
Prev state:     turn_on_timeout

Prev RC:        unexpected_shutdown

Start cnt:      0
Reset cnt:      0

EMG used:       NO
```

## Shutdown/Reset 
To disable the modem, set ctrl_modem_on to 0

To reset it use ctrl_modem_emg (emergency restart signal) and set it to 0, then back to 1 after a second.

```bash
echo 0 > /opt/hm/pic_attributes/ctrl_modem_on
# or (not to be used regulary because it could effect the memory)
echo 0 > /opt/hm/pic_attributes/ctrl_modem_emg
```
## Production settings (default)
- Detect SIM card
  - AT+QSIMDET=0,0
    - Needs a restart to take affect
  - AT+QSIMSTAT?
    - 0 Off, 1 On first parameter
- GPS (not confirmed)
  - AT+QGPSCFG="autogps",1
  - AT+QGPSCFG="nmeasrc",1

## [Test SIM card](../modem/quectel.md#test-sim-card)

## [GPS](../modem/quectel.md#gps)

## [Use WvDial to get a broadband connection](../modem/quectel.md#use-wvdial-to-get-a-broadband-connection)

## [Audio](../modem/quectel.md#audio)
