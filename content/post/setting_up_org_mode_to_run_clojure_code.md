---
title: "Setting up Org-mode to run Clojure code"
date: 2016-07-18T00:00:00+05:30
categories: ["productivity", "emacs"]
tags: ["org-mode", "emacs", "clojure"]
slug: setting-up-org-mode-to-run-clojure-code
---

I wanted to be able to store interesting clojure snippets in an org file and
then execute and play with them without leaving the
file. In this post, I'll illustrate the steps needed to achieve the same. I am
assuming that you've already setup Emacs with org-mode and cider.

First, start by installing the `ob-clojure` package:
```
M-x package-install
ob-clojure
```

or simply do so with `use-package`:
```elisp
(use-package ob-clojure)
```

Now we need to let org-mode know to use a cider repl to execute the snippets in
our file:

```elisp
(require 'cider)
(setq org-babel-clojure-backend 'cider)
```

We're done with the setup. Start a new cider repl connection by running:

```
M-x cider-jack-in
```

Once the repl has successfully launched, create a new org file and add the
following code block:

```
#+BEGIN_SRC clojure
(+ 1 2 3 4)
#+END_SRC
```

Hit `C-c` from within a code block to evaluate it. You should now see the result
displayed like so:

```
#+RESULTS:
: 10
```

If you don't want the results to be displayed in the file itself, add `:results
silent` after the begin header:

```
#+BEGIN_SRC clojure :results silent
(+ 1 2 3 4)
#+END_SRC
```

You should now be able to see the result displayed in the minibuffer
instead.

That's all there is to it. Have fun with literate programming :)
