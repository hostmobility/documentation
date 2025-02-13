---
title: Ethernet
tags:
  - Ethernet
  - HMM
  - HMX
  - C61
  - MX-4
  - T30
  - T30 FR
  - MX-V
---
## Overview
Our products come with one or two RJ45 (Ethernet) ports.


## Platform specific
- [HMX](hmx/ethernet.md)
- [C61](c61/ethernet.md)
- [MX-V](mxv/ethernet.md)
- [MX-4](mx4/ethernet.md)

## Configuration though Systemd-Networkd

**Note:** Not for BSP release 1.6/1.5 and older

Most of our products come with a [systemd-networkd](https://wiki.archlinux.org/title/systemd-networkd) configuration file, one for each Ethernet port. The following is just an example of how to set up a custom network.

Example:

Edit or create `/lib/systemd/network/80-eth0.network`
```
[Match]
Name=eth0
Type=ether
KernelCommandLine=!nfsroot


[Network]
DHCP=yes

[Address]
Label=eth0:0
Address=192.168.1.200/24

[DHCP]
UseMTU=yes
RouteMetric=10
ClientIdentifier=mac
```

