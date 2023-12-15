---
title: MX4 Modem
tags:
    - CT
    - T30
    - T30 FR
---

## Overview 
The Mx4 has a modem from Gemalto pls8-e Europe or pls8-us USA.

**Note:** CT GL has Quectel called EG25-G with a GPS receiver so see C61 for more information.

## Starting/Enabling

**Note:**  The modem is turned off by default.
```
echo 1 > /opt/hm/pic_attributes/ctrl_modem_on
```
* The modem takes about 10 seconds to start and register itself with the kernel. And thakes up to one minutes before it is registered in the linux usb list.

* Check USB TTY device to see if it has shown up.


```bash
find /dev -name "ttyACM*"
```

```bash
/dev/ttyACM4
/dev/ttyACM3
/dev/ttyACM2
/dev/ttyACM1
/dev/ttyACM0
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
To disable it, set ctrl_modem_on to 0

To reset it use ctrl_modem_emg (reset signal) and set it to 0 then back to 1 after a second.

```bash
echo 0 > /opt/hm/pic_attributes/ctrl_modem_on
# or (not to be used regulary because it could effect the memory)
echo 0 > /opt/hm/pic_attributes/ctrl_modem_emg
```

## [Production settings](../modem/gemalto.md#production-settings)


## [GPS](../modem/gemalto.md#gps)

## [Use WvDial to get a broadband connection](../modem/gemalto.md#use-wvdial-to-get-a-broadband-connection)

## Linux 3.1
**Note:** for bsp release 1.6(1.5) and older

## Modem

The MX-4 board is equipped with a 3G modem. It is not started by default when the unit is powered one but has to be explicitly turned on with the following command:

     root@mx4-gtt:~# echo 1 > /opt/hm/pic_attributes/ctrl_modem_on

if PH8 is powered on, following ports will be created
* /dev/ttyUSB0 --> Reserved port (not usable)
* /dev/ttyUSB1 --> NMEA port
* /dev/ttyUSB2 --> Application port
* /dev/ttyUSB3 --> Modem port
* /dev/ttyUSB4 --> WWAN port (not usable, Windows only)

You should get an output similar to the following:

```bash
 root@mx4-gtt:~# dmesg | tail
 [ 5034.642693] option 3-1:1.0: GSM modem (1-port) converter detected
 [ 5034.644177] usb 3-1: GSM modem (1-port) converter now attached to ttyUSB0
 [ 5034.646047] option 3-1:1.1: GSM modem (1-port) converter detected
 [ 5034.647351] usb 3-1: GSM modem (1-port) converter now attached to ttyUSB1
 [ 5034.649150] option 3-1:1.2: GSM modem (1-port) converter detected
 [ 5034.650337] usb 3-1: GSM modem (1-port) converter now attached to ttyUSB2
 [ 5034.652141] option 3-1:1.3: GSM modem (1-port) converter detected
 [ 5034.653759] usb 3-1: GSM modem (1-port) converter now attached to ttyUSB3
 [ 5034.655688] option 3-1:1.4: GSM modem (1-port) converter detected
 [ 5034.657306] usb 3-1: GSM modem (1-port) converter now attached to ttyUSB4
