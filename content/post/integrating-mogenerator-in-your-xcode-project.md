---
title: "Integrating mogenerator in your XCode project"
date: 2014-08-27T14:53:00+05:30
author: "Kiran Gangadharan"
category: ["programming"]
tags: ["ios"]
slug: integrating-mogenerator-in-your-xcode-project
---

Every iOS app you build would require some sort of storage functionality
within the device itself, especially if it caches data fetched from the
network. [Core
Data](https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/CoreData/cdProgrammingGuide.html),
an object graph management framework developed by Apple will mostly
likely be your choice in this regard. In that case, a tool like
mogenerator is indispensable.
<!--more-->[mogenerator](https://github.com/rentzsch/mogenerator) is a
simple script that generates the model classes from the Core Data model
(.xcdatamodel) defined in a project. Not just that, mogenerator also
provides a few helper functions for your classes to make it simpler to
use them for saving and fetching them. In this article, I'll go through
the necessary steps to add the mogenerator script to your project and
automatically generate the necessary model classes whenever XCode builds
your project.

Let's begin by installing mogenerator on OS X using homebrew:

```bash
brew install mogenerator
```

Once installed, open your project in XCode and select the 'Edit Scheme'
option under the Product menu:

![Product
Menu](https://www.evernote.com/shard/s101/sh/71a6ab30-6ffd-4a14-a704-3d5616234b0d/b928625b2dbed0348a19c50f1ab15800/deep/0/Scheme-and-Product.png)

Under the Build Phase, select Pre-actions, tap '+' at the bottom left
and select 'New Run Script Action'.

![Build Phase
Pre-action](https://www.evernote.com/shard/s101/sh/b6786609-61fb-40e5-a97b-49957acc72bb/353e986691aea79ce4e56ed618acb6c9/deep/0/OtherViews-and-PhotoData---ArchiveReadingTests.m.png)

Configure the new run script as follows:
- Shell: <span
class="lang:default decode:true crayon-inline">/bin/sh</span>
- Provide build settings for: <span
class="lang:default decode:true crayon-inline">\<Project\></span>
- Script:


```bash
cd ${SOURCE_ROOT}/${PROJECT_NAME}


/usr/local/bin/mogenerator --template-var arc=true
-m ${PROJECT_NAME}.xcdatamodeld/${PROJECT_NAME}.xcdatamodel
-M Model/CoreData/Machine -H Model/CoreData/Human
```

This is how your script action should look like:

![New Run Script
action](https://www.evernote.com/shard/s101/sh/58e8760b-21ef-4b23-8500-5d723f5015bb/efa9bb6b77b2d648f8839040252ac0ba/deep/0/Screenshot-27-08-14-14-35.png)

Click <strong>OK</strong> and you're
good to go! The next time you build your project, mogenerator will work
it's magic on your data models!
