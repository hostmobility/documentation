---
title:  Host Monitor X start signals
tags:
  - Start signals
  - HMX
---

## Overview
There are 5 start signals on different connectors. Start 1 to 4 is meant to be used to start the device and Start 5 is meant to be used with an external LED or an output for signal start. Only one external start signal is needed to start the device. They are all connected to a a singel input and it can be read from gpio-key event or unbind gpio-key to use this signal and other digital in signals as regular gpios.

**Note** unbind gpio-keys will lose the wake-up possibility on those signals and all [digital in](digital_io.md) signals.

To start the device the current signal time needs to be at least 2-3 seconds long (in the future we might shorter the time) for the unit to start up and be able to hold the start signal internally.

The internal signal (called power_on) is also used to hold the power on even if the START 1,2,3 or 4 is down. 
If you want to use the the cut-off function, make sure that IN_START is low(0) before use poweroff or shutdown.

To shut down the unit, run
```
shutdown -h now
```
When cut-off is enabled the unit is back to same state as it was when you plugged it in and will start again when any of the start signals goes high.

## Read start signal

To read this signal you must first unbind it from gpio-keys or read it from /dev/input/event1.

Example read with unbind gpio-key
**Note:** This will disable wake-up possibility on digital and start signals.
```
echo gpio-keys > /sys/bus/platform/drivers/gpio-keys/unbind
gpioget $(gpiofind IN_START)
echo gpio-keys > /sys/bus/platform/drivers/gpio-keys/bind
```

##[Sleep and wake up](digital_io.md#sleep-and-wake-up)

