## Login

The Host Mobility platforms have an SSH server enabled by default. 
For ethernet over USB0,the IP address is 192.168.250.1. For regular ethernet, the it gets
IP addresses from a DHCP server, e.g. a router.  In case there is no
DHCP server available, the IP addresses default to `192.168.1.200`
(eth0) and `192.168.2.200` (eth1).

Log in by running `ssh root@IP-ADDRESS` and provide an empty
password.  The latter can be changed as usual with the `passwd` command.

It is also possible for developer to use a ttl to usb cable to connect to console using the internal uart debug connector.