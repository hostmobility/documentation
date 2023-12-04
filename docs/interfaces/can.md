---
title: CAN (Controller Area Network)
tags:
  - CAN
---

The [CAN](https://en.wikipedia.org/wiki/CAN_bus) interfaces on the Host
Mobility Hardware accessed with the
[SocketCAN](https://www.kernel.org/doc/html/v4.19/networking/can.html) API.
This means that a CAN interface is implemented as a type of network interface.
They can utilize the Linux network stack and present a programming model
similar to TCP/IP.


## Configuration

A CAN device is typically configured with the
[iproute2](https://wiki.linuxfoundation.org/networking/iproute2) utilities.

### List of supported switches

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

### Configure bit rate of one specific CAN controller

```bash
    $ ifconfig can0 down
    $ ip link set can0 type can bitrate 250000
    $ ifconfig can0 up
```

### Query a device for its current configuration

    $ ip -d link show can0

### Query a device for statistics

    $ ip -s link show can0

## CAN-utils 

[can-utils]( https://github.com/linux-can/can-utils) is a collection of CAN-tools that
can be used to debug CAN networks and applications. They can be very useful as a source of
inspiration if you are to write your own application that interacts with a CAN
network.

### Dump all incoming data

```bash
$ candump -l any,0:0,#FFFFFFFF    (log error frames and also all data frames)
```

### Send a single CAN frame

```bash
$ cansend can0 123#DEADBEEF
```
