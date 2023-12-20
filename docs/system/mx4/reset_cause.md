---
title: Reset cause (MX-4)
tags:
  - Reset cause
  - MX-4
---

You can read out the platform "reset cause" from an SPI attribute or using the `/opt/hm/reset_cause.sh` script.
Multiple reset causes are possible. You can also zero out the current reset cause by executing `echo 0 > /opt/hm/pic_attributes/ctrl_pic_reset_cause`.

```bash
cat /opt/hm/pic_attributes/ctrl_pic_reset_cause
#or
/opt/hm/reset_cause.sh
```

| Bit | Reset Cause Text | Clarification |
|-----|------------------|-------------|
| 0   | Power On Reset   |             |
| 1   | Brown Out Reset  |             |
| 2   | Idle Reset       |             |
| 3   | Sleep Reset      |             |
| 4   | Watchdog Reset   | Co-cpu reset internal watchdog flag triggered |
| 5   | Software Reset   | Set by user |
| 6   | MCLR Reset       | Reset button |
| 7   | Config Mismatch Reset |         |
| 8   | Deep Sleep Reset |             |
| 9   | Illegal Opcode Reset |          |
| 10  | Trap Conflict Reset |           |
| 11  | Trap Default Reset | trace_default_interrupt |
| 12  | Trap OSC Reset   |              |
| 13  | Trap Address Reset |             |
| 14  | Trap Stack Reset |              |
| 15  | Trap Math Reset  |               |
| 16  | Protocol Watchdog Reset | Linux SPI protocol stopped sending and co-cpu reset |
| 17  | Clock Switch Failed |           |
| 18  | Deep Sleep Exit  |               |

