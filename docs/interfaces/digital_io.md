---
title:  Digital I/O
tags:
  - Digital I/O
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

[HMX](hmx/digital_io.md)

[MX-V](mxv/digital_io.md)

[mx4](mx4/digital_io.md)

## Geting started
Where possible, it is recommended to use the modern (since Linux v4.8) GPIO API. It is implemented in
[libgpiod](https://git.kernel.org/pub/scm/libs/libgpiod/libgpiod.git) and comes
with bindings also for C++ and Python.

The library comes with a set of tools that can be used from a shell script to
set and get values.

* gpiodetect - list all gpiochips present on the system, their names, labels and number of GPIO lines
* gpioinfo   - list all lines of specified gpiochips, their names, consumers, direction, active state and additional flags
* gpioget    - read values of specified GPIO lines 
* gpioset    - set values of specified GPIO lines, potentially keep the lines exported and wait until timeout, user input or signal
* gpiofind   - find the gpiochip name and line offset given the line name 
* gpiomon    - wait for events on GPIO lines, specify which events to watch, how many events to process before exiting or if the events should be reported to the console