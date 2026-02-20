---
title: HMX Automotive Ethernet
tags:
  - HMX
  - Automotive Ethernet
  - Ethernet
---
## HMX Automotive Ethernet Setup Guide
This document explains how to configure and use the automotive ethernet ports (eth2 / eth3) between two HMX units.

In practice, you should be able to replicate the steps that suit your desired setup by adjusting or removing HMX Unit B as needed to match your configuration. Keep in mind that the speed and master/slave role may vary, so you must manually configure both units correctly in order to establish a connection.

This guide covers:

-   100BASE-T1 (100 Mbit) and 1000BASE-T1 (1 Gbit) speed selection
-   Master (CMD) / Slave (RSP) configurations
-   IP configuration
-   Throughput testing using iperf3

Both systems must use compatible T1 PHYs.

------------------------------------------------------------------------

# 1. Physical Topology

    HMX A (eth2/eth3) <---- T1 cable ---->  HMX B (eth2/eth3)

Requirements:

-   Both systems support 100baseT1 and 1000baseT1
-   Cable properly connected
-   One side must be Master (CMD), the other Slave (RSP)

------------------------------------------------------------------------

# 2. Verify Link Capability

Either port eth2/eth3 is fine to use but for this guide eth2 will be used.


Run on both systems:

``` bash
ethtool eth2
```

You should see:

-   Supported link modes: 100baseT1/Full and 1000baseT1/Full
-   Link detected: yes (when connected)

------------------------------------------------------------------------

# 3. Configure Master / Slave Roles

## Configuration 1

HMX A = Master

HMX B = Slave

### On HMX A

``` bash
ethtool -s eth2 master-slave forced-master
```

### On HMX B

``` bash
ethtool -s eth2 master-slave forced-slave
```

Verify:

``` bash
ethtool eth2
```

Expected:

-   master-slave status: master (on HMX A)
-   master-slave status: slave (on HMX B)
-   Link detected: yes
------------------------------------------------------------------------

## Configuration 2

HMX A = Slave

HMX B = Master

### On HMX A

``` bash
ethtool -s eth2 master-slave forced-slave
```

### On HMX B

``` bash
ethtool -s eth2 master-slave forced-master
```

Verify:

``` bash
ethtool eth2
```

Expected:

-   master-slave status: slave (on HMX A)
-   master-slave status: master (on HMX B)
-   Link detected: yes

------------------------------------------------------------------------
# 4. Set Link Speed

## For 1000BASE-T1 (1 Gbit) speed

On both systems:

``` bash
ethtool -s eth2 speed 1000 duplex full
```

## For 100BASE-T1 (100 Mbit) speed

On both systems:

``` bash
ethtool -s eth2 speed 100 duplex full
```

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

## On HMX A

``` bash
ip addr flush dev eth2
ip addr add 192.168.10.1/24 dev eth2
ip link set eth2 up
```

## On HMX B

``` bash
ip addr flush dev eth2
ip addr add 192.168.10.2/24 dev eth2
ip link set eth2 up
```

Verify:

``` bash
ip route
```

You should see:

    192.168.10.0/24 dev eth2 scope link
------------------------------------------------------------------------

# 6. Test Connectivity

From **HMX** **A**:

``` bash
ping -I eth2 192.168.10.2
```

From **HMX** **B** :

``` bash
ping -I eth2 192.168.10.1
```

------------------------------------------------------------------------

# 7. Throughput Testing (iperf3)

## On HMX B (Server)

``` bash
iperf3 -s
```

## On HMX A (Client)

``` bash
iperf3 -c 192.168.10.2              
```

Expected throughput:

-   \~900--940 Mbit/s at 1000BASE-T1
-   \~90--95 Mbit/s at 100BASE-T1

------------------------------------------------------------------------

# 8. Quick Troubleshooting

If link is down:

-   Ensure speeds match on both sides
-   Ensure one side is master and the other slave
-   Reconnect cable
-   Verify with: ethtool eth2

If ping fails:

-   Verify IP addresses are in same subnet
-   Check firewall rules
-   Verify route with: ip route

If HMX fails to switch Speed or Slave/Master roles:

- Bring down the interface and bring it back up

``` bash
ip link set eth2 down
sleep 1
ip link set eth2 up
```

------------------------------------------------------------------------

# 9. Validated Configurations

Configuration A: - HMX A = Master - HMX B = Slave

Configuration B: - HMX A = Slave - HMX B = Master

Both configurations should support full throughput.

------------------------------------------------------------------------
