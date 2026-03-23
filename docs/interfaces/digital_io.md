---
title:  Digital I/O
tags:
  - Digital I/O
  - HMM
  - MX-V
  - T30
  - T30 FR
  - MX-4
  - CT
  - CT GL
  - C61
  - HMX
---

## Overview
Digital I/O is handled by the Linux GPIO subsystem. This is a generic interface that organizes the GPIO pins by the hardware chips that input or output digital signals. The interface is generic and presents a large number of inputs and outputs in the system, mostly internal.

## Platform specific

- [HMM](hmm/io.md)
- [HMX](hmx/digital_io.md)
- [MX-V](mxv/digital_io.md)
- [MX-4](mx4/digital_io.md)

## Getting started

Where possible, it is recommended to use the modern (since Linux v4.8) GPIO API. It is implemented by
[libgpiod](https://git.kernel.org/pub/scm/libs/libgpiod/libgpiod.git), which also provides high-level
bindings for C++, Python, GLib, and Rust.

The library comes with a set of command-line tools that can be used from shell scripts to
inspect and control GPIO lines:

* `gpiodetect`  -- list all gpiochips present on the system, their names, labels, and number of GPIO lines
* `gpioinfo`    -- list GPIO lines, their chip, offset, name, direction, and additional attributes
* `gpioget`     -- read values of specified GPIO lines
* `gpioset`     -- set values of specified GPIO lines
* `gpiomon`     -- wait for edge events on GPIO lines
* `gpionotify`  -- wait for line-info change events on GPIO lines

### libgpiod v1.x

In libgpiod v1.x, GPIO lines are typically addressed by gpiochip and line
offset. To work with named lines, `gpiofind` can be used to look up the chip
name and offset first.

Example:

```bash
gpiofind MODEM_PWR
gpioset $(gpiofind MODEM_PWR)=0
gpioget $(gpiofind IN_START)
```

### libgpiod v2.x

In libgpiod v2.x, `gpiofind` was removed. Its functionality was absorbed into
the other tools, which can resolve GPIO line names directly.

When using `gpioset`, note that the line state is only maintained while
the process is running. For scripts, this means that `gpioset` must be
kept alive long enough for the requested output to remain asserted.
See the [libgpiod command-line tools documentation](https://libgpiod.readthedocs.io/en/stable/gpio_tools.html)
for details.

Example:

```bash
gpioinfo MODEM_PWR
timeout 0.1 gpioset MODEM_PWR=0
gpioget IN_START
gpionotify MODEM_PWR
```

**Note:** Only the HMX platform currently uses libgpiod v2.x.
