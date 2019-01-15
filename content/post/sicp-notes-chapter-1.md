Title: SICP Notes - Chapter 1
Date: 2013-11-16 07:39
Author: kirang89
Category: Programming
Tags: programming, SICP, software development
Slug: sicp-notes-chapter-1

After quite a long time, I finally managed to take the time out of my
busy schedule of being jobless and start reading one of the best
classics in the field of Computer Science - the **Structure and
Interpretation of Computer Programs**. It's taken a while but I've
managed to complete the first chapter, and I'm really excited about the
easter eggs that await in the forthcoming chapters. As a result, I've
decided to keep notes of all the small lessons or tips that I would
gather while reading each chapter, for ease of reference in the future.
Below are my notes for chapter one:


There are basically two models of program evaluation:

-   Application-Order evaluation - Based on substitution model
    (subsitute first and then evaluate)

-   Normal-Order evaluation - Expansion first and then reduction. The
    expression is evaluated only when the result is needed by a
    primitive operation.

 

Good Programming can be compared to the game of **Chess**. It's not
sufficient to just know the various pieces and their roles. It is also
very important to know about typical openings (patterns) and strategies
(architecture).

 

#### Recursive Procedure vs Process

While a recursive procedure basically means a procedure referring to
itself, a recursive process refers to a process containing several
deferred operations.

 

#### Recursive vs Iterative Process

In a recursive process, the description of the state of a process is
based on the number of calls to a particular procedure. In an iterative
one, the description of the state of a process is obtained from the
variables used in that process.

 

#### Recursion Strategies:

-   Linear Recursion
-   Tree Recursion

 

Tail Recursion - A technique for running iterative processes using a
constant space (O(1))

 

Probabilistic Algorithms - Algorithms that do not necessarily guarantee
a result but instead relies on tests to prove that the chances of errors
are very small or negligible (Example: Finding a prime number using
Fermat's Theorem)

 

Learn to think about an algorithm in both recursive as well as an
iterative way.

 

Lots of small optimisations can be done to convert a O(n) algorithm to
an O(logn) one. Sometimes the simplest of the changes can make a huge
difference.

 

That's all I've got for chapter one. Oh, and I've pushed up solutions to
most exercises, on [GitHub](https://github.com/kirang89/SICP). I will
keep adding posts for other chapters as and when I complete them.

