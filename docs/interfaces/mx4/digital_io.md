---
title:  Mx4 Digital I/O
tags:
    - T30
    - T30 FR
    - MX-4
    - CT
    - CT GL
    - C61
---
## Overview 
Diffrent platform support diffrent amount of this list check the technical documentation to find the supported IOs.

### List of IO
- digital-out-1-source
- digital-out-2-source
- digital-out-3-source
- digital-out-4-source
- digital-out-5-source
- digital-out-6-sink 
- digital-out-7-sink 
- digital-out-1-sink 
- digital-out-2-sink 
- digital-out-3-sink 
- digital-out-4-sink 
- digital-out-5-sink 
- digital-out-6-source
- digital-out-7-source
- digital-out-1
    - depricated with digital out source 1
- digital-out-2
    - depricated with digital out source 2
- digital-out-3
    - depricated with digital out source 3
- digital-out-4
    - depricated with digital out source 4
- digital-out-5 / 4-20
    - depricated with digital out source 5
- digital-out-6
    - depricated with digital out sink 6
- digital-in-1 / sc
- digital-in-2 / sc
- digital-in-3 / sc
- digital-in-4 / sc
- digital-in-5 / sc
- digital-in-6
- digital-in-7
- digital-in-8
- digital-out-7
    - depricated with digital out sink 7
- digital-out-8
    - depricated with digital out source 7
- digital-out-en 
    - Only CT and CT GL

### Set Digital out 
```bash
gpioset $(gpiofind digital-out-1)=1
```

### Set Digital in
```bash
gpioget $(gpiofind digital-in-1)
```

## Systems without gpiolib

**Note:** for bsp release 1.6(1.5) and older

For digital I/O we use the standard linux framework.

See [Linux Kernel GPIO documentation](https://www.kernel.org/doc/Documentation/gpio/)

**Note:** GPIO numbers can differ on different MX-4 platforms. This is just an example.

```bash
root@mx4-t30-29009999:~# cat /sys/kernel/debug/gpio | grep -i digital
GPIOs 344-383, spi/spi0.0, mx4_digitals:
 gpio-344 (digital-out-1       ) out lo
 gpio-345 (digital-out-2       ) out lo
 gpio-346 (digital-out-3       ) out lo
 gpio-347 (digital-out-4       ) out lo
 gpio-348 (digital-out-5 / 4-20) out lo
 gpio-349 (digital-out-6       ) out lo
 gpio-356 (digital-in-1 / sc   ) in  hi
 gpio-357 (digital-in-2 / sc   ) in  hi
 gpio-358 (digital-in-3 / sc   ) in  hi
 gpio-359 (digital-in-4 / sc   ) in  hi
 gpio-360 (digital-in-5 / sc   ) in  lo
 gpio-361 (digital-in-6        ) in  lo
 gpio-380 (digital-in-7        ) in  lo
 gpio-381 (digital-in-8        ) in  lo
 gpio-382 (digital-out-7       ) out lo
 gpio-383 (digital-out-8       ) out lo
```

`sc digital out` are inputs indicating short for each output. If a short is detected it goes HIGH (1).

#### Read gpio value

```bash
# Example reading status from Digital-In-2. 0 = LOW, 1 = HIGH
root@mx4-gtt:~# cat /sys/class/gpio/gpio23/value
0
```

#### Write gpio value

```bash
# Example setting Digital-Out-1 high
root@mx4-gtt:~# echo 1 > /sys/class/gpio/gpio238/value
```

#### Set input as interrupt

All digital inputs can generate an "event" on a specific change. The changes are "rising", "falling" or "both"

```bash
# Trigger an event on rising edge.
root@mx4-gtt:~# echo rising > /sys/class/gpio/gpio23/edge
```

It is also possible to set falling or both to edge file.

To listen for event you need to run `poll(2) <http://man7.org/linux/man-pages/man2/poll.2.html>`_ on the "value" file of that specific input. See `example application <https://github.com/hostmobility/file-poll>`_

#### Example app listening for GPIO events.
```c
	#include <stdio.h>
	#include <fcntl.h>
	#include <poll.h>

	int main (int argc, char *argv[])
	{
		char* path;
		struct pollfd fds;
		int ret;

		if (argc != 2){
			printf("The file descriptor to listen is needed as first (and only) parameter\n");
			return 1;
		}

		path = argv[1];

		fds.fd = open (path, O_RDONLY);

		if (!fds.fd){
			printf("Unable to open file descriptor\n");
			return 1;
		}

		fds.events = POLLERR | POLLPRI;
		fds.revents = 0;
		printf ("listening for events in:%s\n", path);

		char val;

		while (1){
			read (fds.fd, 0, 0);
			if (poll (&fds, 1, -1) > 0) {
				printf ("event received\n");
			}
		}

		printf ("Finish\n");
		return 0;
	}
```