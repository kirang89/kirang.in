---
title: "What makes a great API?"
date: 2013-11-07T22:59:00+05:30
author: "Kiran Gangadharan"
categories: ["design", "programming"]
tags: ["api", "design", "web"]
slug: what-makes-a-great-api
---

We are slowly moving towards a completely api-fied world. All the common
services that we used to find so hard to deal with a few years back,
have become super easy thanks to introduction of API's. Today, every
other person/business out there is developing an API to make an XYZ
service more awesome (and gain some developer love). Hence, it is
important to understand the principles behind designing good APIs. In
this post, I'll highlight a few practices/tips that I've learnt,
designing a few and using different API's.

<br/>

**So, what makes an API great?**

<br/>

## Valuable Service

A good API provides a valuable service. [Stripe](http://stripe.com) and
[Twilio](http://twilio.com) are some of the epitomes. There are many
more, but those two startups appeal to me the most. And what's more
awesome about providing a valuable service is that they help in hiding
some of your API sins ;). Even if your API does not have good code or
follow good conventions, you could still get away with it, if you
provide something truly useful.

## Understand your audience

It's important to know your target audience before you jump into design.
After all, you would measure your API success based on customer love,
especially if your business depended on it (like
[Parse](https://parse.com/) or [Sendgrid](http://sendgrid.com)). Do your
homework and find out what your target audience is looking for. And
then, give them what they want.

## Planning

A good amount of planning goes into building a good API. And this
certainly does not happen overnight. Before you jump into designing a
good API, you must understand it's purpose. Try and visualize how you
want your API to look for the end user. You could write small snippets
of how one would use your API and how the user input and API response
would look like (popularly known as [README-driven
development](http://tom.preston-werner.com/2010/08/23/readme-driven-development.html)).

## Design

Seems pretty obvious that an API should have a great design. But the
fact is  that "design" is too vague a term. So I guess I should say that
it's more about the choices that power the design. A typical list of
design choices that you need to make would include:

-   Protocol(s) to support
-   Data Format
-   Security
-   Open Source?
-   Design Patterns to use
-   Conventions and best practices to follow
-   Versioning

There are many more choices when you think deeper, but I guess the above
mentioned are good enough to start with.

## Documentation

This is the most important metric that determines how good your API
really is. You could compromise on quite a few things, but you could
never get away with poor documentation. Using a great API with poor
documentation is like using an iPhone for the sole purpose of making
calls and messages. It just doesn't make sense! There are reasons why
iPhone is a "smartphone". Similarly there would be a lot of reasons that
make your API great, but they aren't as intuitive when compared to the
case of a smartphone.

So, boast about your super awesome API by writing a clean and crisp
documentation. Give good examples, short and sweet tutorials and brief
reference of all the features and methods of your API. And don't forget
to refactor the docs and make them better, just like your code.

Document each and every minor and major release of your API. This helps
developers to keep track of the things that have changed, and possibly
use them to their advantage.

## Flexibility

It's quite hard to figure out what makes an API flexible. A flexible API
gives more control(and power) to the developer. A common example would
be the ability to provide response in different formats like JSON or
XML. Another example would be the ability to perform batch operations
for different functionalities in your API. This may not be so commonly
used, but when required it saves a lot of time by avoiding the
user/developer from writing extra code for doing the same. And
developers sure do appreciate that. After all, we're a lazy bunch of
people.

## Developer Support

This is another key metric that determines how awesome your API and/or
how successful your business is. Let's face it; we all love to use
products that have a little chat widget on their website, that enables
realtime communication with the developer/support team. That is
precisely the main reason why services like
[Olark](http://www.olark.com/) are so bloody awesome! They make the life
of the developers and the users more simpler. You need to find more ways
to provide good support to the customers. Ultimately, good experience is
what makes us stick with a product/business. So make sure that you
provide the best possible experience to your customers to make them come
back for more.

<br/>
I hope this will serve as a decent checklist for whenever you design an
API for yourself or your business. It definitely will, for me.
