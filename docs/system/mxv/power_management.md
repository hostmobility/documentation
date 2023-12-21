---
title: Power management (MX-V)
tags:
  - Power management
  - MX-V
---
## Overview

This platform support suspend, Deep sleep and cutoff/shutdown.

### Suspend

#### Wake up
Set to 1 to activate wakeup on channel:
- accel-int-active
    - activate wakeup pin on coprocessor
- can-active
    - activate all CAN
- modem-ring-active
    - Not supported
- rtc-int-active
    - activate this with RTC alarm.
- uart-active
    - support RS-232 and RS-485

#### Enter suspend
```
systemctl suspend
```

### Deep sleep

TODO: For developers at Host Mobility, see [MX-V coprocessor](https://gitlab.com/hostmobility/mx5-cocpu) for more information.

### Shutdown

Shutdown/cutoff state turns the system off with close to zero power consumption. It will only work if both the internal and external [start signals](../../interfaces/hmx/start_signal.md) are LOW/off.

```bash
shutdown -h now
#or
poweroff
```
