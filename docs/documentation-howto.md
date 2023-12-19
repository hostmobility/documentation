---
title: Writing Host Mobility product documentation
tags:
  - Contribute
---

This document describes how to write and publish [Host Mobility product documentation](https://hostmobility.github.io/documentation).

## Get the source

Clone the [documentation repo](git@github.com:hostmobility/documentation.git)
and create a working branch.

```bash
git clone git@github.com:hostmobility/documentation.git (push)
git checkout -b doc-work
```

## Install tools

Install [MkDocs](https://www.mkdocs.org/). Install it the first time after
cloning. Use a virtual environment (pip install virtualenv):

```bash
cd documentation
virtualenv venv
. venv/bin/activate
pip install -r requirements.txt
```

Activate the virtual enviroment if you have done the previous step before.

```bash
cd documentation
. venv/bin/activate
```

Use the built-in server
```bash
mkdocs serve
```
If you have trouble with `mkdocs serve`, edit `/etc/hosts`
```
192.168.128.54   anansi.setekgroup.local
```

[Preview](http://127.0.0.1:8000/documentation-howto) your changes.

## Edit the documentation

Edit the documentation using your preferred editor, e.g. `vim docs/documentation-howto.md` or `code docs/`.

[Editing details and setup](documentation-details.md)

### Style guide

- The MX-4 family contains the platforms T30, T30 FR, CT, CT GL, C61. Use this spelling and, to keep things short, skip the MX-4 prefix if possible.
- The other platforms are called MX-V and Host Monitor X (HMX). It is preferred to use the abbreviation HMX in this documentation.
- Titles and headings: Capitalize the first letter only, unless it contains a name such as Host Mobility.
- Use consistent spelling of standards such as [RS-485](https://en.wikipedia.org/wiki/RS-485). If in doubt, consult existing pages or Wikipedia.
- Do not line break paragraphs.
- Do not commit trailing whitespace.

### Tags

We use tags to group pages that are common to several platforms.

- Include all the tags that are valid for an article. For example, in the article "WiFi", add all the platforms that contain a WiFi chip (T30, T30 FR, etc. but not C61 and HMX).
- If an article is platform-specific, append the platform in parathesis, e.g. "Modem (HMX)".

## Deploy the documentation

```bash
mkdocs gh-deploy
```

The documentation is published on [hostmobility.github.io/documentation](https://hostmobility.github.io/documentation). It shall appear identically as on the local server.

