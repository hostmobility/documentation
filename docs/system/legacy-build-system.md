---
title: Legacy build system
tags:
  - Development
  - MX-4
  - CT
  - CT GL
  - T30
  - T30 FR
  - C61
---

## Overview

To build, see the old [mx4](https://github.com/hostmobility/mx4) repo.

## Build environment

Before building, we recommend having
- approximately 30 GB of free disk space,
- an SSD (it will make the build process go faster),
- at least 4 GB of RAM,
- at least 4 CPU cores (2 cores is a minimum).

### Set up docker

Install Docker: [Docker Install] <br />
Create Dockerfile: touch Dockerfile <br />
Copy this template into the Dockerfile and edit it:

```dockerfile
FROM debian
# Edit Your Name and ”your@mail.com”
MAINTAINER <b>Your Name</b> "<b>your@mail.com</b>"
# Edit your username
ARG user=<b>your username</b>
# Edit your group, mostly the same as username
ARG group=<b>your group</b> 
# Edit your user id. Command to see user id, id -u $username
ARG uid=<b>your user id</b>
# Edit your group id. Command to see group id, id -g $username
ARG gid=<b>your group id</b>

# We need to change to root to be able to install with apt-get 
USER root
RUN apt-get update && apt-get install -y gawk wget git-core sudo cpio \
diffstat unzip texinfo gcc-multilib u-boot-tools rsync cbootimage bc \
build-essential kmod chrpath socat mtd-utils device-tree-compiler mtools \
lzop dosfstools parted libncurses5-dev patchutils tmux vim curl python \
libsdl1.2-dev && rm -rf /var/lib/apt/lists/*

ENV USER_HOME /home/${user}

RUN groupadd -g ${gid} ${group} \
&& useradd -d "$USER_HOME" -u ${uid} -g ${gid} -m -s /bin/bash ${user}
# Edit username to your username
RUN adduser <b>username</b> sudo
# Edit username to your username
RUN echo "<b>username</b> ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Switch to user
USER ${user}
WORKDIR ${USER_HOME}

# Creates project folder. Returns no error if folder already exists
RUN mkdir -p <b>project</b>

# Edit "your@mail.com"
RUN git config --global user.email "<b>your@mail.com</b>"
# Edit "Your Name"
RUN git config --global user.name "<b>Your Name</b>"
RUN git config --global push.default simple
```

#### Build Docker image

Build the docker image using the Dockerfile and name it hostmobility/mx4
```dockerfile
docker build -t hostmobility/mx4 .
```

#### Run Docker image

```bash
# Edit user id 1000 with your user id. 
# Edit username with your username (both in ssh- and project path).
# Edit path to the project /home/username/project if needed.
# The project folder is the link between your environment and the Docker environment.
# Everything you put in the project folder from the Docker will be accessible outside the Docker.
# To make --privileged to work, it assumes that you have a SSH key associated with your github account.
# If SSH key is not set up correctly, you will be asked for username and password during the git clone process.
sudo docker run -it -u <b>1000</b> --privileged -v ~/.ssh:/home/<b>username</b>/.ssh -v ~/project:/home/<b>username</b>/<b>project</b> hostmobility/mx4
```

### Example of how to set up an environment for MX-4 CT, branch BSP-v1.5.x

#### Git clone from repository

```bash
# If SSH key is associated correctly with your GitHub account, run the following commands:
git clone git@github.com:hostmobility/mx4 -b mx4-bsp-v1.5.x
git clone git@github.com:hostmobility/mx4-pic -b mx4-bsp-v1.5.x mx4/pic
# If not correctly associated, run follow commands:
git clone https://github.com/hostmobility/mx4/ -b mx4-bsp-v1.5.x
git clone https://github.com/hostmobility/mx4-pic -b mx4-bsp-v1.5.x mx4/pic
```
#### Build CT-BSP-v1.5.x

```bash
cd mx4/t20
# Remember to edit username to your own username and project if you
# named your project folder to something else.
# edit $(nproc) to number of cores you want to use while building.
./make_system.sh -t ct -r /home/<b>username</b>/<b>project</b>/rootfs/CT -d /home/<b>username</b>/<b>project</b>/yocto-1.5.x -g -k -u -j <b>$(nproc)</b> -m -T 512
```

### Building other platforms

Please consult [mx4#source-structure](https://github.com/hostmobility/mx4#source-structure) for the required repositories and branch names. 

### GTT v1.5.x

```bash
git clone https://github.com/hostmobility/mx4/ -b mx4-bsp-v1.5.x
git clone https://github.com/hostmobility/mx4-pic -b mx4-bsp-v1.5.x mx4/pic
./make_system.sh -t gtt -r <b>UNIQUE_ROOTFS_PATH</b> -d <b>YOCTO_1.5.x_TEMP_PATH</b> -g -k -u -j <b>$(nproc)</b> -m -T 512
```

### GTT-T30 v1.4.x

```bash
git clone https://github.com/hostmobility/mx4/ -b mx4-bsp-v1.4.x-ultra
git clone https://github.com/hostmobility/mx4-pic -b mx4-bsp-v1.4.x mx4/pic
git clone https://github.com/hostmobility/linux-toradex.git -b mx4-bsp-v1.4.x-tegra mx4/t20/linux_vf
git clone https://github.com/hostmobility/u-boot-toradex.git -b mx4-bsp-v1.4.x mx4/t20/u-boot_vf
./make_system.sh -t t30 -r UNIQUE_ROOTFS_PATH -d YOCTO_1.4.x_TEMP_PATH -g -k -u -j $(nproc)
```

### Example to setup environment for MX-4 V61
```bash
# All products use mx4 and mx4-pic repository
git clone git@github.com:hostmobility/mx4 -b mx4-2.0
git clone git@github.com:hostmobility/mx4-pic -b mx4-2.0 mx4/pic


# Below are only required for products that have Linux and U-boot
# outside of the mx4 repository
git clone git@github.com:hostmobility/linux-toradex.git -b hm_vf_4.4 mx4/t20/linux_vf
git clone git@github.com:hostmobility/u-boot-toradex.git -b 2015.04-hm mx4/t20/u-boot_vf
```

### Example of how to build Board Support Package (BSP) for MX-4 V61

```bash
cd mx4/t20
# edit $(nproc) to number of cores you want to use while building.
[work in progress]
./make_system.sh -t v61 -r /home/username/project/rootfs/v61 -d /home/username/project/ -u -k -j $(nproc) -g
```

See the [List of supported distros](http://www.yoctoproject.org/docs/1.4.1/ref-manual/ref-manual.html#detailed-supported-distros).

The following packages need to be installed (the example below is for Ubuntu 14.10).
```
sudo apt-get install subversion git u-boot-tools cbootimage curl gawk wget \
git-core diffstat unzip texinfo build-essential chrpath autoconf flex bison \
device-tree-compiler mtd-utils lzop
```