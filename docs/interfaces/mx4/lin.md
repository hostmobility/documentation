---
title: LIN (MX-4)
tags:
  - LIN
  - MX-4
  - T20
  - T30
  - T30 FR
  - V61
---

## Deactivate LIN
Local Interconnect Network (LIN) is enabled by default but you can disable it by writing a zero to
`LIN enabled` and/or `LIN2 enabled`. See [Digital IO](../digital_io.md) on how use the Linux GPIO API.

## How to control LIN via serial interface

The LIN interface in the coprocessor can be accessed via the serial console with baud rate 115200.

* T30 and T30 FR
    - LIN 1: /dev/ttyHS1
    - LIN 2: /dev/ttyHS3
* T20
    - LIN 1: /dev/ttyHS1
    - LIN 2: /dev/ttyHS3
* V61
    - LIN 1: /dev/ttyLP2
    - LIN 2: /dev/ttyLP1 (CRTSCTS must NOT be enabled or the communication will lock)

The LIN interface is controled via a set of predefined frames, mostly used to alter the LIN schedule table.

### Format

All frames sent to the coprocessor is on the format

```
start of transmission | message length | message type | data | checksum
```

- **Start of transmission** (4 bytes)

  This is a byte sequence used to indicate the start of a frame. It consists of the 4-byte sequence `0x7e 0x7e 0x7e 0xa7`.

- **Message length** (1 byte)

  The length of `message type` (1 byte) + `data` (variable) + `checksum` (1 byte). The byte for message length is not included in the message length.

