---
title: "Using records in Clojure"
date: 2016-02-24T00:00:00+05:30
categories: ["programming"]
tags: ["clojure"]
slug: using-records-in-clojure
---

### When to use:

- Fixed set of keys in multiple map instances
- Defer until you have protocols

### Pros

- Created quickly
- Less memory overhead
- Key lookup performance same/faster when compared to equivalent hash-maps
- Can implement protocols
- Generated class has a type that can be used to dispatch methods using multimethod

### Cons

- Cannot be used as a function like hash-maps can
- Cannot be compared to an equivalent hash-map in terms of identity

Example:
``` clojure
(defrecord TreeNode [value left right])

(= (TreeNode. 2 nil nil) {:val 2 :left nil :right nil}) ;; => false
```

- No structural sharing when changing(redefining) a record

<br/><br/>
**tl;dr** *Stick to hash-maps until you have a specific requirement to use Records.*
