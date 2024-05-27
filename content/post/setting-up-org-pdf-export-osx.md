---
title: "Setting up org-mode pdf export in OS X ElCapitan"
date: 2015-11-30T00:00:00+05:30
categories: ["productivity", "emacs"]
tags: ["org-mode", "emacs", "osx"]
slug: setting-up-org-mode-pdf-export-in-osx-elcapitan
---

## Basic TeX ##

Download and install Basic TeX package from [here](https://www.tug.org/mactex/morepackages.html).

## Set System Path ##

The package will be installed at `/Library/TeX/texbin/`, so it
must be added to your PATH like so:

```bash
export PATH=$PATH:/Library/TeX/texbin
```

Run `which latex` to ensure that the path has been set correctly.

## Install Dependencies ##

You're not ready yet. There are a few more packages that need to be installed
in order to render the pdf from the tex file. Install them like so:

```bash
sudo tlmgr install wrapfig
sudo tlmgr install marvosym
sudo tlmgr install wasysym
```

You should now be able to export to pdf using `C-c C-e l p`.
