---
title: Yocto Build (Manually)
tags:
  - Development
  - HMX
  - MX-4
  - CT
  - CT GL
  - MX-V
  - T30
  - T30 FR
  - C61
---

## Regular Host Mobility Yocto/OE-core setup

To simplify installation we provide a [repo](http://code.google.com/p/git-repo) manifest which manages the different git repositories
and the versions used.

Before proceeding, please take a look at [The Build Host Packages](http://www.yoctoproject.org/docs/2.3/mega-manual/mega-manual.html#packages) in the Yocto Manual.

Install the repo bootstrap binary:

```
sudo apt-get install repo
```

or

```
mkdir ~/bin
PATH=~/bin:$PATH
curl http://commondatastorage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
chmod a+x ~/bin/repo
```

Create a directory for your `mobility-bsp-platform` setup to live in and clone the meta information.
```
mkdir mobility-bsp-platform
cd mobility-bsp-platform
repo init -u https://github.com/hostmobility/mobility-poky-platform -b master
repo init -m kirkstone-next.xml
repo sync --force-sync
```

Set up environment variables:
```bash
export DIR_WORK=$PWD/../
export BUILD_TAG=*optional build Tag*
export PLATFORM_VERSION="$(git -C $DIR_WORK.repo/manifests rev-parse --short HEAD)"
export PLATFORM_VERSION_DETAILS="$(repo forall -c 'echo $REPO_PATH\nLREV: $REPO_LREV\nRREV: $REPO_RREV; git diff --stat -b $REPO_LREV..HEAD ; echo -n "Commit: " ; git rev-parse HEAD ; echo -n "Uncommited changes: " ; git status -b -s ; git diff --stat -b ; echo ')"
echo "building with repo versions: $PLATFORM_VERSION"
export BB_ENV_PASSTHROUGH_ADDITIONS="$BB_ENV_PASSTHROUGH_ADDITIONS BUILD_TAG PLATFORM_VERSION PLATFORM_VERSION_DETAILS"
export TEMPLATECONF=$PWD/../sources/meta-mobility-poky-distro/conf
```
**NOTE!** You will need to perform these exports for each new session. If you already have
a build directory, it will be untouched and only the environment variables will be set.

Start baking!
```
$ source sources/poky/oe-init-build-env build;
$ bitbake {image}
```

where `{image}` is replaced by, for example, `console-mobility-image`, `bitbake mobility-image` or `mobility-image-chromium`.

The build result will end up in the `mobility-bsp-platform/build/tmp/deploy/images/` directory.



