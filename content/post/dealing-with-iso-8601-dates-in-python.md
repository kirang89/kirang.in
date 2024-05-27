---
title: "Dealing with ISO 8601 dates in Python"
date: 2014-04-10T17:55:00+05:30
author: "Kiran Gangadharan"
category: ["programming"]
tags: ["python"]
slug: dealing-with-iso-8601-dates-in-python
---

For those who don't know what the ISO 8601 format is, you can read about
it [here](https://en.wikipedia.org/wiki/ISO_8601).<!--more-->

To create an ISO 8601 timestamp in Python, do:

```python
>>> from datetime import datetime
>>> timestamp = datetime.utcnow().isoformat() + 'Z'
'2014-04-01T15:11:18.195125Z'
```

The ' Z ' added to the timestamp indicates that the timezone is
[UTC](https://en.wikipedia.org/wiki/Coordinated_Universal_Time).

To parse a ISO 8601 timestamp and generate a <span
class="lang:default decode:true crayon-inline">datetime</span>  object,
do:

```python
>>> import dateutil.parser as dp
>>> a = dp.parse(timestamp)
>>> a
datetime.datetime(2014, 4, 1, 15, 11, 46, 113800, tzinfo=tzutc())
```

Alternatively, you could also generate the object using:

```python

>>> datetime.strptime(timestamp, '%Y-%m-%dT%H:%M:%S.%fZ')
datetime.datetime(2014, 4, 1, 15, 11, 46, 113800)
```
