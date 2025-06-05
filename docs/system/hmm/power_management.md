---
title: Power management (HMM)
tags:
  - Power management
  - HMM
---
## Overview

This platform supports suspend and a range of wake-up signals. See the individual [wake up](#wake-up) links below.

### Suspend

Click on the target interface to read more about how to set up sleep and wake up.

#### Wake up

- CAN: supports wake on any frame only, and the current design uses the same wake-up pin on both buses.
- [RTC internal alarm (rtc0)](../../interfaces/rtc_alarm.md)
- Misc/future work: untested possibilities include wake on WLAN, RS-232, CAN0 RX pin and CAN1 RX pin (would require device tree updates and drivers).

#### Enter suspend
```
systemctl suspend
```

