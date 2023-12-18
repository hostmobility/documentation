---
title: WiFi
tags:
  - WiFi
  - MX-V
  - T30
  - T30 FR
---
## Overview

This page briefly explains how to scan for and connect to WiFi networks using wpa_supplicant.
For more information, see the [Arch Linux Wiki](https://wiki.archlinux.org/title/Network_configuration/Wireless).

## Platform specific
- [MX-V](mxv/wifi.md)
- [T30](mx4/wifi.md)
- [T30 FR](mx4/wifi.md)

## Examples
### Scan for WiFi networks
```
iw dev $WIFI_INTERFACE scan ap-force
```

### Connect to a wifi network
```
wpa_passphrase ${WIFI_SSID} ${WIFI_PASSWORD}
wpa_supplicant -B -imlan0 -c /etc/wpa_supplicant.conf -Dnl80211,wext
```

### Connect to a wifi network
See [wireless.wiki.kernel.org/hostpad](https://wireless.wiki.kernel.org/en/users/documentation/hostapd)

See [T30](mx4/wifi.md#wifi-as-access-point)



