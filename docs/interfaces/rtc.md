---
title: Real Time Clock
tags:
  - C61
  - HMX
  - MX-V
  - T30
  - T30 FR
---


## Get current time (system and hardware)

On modern distributions, timedatectl can be used to get detailed time and date information.

```bash
# timedatectl
               Local time: Fri 2023-12-15 13:22:09 UTC
           Universal time: Fri 2023-12-15 13:22:09 UTC
                 RTC time: Fri 2023-12-15 13:21:40
                Time zone: Universal (UTC, +0000)
System clock synchronized: no
              NTP service: active
          RTC in local TZ: no
```

The Linux system time is synchronized with the internal real time clock at boot time.

If `timedatectl` is missing, system and time can be read out using the `date` command.

```bash
# date
Fri Dec 15 13:32:31 UTC 2023
```

Hardware time:

```bash
# hwclock
2023-12-15 13:31:46.826215+00:00
```

## Set system time

```bash
timedatectl set-time "2023-12-15 13:10:00"
```

or

```bash
date --set="20231215 13:10"
```

On our default images we try to synchronize time from `pool.ntp.org` on an ifup networking event. If we succeed with the `ntpdate` command we synchronize the system time to hardware clock (main CPU internal real time clock).

See `/etc/network/if-up.d/ntpdate-sync` and `/etc/default/ntpdate` on target system.

### Set hardware clock to system time

```bash
hwclock -w
```

## Set system time to hardware clock


```bash
hwclock --systohc
```

## Set alarm (wake on RTC)

- [Modern platforms](rtc_alarm.md)
- [MX-4](mx4/rtc_alarm.md)


## Device path

The internal real time clock can be found at `/dev/rtc0`.
