---
title: Quectel EG25/EM05
tags:
    - MX-V
---

## Test SIM card

### Check if SIM is detected

type
```bash
AT+QSIMSTAT?
```

expected reply

```bash
+QSIMSTAT: 0,1
```
or
```bash
+QSIMSTAT: 0,1
```

**0,1 or 1,1 means that SIM is detected**

## GPS

### Enable

Connect to the modem with
```bash
microcom /dev/ttyUSB2
```

Enable GPS with the AT commands
```
AT+QGPSCFG="autogps",1
AT+QGPS=1
```

### Reading values

* Wait until the GPS receiver has found enough satellites to get a fix.
* Get the GPS position with `AT+QGPSLOC?`
* If the GPS receiver has no fix, the Not fixed now error is shown.

```
AT+QGPSLOC?
+CME ERROR: Not fixed now
```

* GPS data can be continuously streamed from `/dev/ttyUSB1`
```bash
microcom /dev/ttyUSB1
```


## Use WvDial to get a broadband connection

    - Optional *ln -s /dev/ttyACM2 /dev/modem*
    - Run wvdialconf
    - vi /etc/wvdial.conf
        - Init1 = ATZ
        - Init2 = AT+CFUN=1
        - Init3 = AT+CGDCONT=1,"IP","internet.telenor.se"
        - Modem Type = USB Modem
        - ISDN = 0
        - Phone = *99#
        - Modem = /dev/ttyUSB2
        - Username=;
        - Password=;
        - Baud = 9600
        - Stupid Mode = yes
        - Auto Reconnect = on
        - New PPPD = yes
        - Auto DNS = 1
    - Run *wvdial &*
    - Test *ping 8.8.8.8*
    - Output could look like this:
        +-----------------------------------------------------------+
        |root@mx4:~# wvdial &                                   |
        +-----------------------------------------------------------+
        |[1] 599                                                    |
        +-----------------------------------------------------------+
        |root@mx4-v61:~# --> WvDial: Internet dialer version 1.61   |
        +-----------------------------------------------------------+
        |--> Initializing modem.                                    |
        +-----------------------------------------------------------+
        |--> Sending: ATZ                                           |
        +-----------------------------------------------------------+
        |ATZ                                                        |
        +-----------------------------------------------------------+
        |OK                                                         |
        +-----------------------------------------------------------+
        |--> Sending: AT+CFUN=1                                     |
        +-----------------------------------------------------------+
        |AT+CFUN=1                                                  |
        +-----------------------------------------------------------+
        |OK                                                   |
        +-----------------------------------------------------------+
        |--> Sending: AT+CGDCONT=1,"IP","internet.telenor.se"       |
        +-----------------------------------------------------------+
        |AT+CGDCONT=1,"IP","internet.telenor.se"                    |
        +-----------------------------------------------------------+
        |OK                                                         |
        +-----------------------------------------------------------+
        |--> Modem initialized.                                     |
        +-----------------------------------------------------------+
        |--> Sending: ATDT*99#                                      |
        +-----------------------------------------------------------+
        |--> Waiting for carrier.                                   |
        +-----------------------------------------------------------+
        |ATDT*99#                                                   |
        +-----------------------------------------------------------+
        |CONNECT 100000000                                          |
        +-----------------------------------------------------------+
        |--> Carrier detected.  Starting PPP immediately.           |
        +-----------------------------------------------------------+
        |--> Starting pppd at Mon Dec 16 12:43:43 2019              |
        +-----------------------------------------------------------+
        |--> Pid of pppd: 1317                                      |
        +-----------------------------------------------------------+
        |--> Using interface ppp0                                   |
        +-----------------------------------------------------------+
        |--> local  IP address 46.194.155.114                       |
        +-----------------------------------------------------------+
        |--> remote IP address 10.64.64.64                          |
        +-----------------------------------------------------------+
        |--> primary   DNS address 195.54.122.211                   |
        +-----------------------------------------------------------+
        |--> secondary DNS address 195.54.122.221                   |
        +-----------------------------------------------------------+
   - ping 8.8.8.8
      - 64 bytes from 8.8.8.8: seq=0 ttl=55 time=55.250 ms
 
 Or using pppd
  - see https://github.com/hostmobility/mx4-wiki#modem
      
### GPS
-------------------------
    - This is just one way of many to set up and get GPS position data..
        - AT+QGPS=1 (Turn on  GNSSengine)
	- AT+QGPSCFG="autogps",1
        - AT+QGPSEND (Turn off GNSSengine)
        - Output example gps-parser /dev/ttyUSB1 or AT+QGPSLOC? (AT+QGPSLOC=latitude)
        +-------------------------------------------------------------------------------+
        |+GPRMC: Fix Time: 19222 12:37:9 Lat: 57.40.431402, Long: 12.0.831634 Speed: 0  |
        +-------------------------------------------------------------------------------+
        |+GPRMC: Fix Time: 19222 12:37:10 Lat: 57.40.431402, Long: 12.0.831650 Speed: 0 |
        +-------------------------------------------------------------------------------+
        |+GPRMC: Fix Time: 19222 12:37:11 Lat: 57.40.431401, Long: 12.0.831660 Speed: 0 |
        +-------------------------------------------------------------------------------+

## Audio
###  Loopback Audio Test

- AT+QSIDET=10000
- AT+QAUDLOOP=1
- AT+CLVL? 
  - Loudspeaker Volume LevelSelection
  - AT+CLVL=4 Recommended
- Factory default AT+QDAI=5,0,0,4,0,1
- factory default AT+QMIC=20577,14567

### Answer call
- ATV1
- ATA

