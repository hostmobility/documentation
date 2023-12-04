# Networking

Networking is configured by the scripts in `/etc/network`.

Configuration can also be done manually with the [iproute2](https://wiki.linuxfoundation.org/networking/iproute2) utilities, e.g. the `ip` command.

## Ethernet

The MX-V has two Ethernet ports, `eth0` with 1 gigabit signalling speed and
`eth1` at 100 megabit. In the default configuration the
Ethernet interfaces are configured to request their IP addresses using DHCP
with a fallback to static addresses (192.168.1.200 for eth0 and 192.168.2.200
for eth1). See scripts in `/etc/network/if-up.d` for details.

## USB

Ethernet over USB is supported via RNDIS. Connect a USB-A cable to the
USB0 port on the MX-V and a free USB port on e.g. a PC, then power on
the MX-V or reboot. This will give the PC the IP address 192.168.250.2
and the MX-V 192.168.250.1.

## WiFi

After accessing the MX-V, you can set up WiFi using
e.g. wpa_supplicant. The interface will show up as mlan0.

```
wpa_passphrase ${WIFI_SSID} ${WIFI_PASSWORD}
wpa_supplicant -B -imlan0 -c /etc/wpa_supplicant.conf -Dnl80211,wext
```



