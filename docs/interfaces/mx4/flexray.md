---
title: Flexray (MX-4)
tags:
  - Flexray
  - T30 FR

---

## Overview

The T30 FR platform supports Flexray RX (receive) only.

### Interface name

Flexray appears as a network interface with the default name `eth2`.

Example output (abridged) from `ifconfig`:

```
eth2 Link encap:Ethernet HWaddr 00:0E:C6:00:1A:63
inet addr:10.42.42.1 Bcast:10.42.42.255 Mask:255.255.255.0
inet6 addr: fe80::20e:c6ff:fe00:1a63/64 Scope:Link
UP BROADCAST RUNNING MULTICAST MTU:1500 Metric:1
RX packets:5 errors:0 dropped:0 overruns:0 frame:0
TX packets:44 errors:0 dropped:0 overruns:0 carrier:0
collisions:0 txqueuelen:1000
RX bytes:330 (330.0 B) TX bytes:5268 (5.1 KiB)

vflexray0 Link encap:UNSPEC HWaddr 00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00
UP RUNNING NOARP MTU:296 Metric:1
RX packets:0 errors:0 dropped:0 overruns:0 frame:0
TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
collisions:0 txqueuelen:0
RX bytes:0 (0.0 B) TX bytes:0 (0.0 B)
```

### Tools

For debug purposes the following tools are available:

- flexrayctl
- flexraydump

They are built from sources in Host Mobility's private [mx-flexray-utils](https://github.com/hostmobility/mx-flexray-utils) repository.

#### flexrayctl usage

The following options are available:

```
# flexrayctl
flexrayctl v0.0.1

Copyright (C) Host Mobility AB 2017

Usage: flexrayctl <-ipvh> [value]
-i --ipaddress. IP adress for FlexRay node. Defaults to 10.42.42.2
-p --port. Destination TCP port on FlexRay node. Defaults to 29050
-c --command. Command to send to the target node.
-l --list. List available commands.
-v --verbose
-h --help
```

A typical example usage would be: `flexrayctl -i 10.42.42.2 -p 29050 -c statistics`.


#### flexraydump usage

```
# flexraydump --help
Usage: flexraydump [] [Options]

flexraydump receives and dumps FLEXRAY messages.

Options:
-v, --verbose be verbose
-h, --help this help
-c, --frame-count N exit after N frames received
-f, --file FILE optional binary dump FILE
--version print version information and exit
Use kill -SIGUSR1 to get statistics.
Hint: -SIGUSR1 is usually -10 if the signal name is not available.
```