- **Message type** (1 byte)

  Indicates the type of operation requested. Values start at 1 and are sequentially increased.

 1. [Received response](#received-response). The message contains data received from the LIN slave unit. Direction from coprocessor to Linux.

 2. [Set schedule](#set-schedule). Set up the LIN schedule.

 3. [Set frame](#set-frame). Set up a LIN frame.

 4. [Set item](#set-item). Set up a LIN schedule item.

 5. [Set baudrate](#set-baudrate). Set up LIN baud rate.

 6. [Set master](#set-master). Set up master/listen mode.

 7. [Listen message](#listen-message)

 8. [Overflow messages](#overflow-messages)


Defined in lin_general.h as:
```c
#define MSG_RECV_RESPONSE 1
#define MSG_SET_SCHEDULE 2
#define MSG_SET_FRAME 3
#define MSG_SET_ITEM 4
#define MSG_SET_BAUDRATE 5
#define MSG_SET_MASTER 6
#define MSG_LISTEN_MSG 7
```

data (variable):
Bytes of data that each message type may contain.

checksum:
A simple XOR checksum of all bytes in the message including message length.

#### Message types
##### Received response
    If a frame that requests a response from a slave unit is configured to
    forward the response, the response is forwarded from coprocessor to Linux in a
    frame of this format:
    message start | length of message | message type 1 | data (revc status 1
    byte, frame id 1 byte, response length 1 byte, response data) | checksum

##### Set schedule
    This frame sets the start, end and current item to handle and
    enables/disables the schedule. Start, end and current can be any value
    from 0 to 255. Start cannot be after end. Current must be within start and end interval.
    Enabled i any value greater than 0.
    Format:
    message start | length of message | message type 2 | data (start slot 1
    byte, end slot 1 byte, current slot 1 byte, enabled 1 byte) | checksum

##### Set frame
    This frame type is used to set up a specific LIN frame.
    Format:
    message start | length of message | message type 3 | data (LIN id 1 byte,
    frame options 1 byte, frame flags 1 byte, data length 1 byte, data
    0-LIN_MAX_DATABYTES) | checksum

    LIN id can be any valid LIN id. from 0 to 64.
    frame options:
        Specifies if frame is send/receive. Bit 0 -- unset specifies frame is
        send; bit 1 -- if response shall be forwarded; bit 3 - if frame is
        one-shot.

    frame flags:
        Specifies the version of the LIN protocol to be used. Bit 0 -- unset
        specifies that protocol 1 is used for this frame.

    data length:
        Length of data to be sent or received. For receive frames, the expected
        data length must be set.

##### Set item
    This frame type is used to set up an item in the schedule.
    It specifies a position in the schedule where a given LIN id shall be
    handled (multiple items with the same id can exist), how many LIN ticks
    the item shall use and if the item is enabled.
    Format:
    message start | length of message | message type 4 | data (frame number 1
    byte, LIN id 1 byte, LIN ticks 1 byte, enabled 1 byte) | checksum

    frame number:
        Which slot in the schedule. Value 0 -- LIN_SCHEDULE_TABLE_ENTRIES (256)

    LIN id:
        Any valid LIN id.

    LIN ticks:
        How much time the item occupies. One tick is 10ms long.

    Enable:
        Any value >0 to enable.

##### Set baudrate
    The defualt baud rate of this LIN implementation is 9600. The LIN
    specification states that the baud rates 2400, 9600 and 19200 are supported.
    All of the these rates are supported in addition to 4800 and 10400.
    Format:
    message start | length of message | message type 5 | data (baudrate
    enumerator 1 byte) | checksum

    baudrate enumeration:
        2400 - 1
        4800 - 2
        9600 - 3
        10400 - 4
        19200 - 5

##### Set master
    Configures LIN bus for either acting as master or just listening for LIN
    data on the bus. The LIN bus is configured as master by default.
    When configured as listener all valid messages will be forwarded.
    Format:
    message start | length of message | message type 6 | data (master/listen 1
    byte) | checksum

    master - 1
    listen - 0
#### Listen message
    When the LIN bus is in listen mode messages will be sent to Linux user space when data are found on the bus.
    Format:
    message start | length of message | message type 7 | status| data | checksum

    status:
    Defined statuses:
```c
#define STATUS_OK 0
#define STATUS_RECV_ERROR 1
#define STATUS_RECV_NO_DATA 2
#define STATUS_MASTER_REQUEST 3
```
    STATUS_RECV_ERROR indicates that data has been read on the bus, but no valid LIN frame were found. Just all the data is returned for debugging purposes.
    STATUS_RECV_NO_DATA activity on the bus but no data found.
    STATUS_MASTER_REQUEST message with only one byte data found. This is a
    master request.

    data:
    The LIN frame.
    id | data | LIN checksum
    id: With parity omit bit 7 and 6 for id without parity
    LIN checksum: If it is a valid frame the checksum is here
#### Overflow message
    If an overflow occurs at any of the LIN buses, a report of the bus ID
    and the overflow count are sent to the Linux system.
    Format:
    message start | length of message | message type (8-11) | count
    Each typ of overflow has its own message type:

```c
#define MSG_LIN_RX_OF 8
#define MSG_LIN_TX_OF 9
#define MSG_TX_OF 10
#define MSG_RX_OF 11
```

### Status message

    All commands sent to the coprocessor, except listen which is no command, will return a status message.
    Format:
    message start | status
    status: One byte status, 0 status ok

```c
#define ERROR_ARGUMENT_COUNT 1
#define ERROR_START_NOT_VALID 2
#define ERROR_STOP_NOT_VALID 3
#define ERROR_START_AFTER_STOP 4
#define ERROR_SLOT_NOT_VALID 5
#define ERROR_NOT_VALID_ENTRY 6
#define ERROR_INVALID_LIN_ID 7
#define ERROR_TO_LONG_FRAME 8
```

### Sample application for sending frames and receiving responses in Linux

```c
#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <termios.h>

/* The application reads from arguments which kind of operation to perform and
 * all data associated with that operation. */

int main(int argc, char *argv[]) {
    int fd;
    int res;
    int fflags;
    char i;
    char msg_len;
    char listen;
    struct termios tio;
    char buff[255];

    fd = open("/dev/ttyHS2", O_RDWR | O_NOCTTY);
    if (fd < 0) {
        fprintf(stderr, "Error open tty\n");
        return -1;
    }

    tio.c_cflag = B115200 | CRTSCTS | CS8 | CLOCAL | CREAD;
    tio.c_iflag = IGNPAR;
    tio.c_oflag = 0;
    tio.c_lflag = 0;
    tio.c_cc[VTIME] = 0;

    tcflush(fd, TCIFLUSH);
    tcsetattr(fd, TCSANOW, &tio);

    buff[0] = 0x7E;
    buff[1] = 0x7E;
    buff[2] = 0x7E;
    buff[3] = 0xA7;

    listen = !strcmp(argv[1], "listen");

    if (!listen) {
        if (!strcmp(argv[1], "schedule")) {
            buff[5] = 2;
        }
        if (!strcmp(argv[1], "frame")) {
            buff[5] = 3;
        }
        if (!strcmp(argv[1], "item")) {
            buff[5] = 4;
        }
        if (!strcmp(argv[1], "baudrate")) {
            buff[5] = 5;
        }
        if (!strcmp(argv[1], "master")) {
            buff[5] = 6;
        }

        if (!buff[5]) {
            fprintf(stderr, "No valid command.\n");
            return 1;
        }

        for (i = 2; i < argc; i++) {
            sscanf(argv[i], "%d", &buff[4 + i]);
        }

        /* Checksum */
        msg_len = argc; /* Length of message is length of data + 1 for checksum */
        buff[4] = msg_len;
        for (i = 0; i < buff[4]; i++) {
            buff[4 + msg_len] ^= buff[4 + i];
        }

        write(fd, buff, 4 + 1 + msg_len); /* Bytes to send are: start of message bytes + length + (type, data, chksum) */

        sleep(1);
    }

    do {
        fflags = fcntl(fd, F_GETFL, 0);
        if (fflags < 0) {
            fprintf(stderr, "Could not get fd flags\n");
            return -1;
        }
        fcntl(fd, F_SETFL, fflags | O_NONBLOCK);

        res = read(fd, buff, 255);
        if (res > 0) {
            for (i = 0; i < res; i++) {
                printf("%x, ", buff[i]);
            }
            printf("\n");
        }
        usleep(10000);
    } while (listen);

    return 0;
}
```
#### Example of usage of application
```bash
# Setup frame 10 to send data to slaves using protocol 1 with 3 data bytes (1,
# 2, 3)
./lin_send frame 10 0 0 3 1 2 3
# Setup frame 16 to request a response from slaves using protocol 1 and expect
# 4 bytes long answer.
./lin_send frame 16 3 0 4
# Schedule created frames in slot 0 and 1, both using 60 ticks each and enable
# both.
./lin_send item 0 10 60 1
./lin_send item 1 16 60 1
# Enable the schedule to use items 0-1 start with item 0.
./lin_send schedule 0 1 0 1
# Start to listen for forwarded responses.
./lin_send listen
```