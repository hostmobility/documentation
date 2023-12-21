---
title: Software development
tags:
  - Development
  - HMX
  - MX-4
  - CT
  - MX-V
  - T30
  - T30 FR
  - C61
---

## Overview

Host Mobility computers run GNU/Linux where almost all software is built from source. The target architectures are ARM32 and ARM64. Since the typical development machines are x86_64, a cross-compiler is usually required.

## Software development kit (SDK)

Contain the toolchains needed to compile and debug applications for our systems.
To know more about how to build it See [Software Development Kits (SDKs)](sdk/sdk.md). And for older system running bsp 1.5/1.6 or older See [Legacy Software Development Kits (SDKs)](sdk/sdk.md)


## Yocto build system

The reference operating system is built using Yocto. It combines software written by Host Mobility with free software from developers all over the world. See [Yocto Build System](yocto/yocto.md) for details.

And for older system running bsp 1.5/1.6 or older See [Legacy build system](legacy-build-system.md)

