---
title: Digital I/O (MX-V)
tags:
  - Digital I/O
  - MX-V
---

## Overview
MX-V has 8 digital out that can be used as either sink or source on the same pin: digital-out-source or digital-out-sink with a number.

## Gpiodetect

By using gpiodetect, a list of the GPIO chips in the system is shown.

```bash
root@mxv-pt:~# gpiodetect
gpiochip0 [209c000.gpio] (32 lines)
gpiochip1 [20a0000.gpio] (32 lines)
gpiochip10 [digital_in] (13 lines)
gpiochip2 [20a4000.gpio] (32 lines)
gpiochip3 [20a8000.gpio] (32 lines)
gpiochip4 [20ac000.gpio] (32 lines)
gpiochip5 [20b0000.gpio] (32 lines)
gpiochip6 [20b4000.gpio] (32 lines)
gpiochip7 [modem_control] (4 lines)
gpiochip8 [ncv7751] (32 lines)
gpiochip9 [gpio_overlay] (25 lines)
```

## Digital out

### Overview

The digital out channels (lines) have been collected in an `overlay` virtual chip
that also restricts the user from changing the direction of the signal (which
can usually be done for these generic I/Os).

With the `gpioinfo` command, the available channels are listed.

```bash
root@mxv-pt:~# gpioinfo gpio_overlay
gpiochip9 - 25 lines:
        line   0: "digital-out-source-0" unused input active-high
        line   1: "digital-out-source-1" unused input active-high
        line   2: "digital-out-source-2" unused input active-high
        line   3: "digital-out-source-3" unused input active-high
        line   4: "digital-out-source-4" unused input active-high
        line   5: "digital-out-source-5" unused input active-high
        line   6: "digital-out-source-6" unused input active-high
        line   7: "digital-out-source-7" unused input active-high
        line   8: "digital-out-oc-0" unused input active-high
        line   9: "digital-out-oc-1" unused input active-high
        line  10: "digital-out-oc-2" unused input active-high
        line  11: "digital-out-oc-3" unused input active-high
        line  12: "digital-out-oc-4" unused input active-high
        line  13: "digital-out-oc-5" unused input active-high
        line  14: "digital-out-oc-6" unused input active-high
        line  15: "digital-out-oc-7" unused input active-high
        line  16: "digital-out-sink-0" unused input active-high
        line  17: "digital-out-sink-1" unused input active-high
        line  18: "digital-out-sink-2" unused input active-high
        line  19: "digital-out-sink-3" unused input active-high
        line  20: "digital-out-sink-4" unused input active-high
        line  21: "digital-out-sink-5" unused input active-high
        line  22: "digital-out-sink-6" unused input active-high
        line  23: "digital-out-sink-7" unused input active-high
        line  24: "digital-out-enable" unused input active-high
```

To find a specific signal, the `gpiofind` command can be used:

```bash
root@mxv-pt:~# gpiofind digital-out-enable
gpiochip9 24
```

### Enable digital out

To enable digital out, the `digital-out-enable` line needs to be set to high.

We can use the `gpioset` command in combination with `gpiofind` in `bash`.

```bash
root@mxv-pt:~# gpioset $(gpiofind digital-out-enable)=1
```

### Digital out high and low

The digital out drivers can both source and sink current. The 8 source drivers
are controlled with `digital-out-source-0..7` and the sink drivers with
`digital-out-sink-0..7`. For a specific channel, the source and sink drivers
cannot be used at the same time.

```bash
root@mxv-pt:~# gpioset $(gpiofind digital-out-source-0)=1
```

### Over-current sense

For each digital-out-source-n there is a digital-out-oc-n which can be read to
detect short-circuits.

```bash
root@mxv-pt:~# gpioget $(gpiofind digital-out-oc-0)
```

### Debugging

`/sys/kernel/debug/gpio` can be read to get the kernel's view of the GPIO status.

