---
title: "Concurrent Prime Sieve in Clojure"
date: 2015-12-28T00:00:00+05:30
categories: ["programming", "clojure"]
tags: ["programming", "clojure"]
slug: concurrent-prime-sieve-in-clojure
---

While watching the
[Go Concurrency Patterns talk](https://www.youtube.com/watch?v=f6kdp27TYZs) by
Rob Pike, I came across a
[Concurrent Prime Sieve implementation in Go](http://tinyurl.com/gosieve) which
Rob had claimed to be beautiful concurrent code. Curious enough, I checked out
the example and decided on implementing it in Clojure.

Let's begin by creating an infinite sequence generator(starting from 2):
```clojure
(defn num-generator [out]
  (go
    (loop [n 2]
      (>!! out n)
      (recur (inc n)))))
```

The ```go``` block ensures that the body is run on a seperate thread. I used the
blocking put instead of the parking one to only generate a number when required
by the program. Had I used the parking put ```>!``` instead, we would've encountered
the ```OutOfMemory``` exception while executing the function.

Let's test this generator:
```clojure
(def ichan (chan))
; Blocks at the put statement, waiting for a read
(num-generator ichan)

(<!! ichan)  ; => 2
(<!! ichan)  ; => 3
(<!! ichan)  ; => 4
```
Not the best way to test of course, but it seems to work as expected.

Next, let's write a filter function that takes an input channel, an output
channel and a value, and filters out the non-prime numbers from the input
channel before sending them to the output channel. This is what the "**prime
sieve**" refers to.

```clojure
(defn filter-prime [in out val]
  (go
    (loop [n 0]
      (let [i (<!! in)]
        (when (not (= (mod i val) 0))
          (>!! out i)))
      (recur (inc n)))))
```

Before testing ```filter-prime```, let's tie the above two functions together
with the user input using ```fetch-prime```:

```clojure
(defn fetch-prime [count]
  (let [ch (chan)]
    (num-generator ch)
    (loop [n count
           c ch]
      (when (> n 0)
        (let [p (<!! c)
              ch1 (chan)]
          ;; Just printing the prime nos for now
          (println "Prime => " p)
          (filter-prime c ch1 p)
          (recur (dec n) ch1))))
    (close! ch)))
```

And, finally test to see if it works:

```clojure
(fetch-prime 6)
; Prime => 2
; Prime => 3
; Prime => 5
; Prime => 7
; Prime => 11
; Prime => 13
```

The whole process can be visualised as a bunch of sieves lined up on top of each
other vertically with the numbers from the generator passing through
them. Essentially, each sieve is a ```filter-prime``` with the last prime
```val``` passed as it's parameter. At any pass, if the modulus value is zero,
the number (retrieved from the generator) in that pass is discarded.

Though this took me a bit of head banging, in the end, I got a much better
picture of the concurreny model using go blocks in Clojure. The way in which
different threads communicate with each other as a Daisy Chain filter to remove
the non-primes makes this a neat example for demonstrating concurrency.
