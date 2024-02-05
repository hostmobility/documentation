---
title:  Host Monitor X start signals
tags:
  - Start signals
  - HMX
---

## Overview
There are 5 start signals on different connectors. Start 1 to 4 is meant to be used to start the device and Start 5 is meant to be used with an external LED or an output for signal start.

To start the device the current signal time needs to be at least 2-3 seconds long (in the future we might shorter the time) for the unit to start up and be able to hold the start signal internally.

The internal signal is also used for the cut-off function.

To shut down the unit, run
```
shutdown -h now
```
When cut-off is enabled the unit is back to same state as it was when you plugged it in and will start again when any of the start signals goes high.

## Read start signal

To read this signal you must first unbind it from gpio-keys or read it from /dev/input/event0.

Example read with unbind gpio-key
**Note:** This will disable wake-up possibility on digital and start signals.
```
echo gpio-keys > /sys/bus/platform/drivers/gpio-keys/unbind
gpioget $(gpiofind IN_START)
echo gpio-keys > /sys/bus/platform/drivers/gpio-keys/bind
```

