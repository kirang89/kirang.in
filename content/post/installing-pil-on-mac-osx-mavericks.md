---
title: "Installing PIL on Mac OSX Mavericks"
date: 2013-12-09T12:13:00+05:30
author: "Kiran Gangadharan"
category: ["programming"]
tags: ["osx", "python"]
slug: installing-pil-on-mac-osx-mavericks
---

If you've probably tried installing [PIL(Python Imaging
Library)](http://en.wikipedia.org/wiki/Python_Imaging_Library) on OSX
Mavericks(version 10.9), you're likely to have failed in doing so. After
searching for a while, I found the solution that worked for me.

<!--more-->

Before you install PIL, you need to first ensure that your
[Xcode](http://en.wikipedia.org/wiki/Xcode) Commandline tools are up to
date. Just run the following command in your terminal:

```bash
xcode-select --install
```

This might take a while, based on your connection. Once done, you can
now install PIL by running:

```bash
pip install pil
```

You can also install pil directly from
[here](http://www.pythonware.com/products/pil/).
