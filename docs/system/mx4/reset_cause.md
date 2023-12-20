---
title: Reset cause (MX-4)
tags:
  - Reset cause
  - MX-4
---

## Reset Cause

One can read out the system reset cause from a spi attribute.

```bash
root@ultra14211046:~# cat /opt/hm/pic_attributes/ctrl_pic_reset_cause
or use /opt/hm/reset_cause.sh
```

```c
#define REG_BIT(bit)                    (1 << (bit))

#define PRC_POWER_ON_RESET              REG_BIT(0)
#define PRC_BROWN_OUT_RESET             REG_BIT(1)
#define PRC_IDLE                        REG_BIT(2)
#define PRC_SLEEP                       REG_BIT(3)
#define PRC_WDTO                        REG_BIT(4)
#define PRC_SWR                         REG_BIT(5)
#define PRC_MCLR                        REG_BIT(6)
#define PRC_CONFIG_MISMATCH             REG_BIT(7)
#define PRC_DEEP_SLEEP                  REG_BIT(8)
#define PRC_ILLEGAL_OPCODE_RESET        REG_BIT(9)
#define PRC_TRAP_CONFLICT_RESET         REG_BIT(10)
#define PRC_TRAP_DEFAULT		REG_BIT(11)
#define PRC_TRAP_OSC			REG_BIT(12)
#define PRC_TRAP_ADDRESS		REG_BIT(13)
#define PRC_TRAP_STACK			REG_BIT(14)
#define PRC_PROTOCOL_WATCHDOG		REG_BIT(16)
#define PRC_TRAP_MATH			REG_BIT(15)
#define PRC_CLOCK_SWITCH_FAILED		REG_BIT(17)
#define PRC_DEEP_SLEEP_EXIT		REG_BIT(18)
```

0
"Reset Cause String: Power On Reset"

1
"Reset Cause String: Brown Out Reset"

2
"Reset Cause String: Idle Reset"

3
"Reset Cause String: Sleep Reset"

4
"Reset Cause String: Watchdog Reset (Co-cpu rest internal watchdog flag trigged)

5
"Reset Cause String: Software Reset (set by user)"

6
"Reset Cause String: MCLR Reset (reset button)"

7
"Reset Cause String: Config Missmatch Reset"

8
"Reset Cause String: Deep Sleep Reset"

9
"Reset Cause String: Illegal Opcode Reset"

10
"Reset Cause String: Trap Conflict Reset"

11
"Reset Cause String: Trap Default Reset
and trace_default_interrupt"

12
"Reset Cause String: Trap OSC Reset"


13
"Reset Cause String: Trap Address Reset"


14
"Reset Cause String: Trap Stack Reset"

15
"Reset Cause String: Trap Math Reset"


16
"Reset Cause String: Protocol Watchdog Reset (linux spi protocol stoped sending and co-cpu reset)"

17
"Reset Cause String: Clock Switch Failed"

18
"Reset Cause String: Deep Sleep Exit"
