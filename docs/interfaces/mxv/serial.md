---
title: Serial communication (MX-V)
tags:
  - RS-232
  - RS-485
  - MX-V
---
## Overview

The MX-V features one RS-485 port (`/dev/ttymxc3`) and four RS-232 ports (`/dev/ttymxc0` for debug, `/dev/ttymxc1`, `/dev/ttymxc2`, `/dev/ttymxc4`).

- Console   `/dev/ttymxc0`
- Rs232-1   `/dev/ttymxc4`
    - supports RTS and CTS
- Rs232-2   `/dev/ttymxc1`
- Rs232-3   `/dev/ttymxc2`
- RS-485     `/dev/ttymxc3`