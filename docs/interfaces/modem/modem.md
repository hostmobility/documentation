---
title: Modem
tags:
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

The ways to communicate with the modems differ between products. This page shows what is common for all the modems provided in our products.

## Platform specific

[HMX](../hmx/modem.md)

[MX-V](../mxv/modem.md)

[CT_GL](../ctgl/modem.md)

[C61](../c61/modem.md)

[CT](../mx4/modem.md)

[T30/T30fr](../mx4/modem.md)

## Communication channels
- Quectel
    - Radio /dev/ttyUSB0
    - GPS   /dev/ttyUSB1
    - AT commands  /dev/ttyUSB2
    - 4G/LTE /dev/ttyUSB3
- Gemalto
    - Radio /dev/ttyACM0
    - GPS   /dev/ttyACM1
    - AT commands  /dev/ttyACM2
    - 4G/LTE /dev/ttyACM3

## Controlling the modem with AT commands

### Simple read and write
```
cat /dev/ttyACM2
echo "AT+CFUN?" > /dev/ttyACM2
```

### Better way to read and write

Use microcom to connect to the modem. (Exit microcom with `CTRL-X`)

```bash
microcom /dev/ttyUSB2
# or, for PLS8 modems
microcom /dev/ttyACM2
```

#### To get more informative error messages, you can type:
```
AT+CMEE=2
```

Expected reply
```bash
OK
```

## Test mobile network

* List all current network operators:
```
AT+COPS=?`
```

* After 20--30 seconds, you get something similar to:

```
+COPS: (1,"3 SE","3 SE","24002",7),(1,"Telenor SE","TelenorS","24008",7),(1,"Tele2","Tele2 SE","24007",7),(1,"TELIA S","TELIA","24001",7),(1,"TELIA S","TELIA)
```

### Check status of PIN code protection

type
```bash
AT+CPIN?
```
expected:
```bash
+CPIN: READY
```
error:
```bash
+CME ERROR: SIM not inserted
```



