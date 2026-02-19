---
title: HMX Automotive Ethernet
tags:
  - HMX
  - Automotive Ethernet
  - Ethernet
---
## Overview
This document explains how to configure the automotive ethernet ports on the HMX. The
Automotive Ethernet (T1) in:

-   100BASE-T1 (100 Mbit) or 1000BASE-T1 (1 Gbit) speed selection
-   Master (CMD) / Slave (RSP) configurations
-   Throughput testing using iperf3

Both systems must use compatible T1 PHYs.

------------------------------------------------------------------------

# 1. Physical Topology

    HMX (eth2/eth3)  <---- T1 cable ---->  SYSTEM

Requirements:

-   Both systems support 100baseT1 and 1000baseT1
-   Cable properly connected
-   One side must be Master (CMD), the other Slave (RSP)

------------------------------------------------------------------------

# 2. Verify Link Capability

Run on both systems:

``` bash
ethtool eth2
```

You should see:

-   Supported link modes: 100baseT1/Full and 1000baseT1/Full
-   Link detected: yes (when connected)

------------------------------------------------------------------------

# 3. Configure Master / Slave Roles

## Set HMX as Master

``` bash
ethtool -s eth2 master-slave forced-master
```

## Set HMX as Slave

``` bash
ethtool -s eth2 master-slave forced-slave
```

Retrain link:

``` bash
ip link set eth2 down
sleep 1
ip link set eth2 up
```

Verify:

``` bash
ethtool eth2
```

You should see:

-   master-slave status: master (on A)
-   master-slave status: slave (on B)
-   Link detected: yes

------------------------------------------------------------------------

# 4. Set Link Speed

## For 1000BASE-T1

On both systems:

``` bash
ethtool -s eth2 speed 1000 duplex full
```

## For 100BASE-T1

On both systems:

``` bash
ethtool -s eth2 speed 100 duplex full
```

Retrain link after changing speed.

Verify:

``` bash
ethtool eth2
```

Expected:

    Speed: 1000Mb/s

or

    Speed: 100Mb/s

------------------------------------------------------------------------

# 5. Configure IP Addresses

Choose a subnet (example 192.168.10.0/24)

## HMX

``` bash
ip addr flush dev eth2
ip addr add 192.168.10.1/24 dev eth2
ip link set eth2 up
```

------------------------------------------------------------------------

# 6. Test Connectivity

From **HMX** to SERVER:

``` bash
ping -I eth2 [SYSTEMS IP]
```

From SERVER to **HMX**:

``` bash
ping -I eth2 192.168.10.1
```

------------------------------------------------------------------------

# 7. Throughput Testing (iperf3)

Install iperf3 if needed:

``` bash
sudo apt install iperf3
```

## On Server

``` bash
iperf3 -s
```

## On HMX

``` bash
iperf3 -c 192.168.10.2              NOTE!! EXAMPLE IP use ur own IP
```

Expected throughput:

-   \~900--940 Mbit/s at 1000BASE-T1
-   \~90--95 Mbit/s at 100BASE-T1

------------------------------------------------------------------------

# 8. Quick Troubleshooting

If link is down:

-   Ensure speeds match on both sides
-   Ensure one side is master and the other slave
-   Retrain link
-   Reconnect cable
-   Verify with: ethtool eth2

If ping fails:

-   Verify IP addresses are in same subnet
-   Check firewall rules
-   Verify route with: ip route

------------------------------------------------------------------------

# 9. Validated Configurations

Configuration A: - HMX = Master - System = Slave

Configuration B: - HMX = Slave - System = Master

Both configurations should support full throughput.

------------------------------------------------------------------------
