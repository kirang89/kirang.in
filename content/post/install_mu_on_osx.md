---
title: "Emacs as email client with offlineimap and mu4e on OS X"
date: 2014-11-13T02:06:44+05:30
author: "Kiran Gangadharan"
categories: ["emacs"]
tags: ["emacs", "email", "productivity"]
slug: emacs-as-email-client-with-offlineimap-and-mu4e-on-osx
---

## Introduction<a id="sec-1" name="sec-1"></a>

For something as trivial and important as email, it annoys me that I
feel uncomfortable with any client I use. I've tried the Gmail
interface, Mail.app, Airmail and Mailbox, but somehow I haven't found
myself entirely comfortable using any of these. What I'm looking for
is a client that is easy to shoot up, quick to navigate between emails
and can entirely depend on keyboard shortcuts alone. In short email on
the terminal. Although I've been hearing good reviews about Mutt for a
while now, I wanted to use Emacs for all the editing. So I finally
decided to give mu4e a shot.

Here within, I've described the setup I've used(rather flicked) for
setting up mu4e on OSX.

### OfflineIMAP<a id="sec-1-1" name="sec-1-1"></a>

OfflineIMAP is one of the key components here. In essence, OfflineIMAP
allows you to download all your emails from an IMAP account into a
directory in your local machine and keep both the local and remote
repositories in sync. Think of it as 'git' cloning a remote
repository(IMAP) into your local machine and then syncing future
changes by pulling from remote and/or pushing local changes to it.

#### Installation<a id="sec-1-1-1" name="sec-1-1-1"></a>

You can install offlineimap on OSX using homebrew like so:

```bash
brew install offline-imap
```

#### Configuration<a id="sec-1-1-2" name="sec-1-1-2"></a>

Once offlineimap has been installed, create a `~/.offlineimaprc`
file. Add the following configuration into it:

    [general]
    ui=TTYUI
    accounts = Gmail
    autorefresh = 5

    [Account Gmail]
    localrepository = Gmail-Local
    remoterepository = Gmail-Remote

    [Repository Gmail-Local]
    type = Maildir
    localfolders = ~/.Mail/blahblah@gmail.com

    [Repository Gmail-Remote]
    type = Gmail
    remotehost = imap.gmail.com
    remoteuser = blahblah@gmail.com
    remotepass = sciencebitch!
    realdelete = no
    ssl = yes
    cert_fingerprint = <insert gmail server fingerprint here>
    maxconnections = 1
    folderfilter = lambda folder: folder not in ['[Gmail]/Trash',
                                                 '[Gmail]/Spam',
                                                 '[Gmail]/All Mail',
                                                 ]

