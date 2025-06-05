---
title: Bluetooth
tags:
  - Bluetooth
  - HMM
  - HMX
  - MX-V
---

## Overview

Bluetooth behavior can vary across different platforms. On some platforms, such as MX-V and HMX, WLAN and Bluetooth share the same antenna and cannot operate simultaneously in all modes. For others, like HMM, there is an option to use either Bluetooth or WLAN due to the limited number of SMA connectors available on the housing.

## User Connection to the Platform

Below is an example script to activate Bluetooth and allow a user to connect to the platform:

```bash
#!/bin/bash

# Start Bluetooth service
systemctl start bluetooth

# Enable Bluetooth interface
hciconfig hci0 up

# Make the system discoverable and pairable
bluetoothctl << EOF
power on
discoverable on
pairable on
EOF

echo "Bluetooth is now ready for connections."

```

To use this script, grant execution permissions and run it:

```bash
chmod +x setup_bluetooth.sh
./setup_bluetooth.sh
```

After executing the script, the system will be ready for users to connect via Bluetooth.