```

The modem can also be turned off with this command.

```bash
root@mx4-gtt:~# echo 0 > /opt/hm/pic_attributes/ctrl_modem_on
```

### Creating a PPP connection
First off we need to install `pppd` if it does not exist on target.

```bash
opkg update
opkg install ppp
```

File structure needed for ppp to work:
```
/etc/ppp
├── chap-secrets
├── ip-down.d
│   └── # Custom down script
├── ip-up.d
│   ├── # Custom up script
├── operators
│   └── apn
├── pap-secrets
├── peers
│   └── provider
├── pppd_connect-chat
└── pppd_disconnect-chat
```

Contest of above files:
/etc/ppp/operators/apn
```
AT+CGDCONT=1,"IP","openroamer.com","",0,0
```
Replace "openroamer.com" with your operator APN

/etc/ppp/peers/provider
```
# File: /etc/ppp/options
# We set defualt remote ip adress.
#:192.168.255.1
#Some GPRS phones don't reply to LCP echo's
lcp-echo-failure 0
lcp-echo-interval 0
# Keep pppd attached to the terminal:
# Comment this to get daemon mode pppd
#nodetach
# Debug info from pppd:
# Comment this off, if you don't need more info
debug
persist
holdoff 5
maxfail 0
# Show password in debug messages
show-password
# Connect script:
# scripts to initialize the GPRS modem and start the connection,
#connect /etc/pppd_connect-chat
connect '/usr/sbin/chat -v -f /etc/ppp/pppd_connect-chat'
# Disconnect script:
# AT commands used to 'hangup' the GPRS connection.
#disconnect /etc/pppd_disconnect-chat
disconnect '/usr/sbin/chat -v -f /etc/ppp/pppd_disconnect-chat'
# Serial device to which the GPRS phone is connected:
/dev/ttyUSB3
# Serial port line speed
115200 # fast enough
# Hardware flow control:
# Use hardware flow control with cable, Bluetooth and USB but not with IrDA.
crtscts # serial cable, Bluetooth and USB, on some occations with IrDA too
# Ignore carrier detect signal from the modem:
local
# IP addresses:
# - accept peers idea of our local address and set address peer as 10.0.0.1
# (any address would do, since IPCP gives 0.0.0.0 to it)
# - if you use the 10. network at home or something and pppd rejects it,
# change the address to something else
#0.0.0.0:0.0.0.0
# pppd must not propose any IP address to the peer!
noipdefault
# Accept peers idea of our local address
ipcp-accept-local
ipcp-accept-remote
# Add the ppp interface as default route to the IP routing table
defaultroute
# DNS servers from the phone:
# some phones support this, some don't.
usepeerdns
# ppp compression:
# ppp compression may be used between the phone and the pppd, but the
# serial connection is usually not the bottleneck in GPRS, so the
# compression is useless (and with some phones need to disabled before
# the LCP negotiations succeed).
novj
nobsdcomp
novjccomp
nopcomp
noaccomp

# The phone is not required to authenticate:
noauth

# Username and password:
# If username and password are required by the APN, put here the username
# and put the username-password combination to the secrets file:
# /etc/ppp/pap-secrets for PAP and /etc/ppp/chap-secrets for CHAP
# authentication. See pppd man pages for details.
#user mirza
#password 123456

mru 1500
mtu 1400
```
/etc/ppp/pppd_connect-chat
```
#!/bin/sh
#
# File: /etc/ppp/pppd_connect-chat
 TIMEOUT 5
 ECHO ON
 ABORT '\nBUSY\r'
 ABORT '\nERROR\r'
 ABORT '\nNO ANSWER\r'
 ABORT '\nNO CARRIER\r'
 ABORT '\nNO DIALTONE\r'
 ABORT '\nRINGING\r\n\r\nRINGING\r'
 '' \rATZ
 TIMEOUT 12
 SAY "Press CTRL-C to close the connection at any stage!"
 SAY "\ndefining PDP context...\n"
 OK ATH
 OK ATE1
 OK-AT-OK @/etc/ppp/operators/apn
 OK ATD*99#
 TIMEOUT 22
 SAY "\nwaiting for connect...\n"
 CONNECT ""
 SAY "\nConnected."
 SAY "\nIf the following ppp negotiations fail,\n"
 SAY "try restarting the phone.\n"
