---
title: CAN (MX-4)
tags:
  - CAN
  - T30
  - T30 FR
  - CT
  - CT GL

---
## Overview T30 and T30 FR

* 6 CAN 2.0B channels, typically named `can0` to `can5`
* Partial networking support for wakeup on specific CAN frame (configured with `can-xcvr` application)

### can-xcvr

We are using the [TJA1145T](https://www.nxp.com/docs/en/data-sheet/TJA1145.pdf), so you will be able to read more about the registers from the data sheet.

```bash
root@mx4-t30-29009999:~# can-xcvr --help
  -D --device   Tranceiver device to use (default can0)
  -m --mode    1 = sleep with wake up on any frame
    2 = normal
    3 = sleep with wake up on dedicated CAN wake-up frames
    4 = sleep with only WAKE pin as wakeup source
  -w --wuf      wake-up frame(wake up on dedicated frame(s)),
  Frame control(fc)
    bit 7 = IDE = standard(11bit) 0, 1 (29bit) id
     bit 6 = PNDM = 0, means data length code and data field are ‘don’t care’ for wake-up
      1, data length code and data field are evaluated at wake-up
    bit 5 to 4 reserved
    bit 3:0 = DLC number of data bytes expected in a CAN frame
    Example fc=0x00,
  Mask (11 bit)
    Example mask=0x007,
  ID (11 bit)
    Example id=0x1A0,
    Results in that any of eight different identifiers will be recognized
   as valid in the received WUF (from 0x1A0 to 0x1A7)
  CDR (can bit rates), 50 kbit/s, 100 kbit/s, 125 kbit/s, 250 kbit/s, 500 kbit/s and 1 Mbit/s are
supported during selective wake-up.
    Example cdr=250  Additional Data mask(dm) banks if DLC != 0, start with DM7
    Example dm7=0xFF if DLC = 1 this will result in 8 groups of nodes could be woken up
     full example -m 3 -w fc=0x00,mask=0x007,id=0x1A0,cdr=250 -s
  -s --status   status of transceiver
```


## Overview CT and CT GL
3 CAN 2.0B channels, typically named `can0` to `can3`.