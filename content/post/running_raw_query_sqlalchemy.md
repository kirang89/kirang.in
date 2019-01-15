---
title: "Fetching data with a raw SQL query in SQLAlchemy"
date: 2015-11-22T00:00:00+05:30
categories: ["programming"]
tags: ["python", "sqlalchemy"]
slug: fetching-data-with-raw-sql-query-in-sqlalchemy
---

The following is a sane way of fetching data using a raw SQL query in
SQLAlchemy:

```python

query = 'select * from books where author=:author'

from sqlalchemy import text
result = yoursession.execute(text(query), {'author': 'Neil Degrasse Tyson'})

from collections import namedtuple
Book = namedtuple('Book', result.keys())

# Create a namedtuple for each row
books = [Record(*r) for r in res.fetchall()]

# Using namedtuple allows you to access attributes using the
# dot operator instead of relying on indexes
for book in books:
    print(book.name, book.author)

```
