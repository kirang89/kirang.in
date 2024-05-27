---
title: "Writing good Classes in Python"
date: 2013-12-02T08:38:00+05:30
author: "Kiran Gangadharan"
categories: ["programming"]
tags: ["python"]
slug: writing-good-classes-in-python
---

This post is the highlight of Raymond Hettinger's talk "[Python's Class
Development
Toolkit](http://pyvideo.org/video/1779/pythons-class-development-toolkit)"
at PyCon US 2013.

Things to keep in mind while writing Classes:

-   Inherit from ```object()```
-   Instance variables for information unique to an instance
-   Class variables for data shared among all instances
-   Regular methods need self to operate on instance data
-   Class methods implement alternative constructors. They need ```cls``` so
    they can create subclass instances as well
-   Static methods attach functions to classes. They don't need
    either ```self``` or  ```cls```. Static
    methods improve discoverability and require context to be specified.
-   A ```property()``` lets
    getter and setter methods be invoked automatically by attribute
    access. This allows Python Classes to expose their instance
    variables freely.
-   The ```__slots__``` variable
    implements Flyweight Design Pattern by supressing instance
    dictionaries.
-   Use ```__perimeter```
    to preserve namespace when subclassing. The underlying variable name
    changes based on the caller.

This is an example with all the above practices implemented:

```python
import math

class GoodCircle(object):
    '''This represents the circle class'''

    __slots__ = ['diameter']        # Last Resort for memory efficiency
    version = '0.1'

    def __init__(self, radius):
        self.radius = radius

    @classmethod
    def from_bbd(cls, bbd):
        'Construct a Circle from bounding box diagonal'
        radius = bbd / 2.0 / math.sqrt(2.0)
        return cls(radius)

    @property
    def radius(self):
        return self.diameter / 2.0

    @radius.setter
    def radius(self, radius):
        self.diameter = radius * 2.0

    @staticmethod
    def angle_to_grade(angle):
        'Convert angle in degree to percentage degree'
        return math.tan(math.radians(angle)) * 100.0

    def area(self):
        p = self.__perimeter()
        r = p / math.pi / 2.0
        return math.pi * r ** 2.0

    def perimeter(self):
        return 2.0 * math.pi * self.radius

    __perimeter = perimeter
```

 
