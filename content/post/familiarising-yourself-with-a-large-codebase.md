---
title: "Familiarising yourself with a large codebase"
date: 2013-09-06T02:56:00+05:30
author: "Kiran Gangadharan"
categories: ["programming"]
tags: ["code", "open-source"]
slug: familiarising-yourself-with-a-large-codebase
---

I'm sure that a lot of developers find it harder to read existing code
and understand the ideals behind it, rather than writing it from
scratch, themselves. I too have this same problem, and so started
looking around online as to how people have dealt with it. I've compiled
some good answers from various sources, below:

-   Try and understand at a high level, what the purpose of the code is, and then identify the key elements/functions that help achieve this purpose
-   Try to read as much design and documentation about the project
    before diving in
-   Try and figure out the relations between various components and then
    draw/visualise an architecture diagram
-   Talk to authors and clarify things with them beforehand
-   Go through unit tests to get a high level overview
-   Start with the entry point in the program. This will in turn point
    to what gets started and sometimes how things are linked.
-   Make small edits or bug fixes, then gradually build up
-   Keep notes. Don't jump in and start developing; it's more valuable
    to spend time understanding than to generate messy or inappropriate
    code.

Hope you find success after following the above tips :)
