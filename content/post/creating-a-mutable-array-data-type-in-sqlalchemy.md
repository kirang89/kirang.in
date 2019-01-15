---
title: "Creating a Mutable Array data type in sqlalchemy"
date: 2014-08-09T00:00:00+05:30
categories: ["programming", "python"]
tags: ["python", "sqlalchemy"]
slug: creating-a-mutable-array-data-type-in-sqlalchemy
---

The problem with using the ARRAY datatype in sqlalchemy is that it's
immutable. This means it isn't possible to add new data into array once
it has been initialised. Unfortunately, I couldn't find any
good solution to create mutable arrays until I came across this snippet
by Michael Bayer, the author of sqlalchemy himself:

```python
from sqlalchemy.ext.mutable import Mutable
from sqlalchemy.dialects.postgresql import ARRAY

class MutableList(Mutable, list):
    def append(self, value):
        list.append(self, value)
        self.changed()

    @classmethod
    def coerce(cls, key, value):
        if not isinstance(value, MutableList):
            if isinstance(value, list):
                return MutableList(value)
            return Mutable.coerce(key, value)
        else:
            return value
```

What this snippet allows you to do is to extend a list to add mutability
to it. So, now you can use the class above to create a mutable array
type like so:

```python
from sqlalchemy.dialects.postgresql import ARRAY

class Something(Base):
    __tablename__ = 'yaddayadda'

    id = Column(Integer, primary_key=True)
    data = Column(MutableList.as_mutable(ARRAY(String(100))))
```
