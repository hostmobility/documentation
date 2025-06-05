---
title: Watchdog (HMM)
tags:
  - Watchdog
  - HMM
---

## Overview

This platform comes with a dedicated watchdog running on the M4 co-processor. Its job is to ensure that the system does not get stuck in a hung state during boot. If the system freezes, it will be forcefully rebooted after 45 seconds.
