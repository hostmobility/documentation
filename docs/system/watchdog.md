---
title: Watchdog
tags:
  - HMM
  - C61
  - CT
  - CT GL
  - HMX
  - MX-4
  - MX-V
  - T30
  - T30 FR
  - Watchdog
---

## Overview

The reference systems of all our platforms come with a standard Linux watchdog that is *disabled by default*.

To enable this watchdog, simply write to it as follows:

```bash
echo 1 > /dev/watchdog
```

This command starts the watchdog timer. If the watchdog is not "fed" again within 60 seconds, the system will reboot. To keep the system running, you must "feed" it periodically by writing to `/dev/watchdog` before the timeout expires.

## Platform specific
- [HMM](hmm/watchdog.md)
- [HMX](hmx/watchdog.md)
