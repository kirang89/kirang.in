---
title: "Setting up Jenkins as a watchdog for your Python application"
date: 2013-11-28T20:19:00+05:30
author: "Kiran Gangadharan"
categories: ["programming"]
tags: ["ci", "jenkins", "python"]
slug: setting-up-jenkins-as-a-watchdog-for-your-python-application
---

In order to facilitate  an efficient collaboration amongst developer
teams, it is very important to keep the development workflow as simple
and straightforward as possible. Version Control is one tool that helps
with this. Continuous Integration is another one. Below, I'll illustrate
the steps needed to configure a basic Python application with
[Jenkins](http://jenkins-ci.org), a CI server that automates a lot of
the repetitive stuff, so that you can focus on writing code. Well, let's
get started then.

<div class="note">
Before we move ahead, make sure that you have Jenkins installed on
your system. The installations binaries and guides are available in
the official site. The CI dashboard should be visible at
http://localhost:8080, if your installation was successful.
</div>

Create a new project, and fill in the *GitHub project *option with the
path to your local git repository.

[![local-git-repo-config](http://kirang.in/wp-content/uploads/2013/11/local-git-repo-config.jpg)](http://kirang.in/wp-content/uploads/2013/11/local-git-repo-config.jpg)

 

Next, install the following plugins:

-   Git Plugin
-   Cobertura Plugin (for coverage reports)
-   Violations Plugin (for pylint violation reports)

After installing the above, restart Jenkins and move on to the next
step.

Once you're done restarting, open *Jenkins Dashboard \> Manage
Jenkins \> Configure System*. Set your [GitHub](http://github.com)
username and email under the *Git Plugin* option

Now, go back to your projet configuration and set the following
properties:

-   Select *Git* under *Source Code Management* and add your project
    details. Remember to set the project *branch* accordingly.
-   Select *Poll SCM* under *Build Triggers* and set it to an
    appropriate value, based on how often you want Jenkins to look into
    your project for changes.
-   Add a new build step under the *Build* option and select *Execute
    Shell*. This allows you to specify the instructions to build your
    project. I've used the following snippet, but feel free to modify it
    in accordance to your liking.

```bash
# Adding virtualenv to PATH
PATH=/usr/local/bin:$PATH
cd $WORKSPACE/

virtualenv --no-site-packages ve
. ve/bin/activate

# Installing necessary packages and project dependencies
pip install -r requirements.txt --download-cache=/tmp/$JOB_NAME
pip install nose
pip install coverage
pip install pylint

# Running Tests
nosetests --with-xunit --all-modules --traverse-namespace --with-coverage --cover-package=bootstrapy --cover-inclusive

# Generating code coverage
coverage xml

# Checking for pylint violations
pylint -f parseable -d I0011,R0801 mypackage | tee pylint.out
```

-    Add *Publish Cobertura Coverage Report* and *Publish Junit test
    result report* to Post Build Actions and set them to <span
    class="lang:default decode:true crayon-inline">coverage.xml</span> and <span
    class="lang:default decode:true crayon-inline">nosetests.xml</span> :

[![coverage-and-test-config](http://kirang.in/wp-content/uploads/2013/11/coverage-and-test-config.jpg)](http://kirang.in/wp-content/uploads/2013/11/coverage-and-test-config.jpg)

-   Lastly, add *Report Violations* to *Post Build Actions* and then set
    the XML filename pattern for pylint as ```**/pylint.out```

[![pylint-config](http://kirang.in/wp-content/uploads/2013/11/pylint-config.jpg)](http://kirang.in/wp-content/uploads/2013/11/pylint-config.jpg)

 

That's it ! Now build your project and you should be able to get test,
coverage and pylint violation reports right on the project dashboard.
The best part is the fact that this is just the tip of the iceberg in
terms of what Jenkins is capable of. There are lot more cooler things
that you can do. So, have fun exploring !
