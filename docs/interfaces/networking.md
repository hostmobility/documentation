---
title: Networking
tags:
  - Networking
  - CAN
  - Ethernet
  - USB
  - WIFI
---

## Overview

* By default, networking is configured by the [systemd](https://systemd.io) service `systemd-networkd`. 
* The parameters are set in the configuration files in `/lib/systemd/network/`.
* Older MX-4 systems are configured by the scripts in `/etc/network/ip-up.d*

Configuration can also be done manually with the [iproute2](https://wiki.linuxfoundation.org/networking/iproute2) utilities, e.g. the `ip` command.


## Network types

For type-specific configuration of networking, refer to the links below.

*  [CAN](can.md)

* [Ethernet](ethernet.md)

* [USB](usb.md#ethernet-over-usb)

* [WiFi](wifi.md)



