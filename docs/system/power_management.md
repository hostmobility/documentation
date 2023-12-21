---
title: Power management
tags:
  - Power management
  - HMX
  - MX-4
  - MX-V
---
## Overview

The majority of platforms have at least three different operating modes:
- Running
    - The default operating state where we have full functionality.
- Sleep/Suspend
    - Main processor is suspended to RAM. This is a power-saving
mode where as much as possible is powered down to minimize the power consumption and
fast resume time (around 1 second) to running state.
- Deep Sleep
    - The main processor is powered off and only the coprocessor is running in low-power mode.
- Shutdown/Cut-off
    - The machine has almost no power consumption as the main regulator is turned off. See [start signal](interfaces/start_signal.md)

The machine can wake up from different sources but the Real time clock and CAN are most often used. The list of wake-up sources is platform specific and depending on the sleep mode. For `Shutdown/Cutoff`, for example, only start signal input is supported.

## Platform specific
- [HMX](mx4/power_management.md)
- [MX4](mx4/power_management.md)
- [MX-V](mxv/power_management.md)

