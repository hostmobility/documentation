---
title: Wake up cause
tags:
  - Wake up cause
  - Power Management
  - MX-4
---

Here is a list of possible wake up signals it is used both for enable the wake up mode and to read what mode it was that woke the system.

## Read
```bash
MX4_SPI_DIR=/opt/hm/pic_attributes
cat $MX4_SPI_DIR/ctrl_wakeup_cause
#or
/opt/hm/wake_up_cause.sh
```
## activate coprocessor wake up source
```bash
MX4_SPI_DIR=/opt/hm/pic_attributes
echo 0xXX >  $MX4_SPI_DIR/ctrl_wakeup_sources_register
```

## List
| Bit | Wake Up Signal        | Explanation                                     |
|-----|-----------------------|-------------------------------------------------|
| 0x00| WAKE_UP_SRC_NONE                  |                                                 |
| 0x01| WAKE_UP_SRC_WDT                   | Watchdog                                        |
| 0x02| WAKE_UP_SRC_SPI INT               | SPI communication from Linux system              |
| 0x03| WAKE_UP_SRC_MAIN VOLTAGE          |                                                 |
| 0x04| WAKE_UP_SRC_BATTERY VOLTAGE       |                                                 |
| 0x05| WAKE_UP_SRC_ANALOG 1              | Analog In number 1                               |
| 0x06| WAKE_UP_SRC_ANALOG 2              | Analog In number 2                               |
| 0x07| WAKE_UP_SRC_ANALOG 3              | Analog In number 3                               |
| 0x08| WAKE_UP_SRC_ANALOG 4              | Analog In number 4                               |
| 0x09| WAKE_UP_SRC_START SIGNAL          |                                                 |
| 0x0A| WAKE_UP_SRC_CAN                   | Any CAN (if T30Fr check which with can-xcvr -s) |
| 0x0B| WAKE_UP_SRC_DIN 1 F               | Digital In number 1 (Falling Edge)               |
| 0x0C| WAKE_UP_SRC_DIN 1 R               | Digital In number 1 (Rising Edge)                |
| 0x0D| WAKE_UP_SRC_DIN 2 F               | Digital In number 2 (Falling Edge)               |
| 0x0E| WAKE_UP_SRC_DIN 2 R               | Digital In number 2 (Rising Edge)                |
| 0x0F| WAKE_UP_SRC_DIN 3 F               | Digital In number 3 (Falling Edge)               |
| 0x10| WAKE_UP_SRC_DIN 3 R               | Digital In number 3 (Rising Edge)                |
| 0x11| WAKE_UP_SRC_DIN 4 F               | Digital In number 4 (Falling Edge)               |
| 0x12| WAKE_UP_SRC_DIN 4 R               | Digital In number 4 (Rising Edge)                |
| 0x13| WAKE_UP_SRC_DIN 5 F               | Digital In number 5 (Falling Edge)               |
| 0x14| WAKE_UP_SRC_DIN 5 R               | Digital In number 5 (Rising Edge)                |
| 0x15| WAKE_UP_SRC_DIN 6 F               | Digital In number 6 (Falling Edge)               |
| 0x16| WAKE_UP_SRC_DIN 6 R               | Digital In number 6 (Rising Edge)                |
| 0x17| WAKE_UP_SRC_MODEM RING            | Not supported                                   |
| 0x18| WAKE_UP_SRC_START SWITCH F        |                                                 |
| 0x19| WAKE_UP_SRC_START SWITCH R        |                                                 |
| 0x20| WAKE_UP_SRC_MIN 1 F               |                                                 |
| 0x21| WAKE_UP_SRC_MIN 1 R               |                                                 |
| 0x22| WAKE_UP_SRC_MIN 2 F               |                                                 |
| 0x23| WAKE_UP_SRC_MIN 2 R               |                                                 |
| 0x24| WAKE_UP_SRC_DIN 7 F               | Digital In number 7 (Falling Edge)               |
| 0x25| WAKE_UP_SRC_DIN 7 R               | Digital In number 7 (Rising Edge)                |
| 0x26| WAKE_UP_SRC_DIN 8 F               | Digital In number 8 (Falling Edge)               |
| 0x27| WAKE_UP_SRC_DIN 8 R               | Digital In number 8 (Rising Edge)                |

