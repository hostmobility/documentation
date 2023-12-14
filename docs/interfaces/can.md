---
title: CAN
tags:
  - CAN
  - HMX
  - C61
  - MX-4
  - MX-V
---

## Overview

[CAN(controller area network)](https://en.wikipedia.org/wiki/CAN_bus) is a bus type network where all nodes on a single bus communicates directly to each other. 

Host Mobility Hardware all have a number of CAN channels.

In Linux, CAN channels are implemented as network interfaces. They can utilize the Linux network stack and present a programming model similar to TCP/IP. Applications use the [SocketCAN](https://www.kernel.org/doc/html/v4.19/networking/can.html) API, either directly or tthough a higher level library.

## Configuration though Systemd-Networkd

**Note:** Not for BSP release 1.6/1.5 and older

Bus parameters can be set in systemd-networkd configuration files. 

Example:

Edit or create `/lib/systemd/network/80-can.network`
```
[Match]
Name=can*

[CAN]
BitRate=500K
RestartSec=2000ms
DataBitRate=4000000
FDMode=True
```


## Manual configuration

Use `ip link` to configure the bus parameters manually. This is a standard utility([iproute2](https://wiki.linuxfoundation.org/networking/iproute2))

Supported options are shown by the `ip` `help` subcommand

```bash
    $ ip link set can0 type can help  
    Usage: ip link set DEVICE type can
            [ bitrate BITRATE [ sample-point SAMPLE-POINT] ] |
            [ tq TQ prop-seg PROP_SEG phase-seg1 PHASE-SEG1
              phase-seg2 PHASE-SEG2 [ sjw SJW ] ]

              dphase-seg2 PHASE-SEG2 [ dsjw SJW ] ]

            [ loopback { on | off } ]
            [ listen-only { on | off } ]
            [ triple-sampling { on | off } ]
            [ one-shot { on | off } ]
            [ berr-reporting { on | off } ]
            [ fd { on | off } ]
            [ fd-non-iso { on | off } ]
            [ presume-ack { on | off } ]

            [ restart-ms TIME-MS ]
            [ restart ]

            Where: BITRATE  := { 1..1000000 }
                      SAMPLE-POINT  := { 0.000..0.999 }
                      TQ            := { NUMBER }
                      PROP-SEG      := { 1..8 }
                      PHASE-SEG1    := { 1..8 }
                      PHASE-SEG2    := { 1..8 }
                      SJW           := { 1..4 }
                      RESTART-MS    := { 0 | NUMBER }
```


*Example : Set Standard(2.0) CAN with a bitrate of 500 kbit/s and listen only mode.*
```
ip link set can0 down
ip link set can0 up type can bitrate 500000 listen-only on
```

*Example : Setup CAN-FD with a bitrate of 500/4000 kbit/s in normal mode.*
```bash
ip link set can0 down
ip link set can0 up type can bitrate 500000 dbitrate 4000000 fd on
```

### Query a device for its current configuration

```bash
ip -d link show can0
```

```bash
8: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 72 qdisc pfifo_fast state UP mode DEFAULT group default qlen 10
    link/can  promiscuity 0 minmtu 0 maxmtu 0 
    can <FD> state ERROR-PASSIVE (berr-counter tx 0 rx 127) restart-ms 0 
	  bitrate 500000 sample-point 0.875
	  tq 25 prop-seg 34 phase-seg1 35 phase-seg2 10 sjw 1 brp 1
	  m_can: tseg1 2..256 tseg2 2..128 sjw 1..128 brp 1..512 brp_inc 1
	  dbitrate 4000000 dsample-point 0.700
	  dtq 25 dprop-seg 3 dphase-seg1 3 dphase-seg2 3 dsjw 1 dbrp 1
	  m_can: dtseg1 1..32 dtseg2 1..16 dsjw 1..16 dbrp 1..32 dbrp_inc 1
	  clock 40000000 numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_segs 65535 parentbus spi parentdev spi3.0 
```

### Query a device for statistics

```bash
ip -s link show can0
```

```bash
8: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 72 qdisc pfifo_fast state UP mode DEFAULT group default qlen 10
    link/can 
    RX:  bytes packets errors dropped  missed   mcast           
             0       0      0       0       0       0 
    TX:  bytes packets errors dropped carrier collsns           
             0       0      0       0       0       0 
```

## CAN-utils 

[can-utils]( https://github.com/linux-can/can-utils) is a collection of CAN-tools that
can be used to debug CAN networks and applications. They can be very useful as a source of
inspiration if you are to write your own application that interacts with a CAN
network.

### Dump all incoming data

```bash
$ candump -c -l any,0:0,#FFFFFFFF    (log error frames and also all data frames)
```

### Send a single CAN frame

```bash
$ cansend can0 123#DEADBEEF
```


## Platform specific

[HMX](hmx/can.md)