```bash
root@mxv-pt:~# cat /sys/kernel/debug/gpio | grep -i dig
 gpio-48  (DIG_OUT_LO_1        |DIG-OUT-LO          ) out hi
 gpio-49  (DIG_OUT_EN          |DIG-OUT-EN          ) out hi
 gpio-64  (DIG_OUT_HI_1        |DIG-OUT-HI          ) out hi
 gpio-65  (DIG_OUT_HI_2        |DIG-OUT-HI          ) out lo
 gpio-66  (DIG_OUT_HI_3        |DIG-OUT-HI          ) out lo
 gpio-67  (DIG_OUT_HI_4        |DIG-OUT-HI          ) out lo
 gpio-68  (DIG_OUT_HI_5        |DIG-OUT-HI          ) out lo
 gpio-69  (DIG_OUT_HI_6        |DIG-OUT-HI          ) out lo
 gpio-70  (DIG_OUT_HI_7        |DIG-OUT-HI          ) out lo
 gpio-71  (DIG_OUT_HI_8        |DIG-OUT-HI          ) out lo
 gpio-72  (DIG_OUT_HI_OC_1     |DIG-OUT-HI-OC       ) in  hi
 gpio-73  (DIG_OUT_HI_OC_2     |DIG-OUT-HI-OC       ) in  lo
 gpio-74  (DIG_OUT_HI_OC_3     |DIG-OUT-HI-OC       ) in  lo
 gpio-75  (DIG_OUT_HI_OC_4     |DIG-OUT-HI-OC       ) in  lo
 gpio-76  (DIG_OUT_HI_OC_5     |DIG-OUT-HI-OC       ) in  hi
 gpio-77  (DIG_OUT_HI_OC_6     |DIG-OUT-HI-OC       ) in  lo
 gpio-78  (DIG_OUT_HI_OC_7     |DIG-OUT-HI-OC       ) in  hi
 gpio-79  (DIG_OUT_HI_OC_8     |DIG-OUT-HI-OC       ) in  lo
 gpio-166 (DIG_OUT_LO_2        |DIG-OUT-LO          ) out hi
 gpio-493 (digital-out-source-0|gpioset             ) in  hi
 gpio-494 (digital-out-source-1)
 gpio-495 (digital-out-source-2)
 gpio-496 (digital-out-source-3)
 gpio-497 (digital-out-source-4)
 gpio-498 (digital-out-source-5)
 gpio-499 (digital-out-source-6)
 gpio-500 (digital-out-source-7)
 gpio-501 (digital-out-oc-0    )
 gpio-502 (digital-out-oc-1    )
 gpio-503 (digital-out-oc-2    )
 gpio-504 (digital-out-oc-3    )
 gpio-505 (digital-out-oc-4    )
 gpio-506 (digital-out-oc-5    )
 gpio-507 (digital-out-oc-6    )
 gpio-508 (digital-out-oc-7    )
 gpio-509 (digital-out-sink-0  )
 gpio-510 (digital-out-sink-1  )
 gpio-511 (digital-out-enable  )
```

## Digital in
This unit has 13 digital and analog in (adc) channels using iio devices.

```bash
 gpioget $(gpiofind digital-in-1)
 gpioget $(gpiofind digital-in-2)
 gpioget $(gpiofind digital-in-3)
 gpioget $(gpiofind digital-in-4)
 gpioget $(gpiofind digital-in-5)
 gpioget $(gpiofind digital-in-6)
 gpioget $(gpiofind digital-in-7)
 gpioget $(gpiofind digital-in-8)

 # analog way to access the value
 cat /sys/bus/iio/devices/iio:device0/*DIG_IN_AN_0_raw
 cat /sys/bus/iio/devices/iio:device0/*DIG_IN_AN_1_raw
 cat /sys/bus/iio/devices/iio:device0/*DIG_IN_AN_2_raw
 cat /sys/bus/iio/devices/iio:device0/*DIG_IN_AN_3_raw
 cat /sys/bus/iio/devices/iio:device0/*DIG_IN_AN_4_raw
 cat /sys/bus/iio/devices/iio:device0/*DIG_IN_AN_5_raw
 cat /sys/bus/iio/devices/iio:device0/*DIG_IN_AN_6_raw
 cat /sys/bus/iio/devices/iio:device0/*DIG_IN_AN_7_raw

 cat /sys/bus/iio/devices/iio:device0/*AN_IN_AN_1_raw
 cat /sys/bus/iio/devices/iio:device0/*AN_IN_AN_2_raw
 cat /sys/bus/iio/devices/iio:device0/*AN_IN_AN_3_raw
 cat /sys/bus/iio/devices/iio:device0/*AN_IN_AN_4_raw
 cat /sys/bus/iio/devices/iio:device0/*AN_IN_AN_5_raw
```
