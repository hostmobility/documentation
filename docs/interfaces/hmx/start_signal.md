---
title:  Host Monitor x start signals
tags:
    - HMX
---

## Overview
5 start signals on diffrent connectors. 
1 to 4 is meant to be used to start the device and Start 5 is meant to be used with an external LED or an output for signal start.

To start the device the current signal time need to be at least 2-3 second long (in the future we might shorter the time) for the unit to startup and be able to hold the start signal internaly. 

The internal signal is also used for the cut off function and to shutdown the unit use
```
shutdown -h now
``` 
When the cut off is activated the unit is back to same state as it was when you pluged it in and will start again when any of the start signals goes high.

