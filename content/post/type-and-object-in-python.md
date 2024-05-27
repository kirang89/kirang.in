---
title: "Type and Object in Python"
date: 2013-05-22T01:59:00+05:30
author: "Kiran Gangadharan"
categories: ["programming"]
tags: ["programming", "python"]
slug: type-and-object-in-python
---

Recently I stumbled across an article talking about the importance of
understanding type and object in Python, so thought of writing a small
post on it.

<!--more-->

Looking in-depth, one may get the impression that this is more of a
chicked-egg problem, but I’ll give an overall view of this.

-   An `object` is basically an instance of `type`
-   `type` is an instance of `type` itself
-   `object` is the subclass of all other objects
-   A `type` is an instance of `object` itself

So in a way, you have only two objects in Python, types and non-types.

<div class="note">
<label>Note:</label>
<div><code>type</code>can also be called <code>class</code> from Python >= 2.3</div>
</div>

Well there you go. It wasn’t confusing now, was it ? :)
