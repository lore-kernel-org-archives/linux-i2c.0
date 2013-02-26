From: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Subject: Re: [PULL REQUEST] i2c for 3.9
Date: Tue, 26 Feb 2013 09:54:37 -0800
Message-ID: <CA+55aFyxtjiaA=BqHmHbGJqm3cE-cqboCuLXnKxiu4LfHRXnmg@mail.gmail.com>
References: <20130225202735.GA1928@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130225202735.GA1928-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Feb 25, 2013 at 12:27 PM, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
>
> here are the changes for the i2c subsystem for 3.9. Highlights:
>    ....
> In addition, there is the usual bunch of fixes, cleanups, devm_*
> conversions, etc. Please pull.

Pulled, but when doing the conflict resolution, I noted that at least
one devm_* conversion had been done incorrectly. It's an older one,
but then there were changes to the area that made it conflict, and
Inotied.

These three lines have two separate bugs in them:

        i2c->regs = devm_request_and_ioremap(&pdev->dev, res);
        if (i2c->regs == NULL) {
                dev_err(&pdev->dev, "cannot request and map IO\n");

The bugs are:
 (a) the error case for devm_request_and_ioremap() doesn't return NULL
 (b) dev_err() is very wrong, since one of the whole points of devm_*
is that it already prints out errors for the error case.

There have been other complaints about the mindless devm_* conversion
lately (it changes the order of deallocations which can be deadly), so
please please *please* be more careful about these kinds of "trivial"
patches.

                  Linus
