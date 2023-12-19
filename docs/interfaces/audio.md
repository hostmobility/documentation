---
title: Audio
tags:
  - Audio
  - T30
  - T30 FR
  - CT
  - CT GL
  - C61
  - MX-V
---
## Overview

Many of our platforms feature audio output and microphone input at the operating system level and, in some cases, via the on-board modem. To see if modem audio is supported, please consult the platform-specific [modem](modem.md) pages.

On the Linux side we use standard [ALSA](https://www.alsa-project.org).

### T30 FR and T30
This product comes with one 3.5 stereo phone jack with analog stereo audio out and one 3.5 stereo phone jack with mono in (microphone) interface.
See technical specification for more information regarding the connectors.

### CT and CT GL
This product comes with a JAE IL-AG5-14P-D3L2 with analog stereo audio out and with mono in (microphone) interface.
See technical specification for more information regarding the connectors.

### MX-V
This product comes with a 2x34PIN MINI50 2-BAY 90DEG PIN HEADER with analog stereo audio out and a mono in (microphone) interface. It's also possible to use HDMI audio from the DVI connector. See the technical specification for more information regarding the connectors.

### C61
This product comes with one 2.5 stereo phone jack with analog stereo audio out and with mono in (microphone) interface. See the technical specification for more information regarding the connectors.

**Note:** This feature is currently untested for modern BSPs.

## Examples

* Example on how to create a loop back (activate mic and hear yourself)
```bash
arecord -d 5 -D plughw:1 -f dat output.wav & sleep 1 && aplay -D plughw:1 output.wav & echo recording and audio output
```

* Test audio with a sinus tone at 997Hz.
```bash
speaker-test -D plughw:1 -t sine -r 997 -c 1 -l 2

speaker-test -D plughw:1,0 -t sine -r 997 -c 1 -l 2
```

* list devices with `aplay -L` or `aplay --list-devices` (example from MX-V)
```bash
card 0: imxhdmisoc [imx-hdmi-soc], device 0: i.MX HDMI Audio Tx i2s-hifi-0 []
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 1: Audiotlv320aic3 [Audio-tlv320aic310x], device 0: 2028000.ssi-tlv320aic3x-hifi tlv320aic3x-hifi-0 []
  Subdevices: 1/1
  Subdevice #0: subdevice #0

```

## For Linux 3.1 system

**Note:** for BSP release 1.6/1.5 and older

To direct line-in to line-out:

```bash
amixer -c 2 set 'Left HP Mixer Line Bypass' on
amixer -c 2 set 'Right HP Mixer Line Bypass' on
```

Playback HDMI:

```bash
aplay -D 'default:CARD=tegra' bach.au
```

Playback:

```bash
amixer -c 2 set 'Headphone' 8 on
amixer -c 2 set 'Left HP Mixer PCM' on
amixer -c 2 set 'Right HP Mixer PCM' on
aplay -D 'default:CARD=T20' output2.wav
```

Record from line-in:

```bash
amixer -c 2 set 'Left Capture Select' 'Line'
amixer -c 2 set 'Right Capture Select' 'Line'
amixer -c 2 set 'Capture ADC' on
arecord -D 'default:CARD=T20' -v -f cd output2.wav
```

Record from mic:

```bash
amixer -c 2 set 'Left Capture Select' 'Mic'
amixer -c 2 set 'Right Capture Select' 'Mic'
amixer -c 2 set 'Capture ADC' on
amixer -c 2 set 'Left HP Mixer Mic Sidetone' on
amixer -c 2 set 'Right HP Mixer Mic Sidetone' on
arecord -D 'default:CARD=T20' -v -f cd output2.wav
```

Please note that the two numbers at the end specify which ALSA card and device to use for audio (e.g. alsasink device=hw:1,0 for SPDIF through HDMI and alsasink device=hw:2,0 for WM9715L AC97 through headphone).

```bash
aplay -L
null
    Discard all samples (playback) or generate zero samples (capture)
default:CARD=tegra // HDMI
    tegra,
    Default Audio Device
default:CARD=T20 // AC97
    Toradex Colibri T20,
    Default Audio Device
```