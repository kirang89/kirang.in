Title: Type and Object in Python
Date: 2013-05-22 01:59
Author: admin
Category: Programming, Python
Tags: object, programming, python, type
Slug: type-and-object-in-python

Recently I stumbled across an article talking about the importance of
understanding type and object in Python, so thought of writing a small
post on it.

<!--more-->

Looking indepth, one may get the impression that this is more of a
chicked-egg problem, but I’ll give an overall view of this.

-   An `object` is basically an instance of `type`
-   `type` is an instance of `type` itself
-   `object` is the subclass of all other objects
-   A `type` is an instance of `object` itself

So in a way, you have only two objects in Python, types and non-types.

**Note**: `type` can also be called `class` from Python \>= 2.3

Well there you go. It wasn’t confusing now, was it ? :)

