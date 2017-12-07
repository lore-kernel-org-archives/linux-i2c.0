From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v5 1/2] at24: support eeproms that do not auto-rollover
 reads.
Date: Thu, 7 Dec 2017 22:57:50 +0100
Message-ID: <20171207215750.jzx6mqftx4poeep7@pengutronix.de>
References: <1512657378-5221-1-git-send-email-svendev@arcx.com>
 <1512657378-5221-2-git-send-email-svendev@arcx.com>
 <CAMRc=MdhJRD+G18Xh5vfmaHHdJ+g9EnDTxUHVxhzDzVt-D0KMg@mail.gmail.com>
 <20171207190230.ttq5xthgsuuy4swn@pengutronix.de>
 <CAMRc=MeEnDYjDTpE=XKuP3LricsnEnh0RHKMzxEPUcOS6E0tPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAMRc=MeEnDYjDTpE=XKuP3LricsnEnh0RHKMzxEPUcOS6E0tPQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bartosz Golaszewski <brgl-ARrdPY/1zhM@public.gmane.org>
Cc: Sven Van Asbroeck <svendev-fuHqz3Nb1YI@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, nsekhar-l0cyMroinI0@public.gmane.org, Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, David Lechner <david-nq/r/kbU++upp/zk7JDF2g@public.gmane.org>, Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>, Divagar Mohandass <divagar.mohandass-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-i2c <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Dec 07, 2017 at 10:33:51PM +0100, Bartosz Golaszewski wrote:
> 2017-12-07 20:02 GMT+01:00 Uwe Kleine-König <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>:
> > Hello,
> >
> > On Thu, Dec 07, 2017 at 05:26:50PM +0100, Bartosz Golaszewski wrote:
> >> > +       if (at24->chip.flags & AT24_FLAG_NO_RDROL) {
> >> > +               bits = (at24->chip.flags & AT24_FLAG_ADDR16) ? 16 : 8;
> >>
> >> There's no need for braces around the ternary operator's condition.
> >
> > Even if not required, I'd keep them for clearity.
> >
> 
> I don't want to start bikeshedding, so I'll take it as it is, but I
> prefer to avoid braces wherever it's not necessary.

For me the reasoning is: Most people (me included) don't know off-hand
if the semantic of

	a & b ? c : d

is
	(a & b) ? c : d

or

	a & (b ? c : d)

In some situations (e.g. a & b == c) gcc even warns when you don't add
syntactically needless parentheses. The case under discussion isn't such
an example though.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
