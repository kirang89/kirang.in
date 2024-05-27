---
title: "Building an open-source Python application the right way"
date: 2013-09-09T22:44:00+05:30
author: "Kiran Gangadharan"
categories: ["open source", "programming", "python"]
tags: ["bootstrapy", "open source", "programming", "python"]
slug: building-an-open-source-python-application-the-right-way
---

If you love Python and love open source like I do, you'd probably be
open sourcing something new every day/week/month. Sure that there are
quite a lot of articles online that tell you the best practices of
writing Python code, testing, packaging, distributing etc, I haven't
really found a good article that highlights what are the best
practices/conventions to be followed while building a full fledged and
open source Python application. So I decided to write one.

<!--more-->

While I know that this was a good idea, I also wanted some sort of
template code that I could reuse in every project. Hence, I decided to
write one. Meet [bootstrapy](https://github.com/kirang89/bootstrapy), a
bootstrap python application that takes the pain out of setting up a
sample application and lets you focus on writing code and tests for
them. As a follow up of the application, I'll try and explain the
purpose of various files in as simple manner as possible.

First, let's take a look at the directory structure of bootstrapy:

[![bootstrapy-screenshot](http://kirang89.webfactional.com/wp-content/uploads/2013/09/bootstrapy-screenshot.png)](http://kirang89.webfactional.com/wp-content/uploads/2013/09/bootstrapy-screenshot.png)
**Files**

-   *AUTHORS.rst* - This is where you would add yourself as well as the
    names of other contributors to your project
-   *CHANGELOG* - Contains the list of changes in your application for
    each release you do. This serves as a quick overview of what has
    changed in your application/project for both developers/users. This
    file may be optional or mandatory, depending on the license you
    choose.
-   *CONTRIBUTING.rst* - Contains the instructions to be followed that
    instructs developers on how they can help out with your project.
-   *MANIFEST.in* - While this is not mandatory, it is fairly common to
    list the contents of your distribution in this file. This file
    indicates what files are needed to be included in the source
    distribution but does directly affect what files are installed. In
    short words, the packages that need to be installed, should be
    mentioned in <span
    class="lang:default decode:true crayon-inline">setup.py</span>  and
    the extras needed in the final binary of your application, should be
    mentioned in the MANIFEST file.
-   *Makefile* - Makefiles are generally used to organise code
    compilation. But we can abuse it a bit and use it to do various
    other things like setting up an environment, installing
    dependencies, cleaning up……you get the picture.
-   *requirements.txt* - This is where you put all the
    dependencies/packages needed by your project/application. Doing so,
    you can install them using <span
    class="lang:default decode:true crayon-inline">make
    deps</span>  which internally runs <span
    class="lang:default decode:true crayon-inline">pip install -r
    requirements.txt</span>
-   *setup.py* - Tells you that the package/module that you're about to
    install have been packaged and distributed using Distutils, which is
    the standard for distributing Python modules. This allows for easy
    installation of Python projects by just running  <span
    class="lang:default decode:true crayon-inline crayon-selected">python
    setup.py install</span>

You can do other things like create your own package, zip it and even
upload it to [PyPi](https://pypi.python.org/). For more details, refer
[Installing Python Modules](http://docs.python.org/2/install/index.html)
and [Getting started with setuptools and
setup.py](http://pythonhosted.org/an_example_pypi_project/setuptools.html).

**Directories**

-   *docs* - This is the directory to be created to store all the
    documentation to be used by Sphinx. You should basically store the
    documentation files in **.rst**(reStructured Text)  format.
-   *mypackage* - This is the main package of your project. This is
    where your project/application code goes into. You can see some
    sample, useless code in <span
    class="lang:default decode:true crayon-inline">myapp.py</span> .
-   *tests* - This is where all your tests go into. Add all your test
    cases/suites in this directory and execute them by calling<span
    class="lang:default decode:true crayon-inline">make test</span> . I
    have currently configured the project to run tests using
    [Nose](http://nose.readthedocs.org/en/latest/). It automagically
    detects where all your tests are located and then runs them. It is
    recommended that you follow the pattern
    'test\_\<feature-to-be-tested\>.py' while naming files containing
    test cases for \<feature-to-be-tested\>.

 

So now whenever I need to work on a Python application, all I need to do
is to clone the bootstrapy repo, and voila ! I can start writing code.
Sweet, isn't it ?

This is the project structure that I would recommend, but there may be
different opinions about the same. If you have a suggestion, feel free
to raise an [issue on
github](https://github.com/kirang89/bootstrapy/issues). If you have a
question/feedback instead, ping me directly [via
email](mailto:%20kiran.daredevil@gmail.com).
