---
title: Ethernet (MX-4)
tags:
  - Ethernet
  - MX-4
---
## Overview

The products MX-4 T30, T20, T30 FR, CT, and CT GL have two RJ45 Ethernet ports with support for 10BASE-T and 100BASE-TX.

## Default IP addresses and interface names

The `eth0` and `eth1` Ethernet interfaces are configured to request their IP addresses using DHCP with a fallback to static addresses 192.168.1.200 for eth0 and 192.168.2.200 for eth1.

## Controlling network with if-up

**Note:** For BSP release 1.6/1.5 mainly but would still work on some BSP 2.x machines.

See scripts in `/etc/network/if-up.d` for details.



