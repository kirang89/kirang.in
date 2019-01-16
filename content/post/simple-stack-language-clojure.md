---
title: "Creating a simple stack-based language in Clojure"
date: 2016-04-04T00:00:00+05:30
categories: ["programming"]
tags: ["clojure"]
slug: creating-a-simple-stack-based-language-in-clojure
---

Let's look at how to build a simple stack-based language in Clojure. First, this
is how the input would look like:

    push 8
    push 4
    +
    push 3
    *

This would be equivalent to (in infix notation):

    (8 + 4) * 3

Here is a simple parser-cum-evaluator for the above input:

``` clojure
(defn parse-eval [string stack]
  "Parse and Evaluate the line sent and push result to stack if necessary."
  (let [cmd (clojure.string/split string #" ")
        fname (first cmd)
        arg (second cmd)
        digit? #(Character/isDigit (first %))
        op? #(some (fn [x] (= x %)) ["+" "-" "*" "/"])
        make-fn #(resolve (symbol %))]
    (if (and (nil? arg) (op? fname))
      ;; If operator, apply it to arguments in stack
      (conj (drop 2 stack) (apply (make-fn fname) (take 2 stack)))
      (if (and (= (keyword fname) :push) (digit? arg))
        ;; If push command, add value to stack
        (conj stack (Integer/parseInt arg))
        (throw (Exception. "Error while parsing"))))))
```

Now we need to read the program mentioned above from a file and send it to the above
function:

``` clojure
(defn read-prog [filename]
  (let [data (slurp filename)]
    (loop [lines (clojure.string/split-lines data) stack []]
      (if (empty? lines)
        stack
        (recur (rest lines) (reader (first lines) stack))))))
```

This returns the stack containing the result of the expression.