```

/etc/ppp/pppd_disconnect-chat
```bash
at
ABORT "BUSY"
ABORT "ERROR"
ABORT "NO DIALTONE"
SAY "n\Sending break to the modem\n"
"" "\K"
"" "\K"
"" "\K"
"" "+++ATH"
"" "+++ATH"
"" "+++ATH"
SAY "\nModem context detached\n"
```

`/etc/ppp/pap-secrets` and `/etc/ppp/chap-secrets` are empty and do not really need to exist unless you need to use one of these methods to auth with network provider.

When you have the above structure correctly setup you can then start and stop pppd connections with `pon` and `poff` commands.

One tip is to start up syslogd and run `tail -f /var/log/messages &`, this way you will get some output during the connection process and makes it easier to debug in case of connection errors.

Here is an example.

```bash
root@mx4-gtt:~# syslogd
root@mx4-gtt:~# tail -f /var/log/messages &
root@mx4-gtt:/etc/ppp/operators# pon
root@mx4-gtt:/etc/ppp/operators# Dec 20 10:35:27 mx4-gtt daemon.notice pppd[564]: pppd
2.4.5 started by root, uid 0
Dec 20 10:35:27 mx4-gtt local2.info chat[565]: timeout set to 5 seconds
Dec 20 10:35:27 mx4-gtt local2.info chat[565]: abort on (\nBUSY\r)
Dec 20 10:35:27 mx4-gtt local2.info chat[565]: abort on (\nERROR\r)
Dec 20 10:35:27 mx4-gtt local2.info chat[565]: abort on (\nNO ANSWER\r)
Dec 20 10:35:27 mx4-gtt local2.info chat[565]: abort on (\nNO CARRIER\r)
Dec 20 10:35:27 mx4-gtt local2.info chat[565]: abort on (\nNO DIALTONE\r)
Dec 20 10:35:27 mx4-gtt local2.info chat[565]: abort on (\nRINGING\r\n\r\nRINGING\r)
Dec 20 10:35:27 mx4-gtt local2.info chat[565]: send (^MATZ^M)
Dec 20 10:35:28 mx4-gtt local2.info chat[565]: timeout set to 12 seconds
Dec 20 10:35:28 mx4-gtt local2.info chat[565]: expect (OK)
Dec 20 10:35:28 mx4-gtt local2.info chat[565]: ATZ^M^M
Dec 20 10:35:28 mx4-gtt local2.info chat[565]: OK
Dec 20 10:35:28 mx4-gtt local2.info chat[565]:  -- got it
Dec 20 10:35:28 mx4-gtt local2.info chat[565]: send (ATH^M)
Dec 20 10:35:28 mx4-gtt local2.info chat[565]: expect (OK)
Dec 20 10:35:28 mx4-gtt local2.info chat[565]: ^M
Dec 20 10:35:28 mx4-gtt local2.info chat[565]: ATH^M^M
Dec 20 10:35:28 mx4-gtt local2.info chat[565]: OK
Dec 20 10:35:28 mx4-gtt local2.info chat[565]:  -- got it
Dec 20 10:35:28 mx4-gtt local2.info chat[565]: send (ATE1^M)
Dec 20 10:35:28 mx4-gtt local2.info chat[565]: expect (OK)
Dec 20 10:35:28 mx4-gtt local2.info chat[565]: ^M
Dec 20 10:35:28 mx4-gtt local2.info chat[565]: ATE1^M^M
Dec 20 10:35:28 mx4-gtt local2.info chat[565]: OK
Dec 20 10:35:28 mx4-gtt local2.info chat[565]:  -- got it
Dec 20 10:35:28 mx4-gtt local2.info chat[565]: send (AT+CGDCONT=1,"IP","internet.tele2.
se","",0,0^M)
Dec 20 10:35:28 mx4-gtt local2.info chat[565]: expect (OK)
Dec 20 10:35:28 mx4-gtt local2.info chat[565]: ^M
Dec 20 10:35:28 mx4-gtt local2.info chat[565]: AT+CGDCONT=1,"IP","internet.tele2.se",""
,0,0^M^M
Dec 20 10:35:28 mx4-gtt local2.info chat[565]: OK
Dec 20 10:35:28 mx4-gtt local2.info chat[565]:  -- got it
Dec 20 10:35:28 mx4-gtt local2.info chat[565]: send (ATD*99#^M)
Dec 20 10:35:28 mx4-gtt local2.info chat[565]: timeout set to 22 seconds
Dec 20 10:35:28 mx4-gtt local2.info chat[565]: expect (CONNECT)
Dec 20 10:35:28 mx4-gtt local2.info chat[565]: ^M
Dec 20 10:35:28 mx4-gtt local2.info chat[565]: ATD*99#^M^M
Dec 20 10:35:28 mx4-gtt local2.info chat[565]: CONNECT
Dec 20 10:35:28 mx4-gtt local2.info chat[565]:  -- got it
Dec 20 10:35:28 mx4-gtt local2.info chat[565]: send (^M)
Dec 20 10:35:28 mx4-gtt daemon.debug pppd[564]: Script /usr/sbin/chat -v -f /etc/ppp/pp
pd_connect-chat finished (pid 565), status = 0x0
Dec 20 10:35:28 mx4-gtt daemon.info pppd[564]: Serial connection established.
Dec 20 10:35:28 mx4-gtt daemon.debug pppd[564]: using channel 2
Dec 20 10:35:28 mx4-gtt daemon.info pppd[564]: Using interface ppp0
Dec 20 10:35:28 mx4-gtt daemon.notice pppd[564]: Connect: ppp0 <--> /dev/ttyUSB3
Dec 20 10:35:29 mx4-gtt daemon.debug pppd[564]: sent [LCP ConfReq id=0x1 <asyncmap 0x0>
 <magic 0x6d4845a0>]
Dec 20 10:35:29 mx4-gtt daemon.debug pppd[564]: rcvd [LCP ConfReq id=0x0 <asyncmap 0x0>
 <auth chap MD5> <magic 0xc558301e> <pcomp> <accomp>]
Dec 20 10:35:29 mx4-gtt daemon.debug pppd[564]: No auth is possible
Dec 20 10:35:29 mx4-gtt daemon.debug pppd[564]: sent [LCP ConfRej id=0x0 <auth chap MD5
> <pcomp> <accomp>]
Dec 20 10:35:29 mx4-gtt daemon.debug pppd[564]: rcvd [LCP ConfAck id=0x1 <asyncmap 0x0>
 <magic 0x6d4845a0>]
Dec 20 10:35:29 mx4-gtt daemon.debug pppd[564]: rcvd [LCP ConfReq id=0x1 <asyncmap 0x0>
 <magic 0xc558301e>]
Dec 20 10:35:29 mx4-gtt daemon.debug pppd[564]: sent [LCP ConfAck id=0x1 <asyncmap 0x0>
 <magic 0xc558301e>]
Dec 20 10:35:29 mx4-gtt daemon.warn pppd[564]: kernel does not support PPP filtering
Dec 20 10:35:29 mx4-gtt daemon.debug pppd[564]: sent [CCP ConfReq id=0x1 <deflate 15> <deflate(old#) 15>]
Dec 20 10:35:29 mx4-gtt daemon.debug pppd[564]: sent [IPCP ConfReq id=0x1 <addr 0.0.0.0
> <ms-dns1 0.0.0.0> <ms-dns2 0.0.0.0>]
Dec 20 10:35:29 mx4-gtt daemon.debug pppd[564]: rcvd [LCP DiscReq id=0x2 magic=0xc558301e]
Dec 20 10:35:29 mx4-gtt daemon.debug pppd[564]: rcvd [LCP ProtRej id=0x3 80 fd 01 01 00
 0c 1a 04 78 00 18 04 78 00]
Dec 20 10:35:29 mx4-gtt daemon.debug pppd[564]: Protocol-Reject for 'Compression Contro
l Protocol' (0x80fd) received
Dec 20 10:35:30 mx4-gtt daemon.debug pppd[564]: rcvd [IPCP ConfNak id=0x1]
Dec 20 10:35:30 mx4-gtt daemon.debug pppd[564]: sent [IPCP ConfReq id=0x2 <addr 0.0.0.0> <ms-dns1 0.0.0.0> <ms-dns2 0.0.0.0>]
Dec 20 10:35:31 mx4-gtt daemon.debug pppd[564]: rcvd [IPCP ConfNak id=0x2]
Dec 20 10:35:31 mx4-gtt daemon.debug pppd[564]: sent [IPCP ConfReq id=0x3 <addr 0.0.0.0> <ms-dns1 0.0.0.0> <ms-dns2 0.0.0.0>]
Dec 20 10:35:32 mx4-gtt daemon.debug pppd[564]: rcvd [IPCP ConfNak id=0x3]
Dec 20 10:35:32 mx4-gtt daemon.debug pppd[564]: sent [IPCP ConfReq id=0x4 <addr 0.0.0.0> <ms-dns1 0.0.0.0> <ms-dns2 0.0.0.0>]
Dec 20 10:35:33 mx4-gtt daemon.debug pppd[564]: rcvd [IPCP ConfNak id=0x4]
Dec 20 10:35:33 mx4-gtt daemon.debug pppd[564]: sent [IPCP ConfReq id=0x5 <addr 0.0.0.0> <ms-dns1 0.0.0.0> <ms-dns2 0.0.0.0>]
Dec 20 10:35:34 mx4-gtt daemon.debug pppd[564]: rcvd [IPCP ConfReq id=0x0]
Dec 20 10:35:34 mx4-gtt daemon.debug pppd[564]: sent [IPCP ConfNak id=0x0 <addr 0.0.0.0>]
Dec 20 10:35:34 mx4-gtt daemon.debug pppd[564]: rcvd [IPCP ConfNak id=0x5 <addr 10.49.1
19.16> <ms-dns1 130.244.127.161> <ms-dns2 130.244.127.169>]
Dec 20 10:35:34 mx4-gtt daemon.debug pppd[564]: sent [IPCP ConfReq id=0x6 <addr 10.49.1
19.16> <ms-dns1 130.244.127.161> <ms-dns2 130.244.127.169>]
Dec 20 10:35:34 mx4-gtt daemon.debug pppd[564]: rcvd [IPCP ConfReq id=0x1]
Dec 20 10:35:34 mx4-gtt daemon.debug pppd[564]: sent [IPCP ConfAck id=0x1]
Dec 20 10:35:34 mx4-gtt daemon.debug pppd[564]: rcvd [IPCP ConfAck id=0x6 <addr 10.49.1
19.16> <ms-dns1 130.244.127.161> <ms-dns2 130.244.127.169>]
Dec 20 10:35:34 mx4-gtt daemon.warn pppd[564]: Could not determine remote IP address: d
efaulting to 10.64.64.64
Dec 20 10:35:34 mx4-gtt daemon.notice pppd[564]: local  IP address 10.49.119.16
Dec 20 10:35:34 mx4-gtt daemon.notice pppd[564]: remote IP address 10.64.64.64
Dec 20 10:35:34 mx4-gtt daemon.notice pppd[564]: primary   DNS address 130.244.127.161
Dec 20 10:35:34 mx4-gtt daemon.notice pppd[564]: secondary DNS address 130.244.127.169
Dec 20 10:35:34 mx4-gtt daemon.debug pppd[564]: Script /etc/ppp/ip-up started (pid 569)

root@mx4-gtt:/etc/ppp/operators# Dec 20 10:35:43 mx4-gtt daemon.err ntpdate[576]: no se
rver suitable for synchronization found
Dec 20 10:35:43 mx4-gtt daemon.debug pppd[564]: Script /etc/ppp/ip-up finished (pid 569
), status = 0x1
```

You can now also see with `ifconfig` that you got a ppp connection

```bash
root@mx4-gtt:~# ifconfig ppp0
ppp0      Link encap:Point-to-Point Protocol
          inet addr:10.49.119.16  P-t-P:10.64.64.64  Mask:255.255.255.255
          UP POINTOPOINT RUNNING NOARP MULTICAST  MTU:1400  Metric:1
          RX packets:10 errors:0 dropped:0 overruns:0 frame:0
          TX packets:27 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:3
          RX bytes:662 (662.0 B)  TX bytes:1490 (1.4 KiB)
```

### GPS
The GPS chip is integrated in the modem module. Default it is turned off. To turn on the GPS chip send following AT command to the application port. This is not a persistent setting so one has to enable GPS each time modem restarts if GPS data is desired.

```bash
root@mx4-gtt:~# printf 'at^sgpsc="Engine","1"\r' > /dev/ttyUSB2
```

The NMEA output can be read out of /dev/ttyUSB1

```bash
root@mx4-gtt:~# cat /dev/ttyUSB1
$GPGSV,4,1,16,24,,,,05,,,,18,,,,22,,,*71
$GPGSV,4,2,16,04,,,,11,,,,17,,,,03,,,*79
$GPGSV,4,3,16,12,,,,30,,,,01,,,,23,,,*79
$GPGSV,4,4,16,15,,,,27,,,,07,,,,31,,,*7A
$GPGGA,,,,,,0,,,,,,,,*66
$GPVTG,,T,,M,,N,,K,N*2C
$GPRMC,,V,,,,,,,,,,N*53
$GPGSA,A,1,,,,,,,,,,,,,,,*1E
```

#### GPS for some other versions
On some units the /dev/ttyACM2 and /dev/ttyACM1 is used instead.

First activate the modem(if it is not already activated)
<pre>echo 1 > /opt/hm/pic_attributes/ctrl_modem_on</pre>

Wait a few seconds for the modem to turn on. You should see /dev/ttyACM2 and /dev/ttyACM1 if you do 
<pre>ls /dev</pre>

Connect to ACM2 using microcom(or other serial port program) so you can send commands
<pre>microcom /dev/ttyACM2</pre>

in microcom for ttyACM2 run these 2 commands to enable the Engine and enable GPS data output
<pre>at^sgpsc="Engine","1"
at^sgpsc="Nmea/Output","on"</pre>

in microcom for ttyACM1 all GPS data output should now be displayed:
<pre>microcom /dev/ttyACM1</pre>

### Watchdog

The co-processor acts as a watchdog of the modem. It monitors the power indicator signal by default. If it should detect that the modem is for some reason turned off even though it should be on it will attempt to restart it at first via a soft reset signal and after a few attempts it will do a hard-reset of modem.

To enable monitoring of SLED signal which is an output from modem which reports current status one has to enable this signal. This signal should always toggle on/off, depending on state it toggles in different frequency. Should the co-cpu detect that it stops toggling which is an ERROR state it will attempt to soft restart modem first and if that fails a hard-reset.

To start monitoring of SLED signal input following command to modem. This is not a persistent setting so one has to do this each time modem starts up.
```bash
root@mx4-gtt:~# printf "AT^SLED=2\r" > /dev/ttyUSB3
```