---
title: "Useful AWK one-liners"
date: 2015-12-15T00:00:00+05:30
categories: ["programming", "productivity"]
tags: ["awk", "productivity"]
slug: useful-awk-one-liners
---

While reading
[Masterminds of Programming](http://shop.oreilly.com/product/9780596515171.do) I
came across the interview with [Alfred Aho](https://en.wikipedia.org/wiki/Alfred_Aho) and his thoughts about the design of
the AWK programming language. I've always known about the existence of awk, but
have never really felt the urge to dive in. Then I came across this sentence:

> If I had to choose a word to describe our centering forces in language design,
> I'd say Kernighan emphasized ease of learning; Weiberger, soundness of
> implementation; and I, utility. I think AWK has all three of these properties.

This got me curious enough to put down the book and start looking through a few
AWK tutorials. After mucking around with it for a day or two, I am really glad
that I did so. AWK is a simple yet powerful language to do some quick data
processing for which languages like Python or Ruby may be an overkill.

While learning, I've collected a few one-liners together, as a cheatsheat for
myself.

### Remove duplicate lines from a file
```bash
awk '!a[$0]++' data.txt
```
### Print account name and role from /etc/passwd
```bash
awk -F : '/^[^(#|_)]/ {print $1, "=>", $5}' /etc/passwd
```
### Prefixing line with increasing number
```bash
awk '{print FNR ". " $0}' data1.txt
```
### Find sum of columns for each row
```bash
awk '{s=0; for (i=1; i<=NF; i++) s=s+$i; print s}' data1.txt
```
### Find the line containing largest value in the first column
```bash
awk '$1 > max {max=$1; maxline=$0}; END{ print maxline}' data1.txt
```
### Find and replace in file
```bash
# Replace only first instance in line
awk '{sub(/HTML/, "html")}; 1' data1.txt > data2.txt

# Replace all instances in line
awk '{gsub(/HTML/, "html")}; 1' data1.txt > data2.txt
```
### Swap first two columns of every line
```bash
awk '{temp=$1; $1=$2; $2=temp} 1' data2.txt
```
### Delete second column from every line
```bash
awk '{ $2 = ""; print }' data2.txt
```
### Perform search similar to SQL 'where'
```bash
awk '$2 == "hello"' data2.txt
```
