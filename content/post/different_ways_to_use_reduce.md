---
title: "Different applications of reduce in Clojure"
date: 2015-11-15T00:00:00+05:30
categories: ["Programming"]
tags: ["clojure"]
slug: different-applications-of-reduce-in-clojure
---

I've just started learning Clojure using
[Clojure for the Brave and True](http://www.braveclojure.com/) and solving
problems on [4Clojure](https://www.4clojure.com/). While doing so, I've noticed
that a lot of problems that seem tricky can be quickly solved using ```clojure.core/reduce```.

This post is an effort to document some snippets to demonstrate how useful ```reduce``` can be.

### Reverse a collection<a id="sec-1" name="sec-1"></a>

```clojure
(defn myreverse [coll]
  (reduce conj '() coll))

(myreverse '(1 2 3 4))

;; (4 3 2 1)

```

### Find frequency of words in a string<a id="sec-2" name="sec-2"></a>

```clojure
(defn freq [str]
  (reduce #(assoc %1 %2 (inc (%1 %2 0)))
          {}
          (clojure.string/split str #"\s")))

(freq "Hey there! I am the hey man! I like to hey the people")

;; {"like" 1, "people" 1, "man!" 1, "am" 1, "Hey" 1,
;;  "hey" 2, "there!" 1, "I" 2, "to" 1, "the" 2}

```

### Transform all values in a map<a id="sec-3" name="sec-3"></a>

```clojure
(reduce (fn [new-map [key val]]
          (assoc new-map key (inc val)))
        {}
        {:lat 50.23 :lng 24.21})

;; {:lat 51.23, :lng 25.21}

```

### Using reduce to filter out values in map<a id="sec-4" name="sec-4"></a>

```clojure
(reduce (fn [new-map [key val]]
          (if (> val 3)
            (assoc new-map key val)
            new-map))
        {}
        {:a 2 :b 4 :c 3 :d -1 :e 9 :f 23})

;; {:b 4, :e 9, :f 23}

```
### Implementing a mapping function<a id="sec-5" name="sec-5"></a>

```clojure
(defn mapr [f coll]
  (reverse (reduce (fn [new-seq elem]
            (conj new-seq (f elem)))
          (list) coll)))

(mapr (fn [x] (* x 2)) [1 2 3 4])

;; (2 4 6 8)

```

### Sort list of list based on sum of elements<a id="sec-6" name="sec-6"></a>

```clojure
(sort-by #(reduce + %) ['(8 8 7) '(1 2 3) '(6 5 7)])

;; ((1 2 3) (6 5 7) (8 8 7))

```
### Generate Fibonacci series<a id="sec-7" name="sec-7"></a>

```clojure

;; Generate first 10 fibonacci numbers

(reduce
  (fn [a b]
    (conj a (+ (last a) (last (butlast a)))))
  [0 1]
  (range 8))

;; [0 1 1 2 3 5 8 13 21]

```

### Finding factorial

```clojure
(defn factorial [n]
  (reduce * (range 1 (inc n))))
```

### Implementing comp

```clojure
(fn [& fs]
  (fn [& xs]
    (first (reduce #(vector (apply %2 %1)) xs (reverse fs)))))
```
