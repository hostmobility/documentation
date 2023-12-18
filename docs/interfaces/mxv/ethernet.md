---
title: Ethernet (MX-V)
tags:
  - Ethernet
  - MX-V
---
## Overview

This product has two RJ45 Ethernet ports: `eth0` with support for 100BASE-TX and 1000BASE-T. and
`eth1` with support for 10BASE-T and 100BASE-TX.

## Default IP addresses and interface names

Ethernet interfaces are configured to request their IP addresses using DHCP
with a fallback to static addresses (192.168.1.200 for eth0 and 192.168.2.200
for eth1). 

## Controlling network with if-up

**Note:** For BSP release 1.6/1.5 and older but will work for MX-V

See scripts in `/etc/network/if-up.d` for details.



