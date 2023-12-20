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
    - activate this with rtc alarm.
- uart-active
    - support Rs-232 and Rs-485

#### Enter suspend
```
systemctl suspend
```

### Deep sleep

TODO...For developers at Hostmobility check more information [MX-V coprocessor](https://gitlab.com/hostmobility/mx5-cocpu)

### Shutdown

Shutdown/cutoff state turns the system off with close to zero power consumption. And it will only work if both internal and external [Start signals](../../interfaces/hmx/start_signal.md) are LOW/off.

```bash
shutdown -h now
#or
poweroff
```
