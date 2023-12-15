---
title: CAN HMX
tags:
  - HMX
  - CAN
---

Host Monitor X has 6 CAN channels, typically named `can0` to `can5`

## HMX CAN performance tuning

The HMX platform has 4 of its 6 CAN interfaces on two SPI buses. Depending on
the use case, the interrupt handling CAN be tuned for performance or CPU load.

### Use Ethtool to limit the number of interrupts

Wait until 6 frames have been received or 1000 µs passed:
```bash
for i in 0 3 4 5; do 
    ethtool -C can${i} tx-usecs-irq 1000 rx-usecs-irq 1000 rx-frames-irq 6 tx-frames-irq 6
done
```

### Turn off DMA for SPI

   The driver uses DMA for transfers >64 bytes, but the DMA overhead is
   larger than the gain. As CAN-FD frames (metadata+date) are bigger
   than 64 bytes, DMA is used quite a lot. Disable DMA with:

```bash
echo N>/sys/module/spi_imx/parameters/use_dma
```

### Polling of transmit complete

If the driver doesn't use DMA, it uses PIO + transmit complete IRQ. The IRQ
also comes with a certain overhead, so polling might be cheaper. This
parameter sets the limit where polling is still used. The default is 30 µs.
This value depends on your hardware and can be tuned.

Set up a typical CAN bus load and measure the CPU usage with htop. Tweak the
polling limit with:

```bash
echo 50> /sys/module/spi_imx/parameters/polling_limit_us
```
