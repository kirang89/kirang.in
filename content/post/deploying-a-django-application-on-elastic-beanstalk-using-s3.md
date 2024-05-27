---
title: "Deploying a Django application on Elastic Beanstalk using S3"
date: 2013-08-20T06:20:00+05:30
author: "Kiran Gangadharan"
category: ["programming"]
tags: ["aws", "deployment", "django", "elasticbeanstalk", "python", "s3"]
slug: deploying-a-django-application-on-elastic-beanstalk-using-s3
---

This post was born out of the pain to get a sample django application,
configured properly, using Amazon S3 for serving static files, to  run
on AWS Elastic Beanstalk. I encountered many errors on the way, but
finally managed to get a full fledged application running successfully.
I am gonna try and highlight the key steps here to help you get your
project up and running in no time.


First, create a sample Django project
and a AWS Elastic Beanstalk environment for your application, as per the
instructions provided in the [official AWS
documentation](http://docs.aws.amazon.com/elasticbeanstalk/latest/dg/create_deploy_Python_django.html).

Once you've successfully deployed a dummy application to AWS Elastic
Beanstalk, you need to configure the application to let S3 take care of
serving the static files. One important point to remember here is that
Django expects your webserver to serve static files in production mode
(```DEBUG = False```) and thus will not handle it on it's own, unlike in
development mode. Understanding this is critical to a successful
deployment.

So now let's go ahead and add S3 support. First you need to add the
following dependencies to your requirements.txt:

```bash
pip install django-storages boto
pip freeze | grep django-storages >> requirements.txt
pip freeze | grep boto >> requirements.txt
```

Next, add **storages** to <span
class="lang:default highlight:0 decode:true crayon-inline">INSTALLED\_APPS</span>  in
your settings file:

```python
INSTALLED_APPS = (
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.sites',
    'django.contrib.messages',
    'django.contrib.admin',
    'storages',
)
```

Now we need to provide AWS credentials and the bucket name to allow AWS
Elastic Beanstalk to transfer files to S3.  Add the following
configuration to <span
class="lang:default highlight:0 decode:true crayon-inline">settings.py</span> :

```python
if not DEBUG:
    AWS_STORAGE_BUCKET_NAME = '<s3 bucket name>'
    AWS_ACCESS_KEY_ID = '<access key id>'
    AWS_SECRET_ACCESS_KEY = '<secret access key>'
    STATICFILES_STORAGE = 'storages.backends.s3boto.S3BotoStorage'
    S3_URL = 'http://%s.s3.amazonaws.com/' % AWS_STORAGE_BUCKET_NAME
    STATIC_URL = S3_URL
```

The <span
class="lang:default highlight:0 decode:true crayon-inline">STATICFILES\_STORAGE</span>  setting
tells our application to use S3 for storing our static files.

The last step is to configure <span
class="lang:default highlight:0 decode:true crayon-inline">STATIC\_ROOT</span> * *to
create a static directory in the root folder of your project. To do
that, add the following lines to your settings:

```python
import os

STATIC_ROOT = os.path.join(
                  os.path.dirname(
				      os.path.dirname(
					      os.path.abspath(__file__)
					  )
	              ),
				  'static'
			  )
```

That's it ! When you run the application on AWS Elastic Beanstalk,
the ```03_collectstatic``` command that you added to the ebs
configuration file, will collect the static files from all your
applications and then add them to the static folder created at
STATIC_ROOT. This folder is then deployed to S3 and voila ! All your static files will now be served from the Amazon S3 server.

Hope you got your application running without any hassles. If you still
have difficulties following this tutorial, you can check out
[djangoboilerplate](https://github.com/kirang89/djangoboilerplate), a
boilerplate application fully configured and ready for deployment.
