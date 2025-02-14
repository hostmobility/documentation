---
title: Serial communication
tags:
  - Serial communication
  - RS-232
  - RS-485
  - HMM
  - MX-V
  - CT
  - CT GL
  - C61
---
## Overview
Several products have one or more serial interfaces:
- RS-232
- RS-485


## Platform specific
- [HMM](hmm/serial.md)
- [MX-V](mxv/serial.md)
- [CT](mx4/serial.md)
- [CT GL](mx4/serial.md)
- [C61](c61/serial.md)

## Example
```bash
    echo -e hello\r\n | microcom  -s 9600 -t 10000 -X /dev/ttyTHS1
```

## Console output

The console output on the device defaults to a UART connected to a debug pin list inside the housing. However, it is possible to switch the console output to an external RS-232 either from the u-boot environment list or dynamically at runtime using `setconsole`.

## Baudrate

The supported range is from 9600 to 115200.