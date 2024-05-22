---
title: Ethernet (HMX)
tags:
  - Ethernet
  - HMX
---

## Overview

This product has four Ethernet ports:

* eth0 : MX34 connector that supports 10BASE-T and 100BASE-TX
* eth1 : 8P8C (RJ45) connector that supports 10BASE-T and 100BASE-TX
* eth2 : Rosenberger connector that supports 100 and 1000BASE-T1
* eth3 : Rosenberger connector that supports 100 and 1000BASE-T1

## Default IP addresses and interface names

The `eth0`, `eth1`, `eth2` and `eth3` Ethernet interfaces are configured to request their IP addresses using DHCP with a fallback to static addresses 192.168.1.200 for eth0, 192.168.2.200 for eth1, 192.168.3.200 for eth2, and 192.168.4.200 for eth3.

## Sleep and wake up

Not supported by the current hardware revision. T1 Ethernet (`eth2` and `eth3`) wake from suspend/sleep is planned for a later revision.





