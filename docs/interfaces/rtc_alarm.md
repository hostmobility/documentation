---
title: Wake on Real Time Clock (set alarm)
tags:
  - HMX
  - MX-V
  - C61
  - T30
  - T30 FR
---

To use wake on RTC, you can run the command below.

```
sleeptime_seconds=30
RTC=/sys/class/rtc/rtc0/wakealarm; echo 0>$RTC && echo +${sleeptime_seconds} >$RTC && systemctl suspend
```

For HMX, `rtc1` will also work.
