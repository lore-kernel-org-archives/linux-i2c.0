From: srinidhi kasagar <srinidhi.kasagar-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Subject: Re: [PATCH v2 0/2] I2C driver support for Nomadik/Ux500
Date: Mon, 18 Jan 2010 01:50:37 +0530
Message-ID: <1263759637.29557.1.camel@vinay-desktop>
References: <cover.1262944133.git.srinidhi.kasagar@stericsson.com>
	 <20100110131529.GE1224@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100110131529.GE1224-SMNkleLxa3Z6Wcw2j4pizdi2O/JbrIOy@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, STEricsson_nomadik_linux <STEricsson_nomadik_linux-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org>, Sachin VERMA <sachin.verma-qxv4g6HH51o@public.gmane.org>, Andrea GALLO <andrea.gallo-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, "khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "rubini-9wsNiZum9E8@public.gmane.org" <rubini-9wsNiZum9E8@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Ben,

On Sun, 2010-01-10 at 14:15 +0100, Ben Dooks wrote:
> On Fri, Jan 08, 2010 at 04:00:24PM +0530, srinidhi kasagar wrote:
> > This is the v2 version of the patch which adds support for the
> > ST-Ericsson's I2C block found in U8500/Nomadik 8815 platforms.
> > 
> > ---
> > Changelog v1->v2
> > - file rename from i2c-nmk.c to i2c-nomadik.c (Jean Delvare)
> > - remove the unnecessary return statement (Jean Delvare)
> > - kernel doc style comment fix & other fixes (Linus Walleij)
> > - Added support for 400 KHz.
> > 
> > - patch 1/2 : targets plat-nomadik folder
> > - patch v2 2/2 : fixes the above comments.
> > ---
> > 
> > srinidhi kasagar (2):
> >   ARM nomadik: add platform specific i2c configuration structures
> >   i2c: Add support for Ux500/Nomadik I2C controller
> > 
> >  arch/arm/plat-nomadik/include/plat/i2c.h |   37 ++
> >  drivers/i2c/busses/Kconfig               |    7 +
> >  drivers/i2c/busses/Makefile              |    1 +
> >  drivers/i2c/busses/i2c-nomadik.c         |  980 ++++++++++++++++++++++++++++++
> >  4 files changed, 1025 insertions(+), 0 deletions(-)
> >  create mode 100644 arch/arm/plat-nomadik/include/plat/i2c.h
> >  create mode 100644 drivers/i2c/busses/i2c-nomadik.c
> 
> I'll get round to reviewing the new patches in the next day or two.

Any comments on this patch set?

regards,
Srinidhi
