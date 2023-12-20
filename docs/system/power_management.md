---
title: Power management
tags:
  - Power management
  - HMX
  - MX-4
  - MX-V
---
## Overview

Most of or platform has at least three different operating modes:
- Running
    - Running is the default operating state where we have full functionality.
- Sleep/Suspend
    - Main processor are suspend to ram. This a power saving
mode where as much as possible is powered down to minimize the power consumption and
fast resume time (around 1 second) to running state.
- Deep Sleep
    - Main processor are power cut off and only coprocessor are running in low power mode.
- Shutdown/Cutoff
    - the platform has almost no power consumption the main regulator is turned off. See [start signal](interfaces/start_signal.md)

The platform can wake-up from different sources where Real time clock and CAN is often used. List of wake up sources is platform specific and depending on the sleep mode. For example for `Shutdown/Cutoff` only start signal input is supported.

## Platform specific
- [HMX](mx4/power_management.md)
- [MX4](mx4/power_management.md)
- [MX-V](mxv/power_management.md)

