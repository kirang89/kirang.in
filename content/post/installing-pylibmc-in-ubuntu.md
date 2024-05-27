---
title: "Installing pylibmc in ubuntu"
date: 2013-05-22T02:16:00+05:30
author: "Kiran Gangadharan"
category: ["programming"]
tags: ["python", "ubuntu"]
slug: installing-pylibmc-in-ubuntu
---

Before you install Pylibmc on your machine, there are a few dependencies
that you need to take care of, so as to ensure a successful
installation.

Install python-dev

```Bash
sudo apt-get install python-dev
```

Install libmemcached

```Bash
sudo apt-get install libmemcached-dev
```

Now you can successfully install pylibmc using pip

```Bash
sudo pip install pylibmc
```