The `folderfilter` option in the above configuration allows you to
sync only selected folders from your remote repository(Gmail). In this
case, I've used a lambda expression to blacklist the folders that I do
not want to sync. If you were wondering where the lambda came from,
offlinemaprc allows you to specify valid [python expressions and even
functions](http://offlineimap.org/examples.html#id13) based on the requirements of the
configuration. Pretty cool eh?

Also, if you don't want to use the `fingerprint` for your server, you
can instead add `sslcacertfile` and point it to your CA certificate.

For more options and their explanations, check out the the
[configuration file](https://github.com/OfflineIMAP/offlineimap/blob/master/offlineimap.conf) from the offlinemap source on GitHub.

#### Running<a id="sec-1-1-3" name="sec-1-1-3"></a>

Once you've setup your configuration, open up a terminal and run:

    offlineimap

If you've configured everything correctly, offlineimap will start
pulling down all the email(with attachments) into `localfolders`. This
may take quite a bit of time depending on the number of emails.

In the future you can use `offlineimap -q` to run in "quick
mode". This will perform lesser checks and in turn tends to be faster.

### Mu<a id="sec-1-2" name="sec-1-2"></a>

The emails that you pulled in the above step are stored in `Maildir`
format in your machine. Mu is designed to index messages stored in
this format. This allows you to do powerful and fast searches on your
emails. In addition, it allows you to view messages and even extract
attachments. The [Mu cheatsheet](http://www.djcbsoftware.nl/code/mu/cheatsheet.html) can tell you all about it. So what is
Mu4e then ?

#### Mu4e<a id="sec-1-2-1" name="sec-1-2-1"></a>

[Mu4e](http://www.djcbsoftware.nl/code/mu/mu4e/) is an Emacs frontend for Mu. In other words Mu for Emacs. It
allows you directly handle all your emails right from Emacs
itself. Remember that, since mu4e is a just an interface, it can
neither pull messages from nor push messages to, the server. Refer the
[user manual](http://www.djcbsoftware.nl/code/mu/mu4e/index.html) to learn more about what mu4e can and cannot do.

#### Installation<a id="sec-1-2-2" name="sec-1-2-2"></a>

Installing mu is as simple as running:

    brew install mu

If only it were that simple. Mu4e is a part of mu itself, and it
requires a recent version of Emacs(>=22). Since the emacs that comes
bundled with OSX(`/usr/bin/emacs`) satisfies this criteria, you could simply do:

    brew install mu --with-emacs --HEAD

and be done with it. But what if you're using the GUI Emacs from
[emacsformacosx](http://emacsformacosx.com/) or using a client installed via Homebrew? Thanks to
this [github issue](https://github.com/Homebrew/homebrew/issues/16504#issuecomment-11394215), you can do:

    EMACS=$(which emacs) brew install mu --with-emacs --HEAD

in which case, you could simply create an alias for emacs that points
to your client. Ahh, all is well. Not.

Apparently, no matter what `$(which emacs)` points to, the above
command seems to consider `/usr/bin/emacs` ([this](https://github.com/Homebrew/homebrew/pull/16733) seems
to be a workaround, but haven't got it to work yet). In any case, you
could solve this by setting `/usr/bin/emacs` as an alias to your
client (in my case
`/usr/local/Cellar/emacs-mac/emacs-24.3-mac-4.8/bin/emacs`). But
before you do, move the old emacs elsewhere like so:

    mv /usr/bin/emacs /usr/bin/emacs-bk
    sudo ln -s /usr/local/Cellar/emacs-mac/emacs-24.3-mac-4.8/bin/emacs /usr/bin/emacs

Now run the command again:

    EMACS=$(which emacs) brew install mu --with-emacs --HEAD

and everything should work just fine.

#### Running<a id="sec-1-2-3" name="sec-1-2-3"></a>

Once the installation has been completed, run mu to start indexing
your emails:

    mu index --maildir=~/.Mail

This should just be a matter of few minutes. In the meantime, let us
configure mu4e to work with Emacs.

#### Configuring Mu4e in Emacs<a id="sec-1-2-4" name="sec-1-2-4"></a>

As the last step, we now need to setup Emacs to be able to send and
receive emails using it's interface.

Add the configuration below into you `~/.emacs` file:

```elisp

(require 'mu4e)
(setq mu4e-maildir "~/.Mail")
(setq mu4e-drafts-folder "/[Gmail].Drafts")
(setq mu4e-sent-folder   "/[Gmail].Sent Mail")
;; don't save message to Sent Messages, Gmail/IMAP takes care of this
(setq mu4e-sent-messages-behavior 'delete)
;; allow for updating mail using 'U' in the main view:
(setq mu4e-get-mail-command "offlineimap")

;; shortcuts
(setq mu4e-maildir-shortcuts
    '( ("/INBOX"               . ?i)
       ("/[Gmail].Sent Mail"   . ?s)))

;; something about ourselves
(setq
   user-mail-address "blah@gmail.com"
   user-full-name  "Blah Man"
   mu4e-compose-signature
    (concat
      "Cheers,\n"
      "Blah Man\n"))

;; show images
(setq mu4e-show-images t)

;; use imagemagick, if available
(when (fboundp 'imagemagick-register-types)
  (imagemagick-register-types))

;; convert html emails properly
;; Possible options:
;;   - html2text -utf8 -width 72
;;   - textutil -stdin -format html -convert txt -stdout
;;   - html2markdown | grep -v '&nbsp_place_holder;' (Requires html2text pypi)
;;   - w3m -dump -cols 80 -T text/html
;;   - view in browser (provided below)
(setq mu4e-html2text-command "textutil -stdin -format html -convert txt -stdout")

;; spell check
(add-hook 'mu4e-compose-mode-hook
        (defun my-do-compose-stuff ()
           "My settings for message composition."
           (set-fill-column 72)
           (flyspell-mode)))

;; add option to view html message in a browser
;; `aV` in view to activate
(add-to-list 'mu4e-view-actions
  '("ViewInBrowser" . mu4e-action-view-in-browser) t)

;; fetch mail every 10 mins
(setq mu4e-update-interval 600)
```

Since mu4e cannot help in sending emails, we need to use [smtpmail](http://www.emacswiki.org/emacs/SendingMail) for the same:

```elisp
;; configuration for sending mail
(setq message-send-mail-function 'smtpmail-send-it
      smtpmail-stream-type 'starttls
      smtpmail-default-smtp-server "smtp.gmail.com"
      smtpmail-smtp-server "smtp.gmail.com"
      smtpmail-smtp-service 587)
```

Save the file and close Emacs. In order to allow Emacs to connect with
the gmail smtp server, you need to install [gnutls](http://www.gnutls.org/). Homebrew comes to
the rescue yet again:

    brew install gnutls

Now, create a `~/.authinfo` file and add the following into it:

    machine smtp.gmail.com login <gmail username> password <gmail password>

You can also encrypt the above file by running:

    gpg --output ~/.authinfo.gpg --symmetric ~/.authinfo

That's all there is to it :) Now open Emacs, hit `M-x mu4e RET` and
you should be all set! You can also extend your `~/.offlineimaprc` to
include more email accounts accordingly.

It's not perfect yet, but I'm starting to like this setup. Although it
irks me to open an html email due to rendering issues and the time
taken to convert it to plain-text, I'm hoping to take care of that
soon enough. Until then, I think I can live with this.

Suggestions, queries and improvements are welcome.
