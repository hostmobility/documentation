---
title: Writing Host Mobility Product Documentation
tags:
  - Contribute
---

This document describes how to write and publish [Host Mobility Product Documentation](https://hostmobility.github.io/documentation)

## Get the source

Clone the [documentation repo](git@github.com:hostmobility/documentation.git)
and create a working branch.

```bash
git clone git@github.com:hostmobility/documentation.git (push)
git checkout -b doc-work
```

## Install tools

Install [MkDocs](https://www.mkdocs.org/). Install it the first time after
cloning. Use a virtual environment(pip install virtualenv):

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
Trouble with `mkdocs serve` edit /etc/hosts
```
192.168.128.54   anansi.setekgroup.local
```

[Preview](http://127.0.0.1:8000/documentation-howto) your changes.

## Edit the documentation

Edit the documentation using your chosen editor e.g. `vim docs/documentation-howto.md` or `code docs/`

[Editing details and setup](documentation-details.md)

## Deploy the documentation

```bash
mkdocs gh-deploy
```

The documentation is published on [hostmobility.github.io/documentation](https://hostmobility.github.io/documentation). It shall appear identically as on the local server.

