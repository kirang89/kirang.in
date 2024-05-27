---
title: "Setting up ACL in Mosquitto using Postgres"
date: 2015-05-23T00:00:00+05:30
author: "Kiran Gangadharan"
categories: ["programming"]
tags: ["mosquitto", "postgres", "mqtt"]
slug: setting-up-acl-in-mosquitto-using-postgres
---

Lately, I've been playing around with Mosquitto and MQTT in
general. Something that is essential to prevent unauthorized access to
topics is some sort of an access control mechanism. In this post, I'll
illustrate the necessary steps for setting up an ACL(Access Control
List) using Postgres and [mosquitto-auth-plugin](https://github.com/jpmens/mosquitto-auth-plug.git).

## Install Dependencies<a id="sec-1" name="sec-1"></a>

    sudo apt-get install libc-ares-dev libcurl4-openssl-dev uuid-dev postgresql libpq-dev git

## Install Mosquitto<a id="sec-2" name="sec-2"></a>

Download Mosquitto from source:

    wget http://mosquitto.org/files/source/mosquitto-1.4.1.tar.gz

Build it from source:

    tar xvzf mosquitto-1.4.1.tar.gz
    cd mosquitto-1.4.1

Set ```WITH_SRV:=NO``` in config.mk to deal with
[this](https://github.com/jpmens/mosquitto-auth-plug/issues/33).

Now we're all set to build Mosquitto:

    make mosquitto
    sudo make install

## Setup the Authentication plugin<a id="sec-3" name="sec-3"></a>

    git clone https://github.com/jpmens/mosquitto-auth-plug.git
    cd mosquitto-auth-plug
    cp config.mk.in config.mk

Edit the configuration file to match the following:

    # Select your backends from this list
    BACKEND_CDB ?= no
    BACKEND_MYSQL ?= no
    BACKEND_SQLITE ?= no
    BACKEND_REDIS ?= no
    BACKEND_POSTGRES ?= yes
    BACKEND_LDAP ?= no
    BACKEND_HTTP ?= no
    BACKEND_MONGO ?= no

    # Specify the path to the Mosquitto sources here
    MOSQUITTO_SRC = /path/to/mosquitto-1.4.1

    # Specify the path the OpenSSL here
    OPENSSLDIR = /usr

Build the plugin:

    make

Finally, move the generated plugin file to the root directory of Mosquitto:

    mv auth-plug.so /etc/mosquitto/

## Setup Mosquitto with the plugin<a id="sec-4" name="sec-4"></a>

Add the following lines to `mosquitto.conf`:

    auth_opt_backends postgres
    auth_plugin /etc/mosquitto/auth-plug.so
    auth_opt_host <host>
    auth_opt_port <port>
    auth_opt_dbname <dbname>
    auth_opt_userquery SELECT password FROM account WHERE username = $1 limit 1
    auth_opt_superquery SELECT COALESCE(COUNT(*),0) FROM account WHERE username = $1 AND super = 1
    auth_opt_aclquery SELECT topic FROM acls WHERE (username = $1) AND (rw >= $2)

See the [plugin documentation](https://github.com/jpmens/mosquitto-auth-plug#postgresql) for more options.

Next, create the necessary tables:

    create table account(
    id SERIAL,
    username TEXT NOT NULL,
    password TEXT,
    super smallint DEFAULT 0 NOT NULL,
    PRIMARY KEY (id)
    );

    CREATE INDEX account_username ON account (username);

    CREATE TABLE acls (
    id SERIAL,
    username TEXT NOT NULL,
    topic TEXT NOT NULL,
    rw INTEGER NOT NULL DEFAULT 0,
    PRIMARY KEY (id)
    );

    CREATE UNIQUE INDEX acls_user_topic ON acls (username, topic);

*Note: The password will stored as a PBKDF2 hash. There are a few
[tools](https://github.com/jpmens/mosquitto-auth-plug/tree/master/contrib) to help you generate the required hash.*

## Testing broker with the new configuration<a id="sec-5" name="sec-5"></a>

Once you've completed adding the necessary configuration and tables,
it's time to finally test them out! To do so, start Mosquitto with the
configuration file:

    /usr/local/sbin/mosquitto -c /etc/mosquitto/mosquitto.conf

If everything goes well, you should see the following output from the
broker:

    1432149665: |-- *** auth-plug: startup
    1432149665: |-- ** Configured order: postgres

    1432149665: |-- }}}} POSTGRES
    1432149665: |-- HERE: SELECT COALESCE(COUNT(*),0) FROM account WHERE username = $1 AND super = 1
    1432149665: |-- HERE: SELECT topic FROM acls WHERE (username = $1) AND (rw >= $2)

You should now be able to connect to this broker by setting the
username and password fields of your mqtt client. Even though the
PBKDF2 hash of the password is stored in the database, you can provide
the raw password while connecting.

Hope this helps.


**UPDATE**: Added minor changes to deal with errors when starting Mosquitto
