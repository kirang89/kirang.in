---
title: "Implementing Norvig's Spelling Corrector in Clojure"
date: 2016-02-03T00:00:00+05:30
categories: ["programming"]
tags: ["clojure"]
slug: implementing-norvigs-spelling-corrector-in-clojure
---

I wanted to try something small in Clojure as an exercise, and so I decided to
implement [Norvig's spelling corrector](http://norvig.com/spell-correct.html)
(which is an elegant Python implementation btw). Being a clojure newbie, it was a bit frustating to
figure out an idiomatic solution, but I think I've managed a decent
implementation. It was fun! :)

```clojure

(def alphabets "abcdefghijklmnopqrstuvwxyz")

(defn words [text] (re-seq #"[a-zA-Z]+" text))

(defn train [features]
  (reduce (fn [model word]
            (let [lword (clojure.string/lower-case word)
                  value (get model lword 1)]
              (assoc model lword (+ 1 value)))) {} features))

(def nwords (train (words (slurp "data.txt"))))

;; splits
(defn get-splits [word] (map #(conj [] (subs word 0 %) (subs word %)) (range (inc (count word)))))

;; deletes
(defn get-deletes [coll]
  (map (fn [[p1 p2]] (apply str (concat p1 (rest p2)))) coll))

;; transposes
(defn get-transposes [coll]
  (map (fn [[p1 p2]] (apply str (concat p1 (str (second p2)) (str (first p2)) (drop 2 p2)))) coll))

;; replaces
(defn get-replaces [coll]
  (flatten (map (fn [[p1 p2]] (map #(apply str (concat p1 (str %) (rest p2))) alphabets)) coll)))

;; inserts
(defn get-inserts [coll]
  (flatten (map (fn [[p1 p2]] (map #(apply str (concat p1 (str %) p2)) alphabets)) coll)))

(defn edits1 [word]
  (let [coll (get-splits word)]
    (distinct (concat (get-deletes coll)
                      (get-transposes coll)
                      (get-replaces coll)
                      (get-inserts coll)))))

(defn known-edits2 [word]
  (distinct
   (flatten
    (map (fn [e1w] (reduce #(if (contains? nwords %2) (conj % %2) %) [] (edits1 e1w)))
       (edits1 word)))))

(defn known [words]
  (reduce #(if (contains? nwords %2) (conj % %2) %) [] words))

(defn correct [word]
  (let [candidates (or (seq (known [word]))
                       (seq (edits1 word))
                       (seq (known-edits2 word))
                       [word])]
    (apply (partial max-key #(get nwords % 1)) candidates)))


;; (correct "speling") ; => spelling
```

You can find the source code with tests
[here](https://github.com/kirang89/spcorr).

Feedback/Comments are always welcome!
