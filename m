From: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 1/3] mfd: add support for Diolan DLN-2 devices
Date: Tue, 2 Sep 2014 17:23:11 +0200
Message-ID: <20140902152311.GY4894@localhost>
References: <CAE1zotK0cddns4f4ay-GJie8O2pjb72+-yYndZvW0hbF0D83HA@mail.gmail.com>
 <20140901095127.GK7374@lee--X1>
 <CAE1zot+T6eq0jrL6_Qh=5nihNOgGEaWe5RCDk7_1XS8ZWaWKqA@mail.gmail.com>
 <20140901113949.GP7374@lee--X1>
 <CAE1zotKNBTEMX8DDYwdwOcq0qZgqxZWazE60TUQeiOmD0a4xbA@mail.gmail.com>
 <20140901154626.GH8796@lee--X1>
 <CAE1zotL-cjHqrdymzYhZq24zx+0qGY8-4JnrVZf-TGXDf5Sm3w@mail.gmail.com>
 <20140901175453.GR4894@localhost>
 <20140902080010.GD17117@lee--X1>
 <CAE1zotJzFL0bZvNo4mHK3+EhURarhTPDE5n+SdNzof8Nc-CFew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAE1zotJzFL0bZvNo4mHK3+EhURarhTPDE5n+SdNzof8Nc-CFew-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Octavian Purdila <octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Daniel Baluta <daniel.baluta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Laurentiu Palcu <laurentiu.palcu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Sep 02, 2014 at 11:45:55AM +0300, Octavian Purdila wrote:
> On Tue, Sep 2, 2014 at 11:00 AM, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> > On Mon, 01 Sep 2014, Johan Hovold wrote:

> >> I haven't looked at the details of the protocol for the device in
> >> question, but it might even be possible to use regmap here (as I
> >> mentioned in my comments on v1).
> >
> > Obviously that would be preferred.
> >
> > Octavian, did you look into that?
> >
> Yes, I did. Since this is the first time I am looking at regmap I may
> be wrong but I don't see a way to use it. The dln2 i2c driver needs to
> be able to send and receive arbitrary size buffers and this does not
> seem possible to do with the regmap API.

That should be possible using the regmap bus read and write operations.

> (Also creating a regmap class for a particular device seems over
> engineering since nobody else is going to use it)

Possibly, but it would allow subdrivers to be implemented using a
standard interface and also provide register caching for free.

The event callbacks of the device in questions would not fit this scheme
though, but perhaps only that part needs to be driver specific.

Johan
