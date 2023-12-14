---
title: MX-4 Wake on Real Time Clock (set alarm) using go-to-sleep script
tags:
  - MX-4
  - C61
  - T30
  - T30 FR
---

On MX-4 platforms, wake on RTC can be configured using the `/opt/hm/go_to_sleep.sh` script.

```bash
/opt/hm/go_to_sleep.sh -h
Usage: go_to_sleep.sh options (t:hdcCnsaD)
		-t <time in seconds> - Setup wakealarm (rtc)
		-d - Disable wake on DIGITAL-IN-2
		-a - Disable wake on START-SIGNAL
		-l <mV level> - START-SIGNAL wake-up volt level
		-c - Wake on CAN
		-n - Will renew dhcp lease
		-C - Disable suspend CAN for quicker wakeup-time
		-s - Will suspend modem (turn off), Will not restore on wake up
		-D <time in seconds> - Will enter deep sleep.
			Power to main CPU will be cut after specified time and it
			will restart with a cold reboot on wake up. The application
			is responsible of shutting down the system properly before
			the power is cut.
		-p <wake up mask> - Mask to enable/disable wakeup sources
		-h - Print this text
```
