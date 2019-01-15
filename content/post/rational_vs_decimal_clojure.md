---
title: "Rationals vs Decimals in Clojure"
date: 2016-01-30T00:00:00+05:30
categories: ["Programming"]
tags: ["clojure"]
slug: rationals-vs-decimals-clojure
---

- Use rationals if accuracy is your main concern. For example, operations on
  decimals are not associative.

``` clojure
(let [a 1.0e50
      b -1.0e50
      c 17.0e00]
  (= (+ (+ a b) c) (+ a (+ b c)))) ; => false
```

From the above example, one can infer that decimals are subjected to Floating
Point corruption. You can find more examples [here](https://stackoverflow.com/questions/2100490/floating-point-inaccuracy-examples).

- Rationals are slower in terms of operations on them when compared to
  decimals. There is an overhead involved when doing operations on rationals.
