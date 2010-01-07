From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c: Add support for Ux500/Nomadik I2C controller
Date: Thu, 7 Jan 2010 15:04:29 +0100
Message-ID: <20100107150429.585942cd@hyperion.delvare>
References: <27f8aa32bf40c690930a76ce5e1ee82cec86b248.1262870858.git.srinidhi.kasagar@stericsson.com>
	<1262828335.23286.2.camel@vinay-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1262828335.23286.2.camel@vinay-desktop>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: srinidhi kasagar <srinidhi.kasagar-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Cc: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, STEricsson_nomadik_linux <STEricsson_nomadik_linux-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org>, Sachin VERMA <sachin.verma-qxv4g6HH51o@public.gmane.org>, Andrea GALLO <andrea.gallo-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, rubini-9wsNiZum9E8@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, 7 Jan 2010 07:08:55 +0530, srinidhi kasagar wrote:
> Adding Alessandro Rubini in CC. I forgot to add you in copy.
> 
> Srinidhi
> On Thu, 2010-01-07 at 14:41 +0100, Srinidhi KASAGAR wrote:
> > This adds support for the ST-Ericsson's I2C
> > block found in Ux500 and Nomadik 8815
> > platforms.
> > 
> > Signed-off-by: srinidhi kasagar <srinidhi.kasagar-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
> > Acked-by: Andrea Gallo <andrea.gallo-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
> > ---
> >  arch/arm/plat-nomadik/include/plat/i2c.h |   31 +
> >  drivers/i2c/busses/Kconfig               |    7 +
> >  drivers/i2c/busses/Makefile              |    1 +
> >  drivers/i2c/busses/i2c-nmk.c             |  957 ++++++++++++++++++++++++++++++

i2c-nomadik.c, please. We're not using FAT16 ;)

> > +static void __exit nmk_i2c_exit(void)
> > +{
> > +       platform_driver_unregister(&nmk_i2c_driver);
> > +       return;

Useless statement.

> > +}

-- 
Jean Delvare
