---
title: Gemalto PLS8 Modem
---

## Production settings

    - **In some cases the modem AT command channel is not set up. To do this manually send the commands below:**
        - echo "at^ssrvset=actsrvset"                    > /dev/ttyACM1
        - echo "^SSRVSET: 10"                            > /dev/ttyACM1
        - echo "at^scfg=MEShutdown/OnIgnition,on"        > /dev/ttyACM1
        - echo "AT^SSRVSET=usbcomp,10,0061"              > /dev/ttyACM1
        - echo "AT^SSRVSET=srvmap,10,RSA,USB0,MUX0"      > /dev/ttyACM1
        - echo "AT^SSRVSET=srvmap,10,NMEA,USB1,MUX1"     > /dev/ttyACM1
        - echo "AT^SSRVSET=srvmap,10,APP,USB2,MUX2"      > /dev/ttyACM1
        - echo "AT^SSRVSET=srvmap,10,MDM,USB3,MUX3"      > /dev/ttyACM1
        - echo "AT^SSRVSET=actSrvSet, 10"                > /dev/ttyACM1
        - **Check the result.**
            - echo "AT^SSRVSET?"                             > /dev/ttyACM1
        - **Reset the modem to activate the new settings.**
            - echo "AT+CFUN=1,1?"                            > /dev/ttyACM1
    - The result ACM map is:
        - Radio /dev/ttyACM0
        - GPS   /dev/ttyACM1
        - AT commands  /dev/ttyACM2
        - Modem /dev/ttyACM3



## Use WvDial to get a broadband connection

    - Optional *ln -s /dev/ttyACM2 /dev/modem*
    - Run wvdialconf
    - vi /etc/wvdial.conf
        - Init1 = ATZ
        - Init2 = AT+CFUN=1
        - Init3 = ATQ0 V1 E1 S0=0 &C1 &D2 +FCLASS=0
        - Init4 = AT+CGDCONT=1,"IP","internet.telenor.se"
        - Modem Type = USB Modem
        - ISDN = 0
        - Phone = *99#
        - Modem = /dev/ttyACM3
        - Username=;
        - Password=;
        - Baud = 460800
        - Stupid Mode = yes
        - Auto Reconnect = on
        - New PPPD = yes
        - Auto DNS = 1
    - Run *wvdial &*
    - Test *ping 8.8.8.8*
    - Output could look like this:
        +-----------------------------------------------------------+
        |root@mx4-v61:~# wvdial &                                   |
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
        |OK                                                         |
        +-----------------------------------------------------------+
        |--> Sending: ATQ0 V1 E1 S0=0 &C1 &D2 +FCLASS=0             |
        +-----------------------------------------------------------+
        |ATQ0 V1 E1 S0=0 &C1 &D2 +FCLASS=0                          |
        +-----------------------------------------------------------+
        |OK                                                         |
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
        |--> Starting pppd at Tue Feb  5 10:46:34 2019              |
        +-----------------------------------------------------------+
        |--> Pid of pppd: 600                                       |
        +-----------------------------------------------------------+
        |--> Using interface ppp0                                   |
        +-----------------------------------------------------------+
        |root@mx4-v61:~# --> local  IP address 46.194.12.163        |
        +-----------------------------------------------------------+
        |--> remote IP address 10.64.64.64                          |
        +-----------------------------------------------------------+
        |--> primary   DNS address 195.54.122.211                   |
        +-----------------------------------------------------------+
        |--> secondary DNS address 195.54.122.221                   |
        +-----------------------------------------------------------+

## GPS 

**Note:** simple commands

    - This is just one way of many to set up and get GPS position data..
        - echo "AT^SGPSC=?"                      > /dev/ttyACM2
        - echo "AT^SGPSC="Engine",0"             > /dev/ttyACM2
        - echo "AT^SBNW=agps,-1"                 > /dev/ttyACM2
        - echo "AT^SGPSC="Nmea/Freq",1"          > /dev/ttyACM2
        - echo "AT^SGPSC="Nmea/Glonasst",on"     > /dev/ttyACM2
        - echo "AT^SGPSC="Nmea/Output",on"       > /dev/ttyACM2
        - echo "AT^SGPSC="Nmea/Urc",off"         > /dev/ttyACM2
        - echo "AT^SGPSC="Power/Antenna",auto"   > /dev/ttyACM2
        - echo "AT^SGPSC="Engine",1"             > /dev/ttyACM2
        - echo "AT^SGPSC?"                       > /dev/ttyACM2
        - cat /dev/ttyACM1 & **or**gps-parser /dev/ttyACM1
        - Output example (gps-parser)
        +-------------------------------------------------------------------------------+
        |+GPRMC: Fix Time: 19222 12:37:9 Lat: 57.40.431402, Long: 12.0.831634 Speed: 0  |
        +-------------------------------------------------------------------------------+
        |+GPRMC: Fix Time: 19222 12:37:10 Lat: 57.40.431402, Long: 12.0.831650 Speed: 0 |
        +-------------------------------------------------------------------------------+
        |+GPRMC: Fix Time: 19222 12:37:11 Lat: 57.40.431401, Long: 12.0.831660 Speed: 0 |
        +-------------------------------------------------------------------------------+

