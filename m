From: srinidhi kasagar <srinidhi.kasagar-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Subject: RE: [PATCH 1/2] i2c: Add support for Ux500/Nomadik I2C controller
Date: Fri, 8 Jan 2010 02:39:02 +0530
Message-ID: <1262898542.1026.6.camel@vinay-desktop>
References: <27f8aa32bf40c690930a76ce5e1ee82cec86b248.1262870858.git.srinidhi.kasagar@stericsson.com>
	 <A6D19A13FE030A409EC4362C172E091F0E30CDB5@eseldmw101.eemea.ericsson.se>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <A6D19A13FE030A409EC4362C172E091F0E30CDB5-xbI4eAY8CkZds0zI/4HV/NQnPW7fa8Gm1eXc/+PjCJA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus WALLEIJ <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Cc: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, STEricsson_nomadik_linux <STEricsson_nomadik_linux-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org>, Sachin VERMA <sachin.verma-qxv4g6HH51o@public.gmane.org>, Andrea GALLO <andrea.gallo-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, rubini-9wsNiZum9E8@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, 2010-01-07 at 21:37 +0100, Linus WALLEIJ wrote:
> > +++ b/drivers/i2c/busses/i2c-nmk.c
> (...)
> > +	dev->irq = platform_get_irq(pdev, 0);
> > +	ret = request_irq(dev->irq, i2c_irq_handler, IRQF_DISABLED,
> > +				DRIVER_NAME, dev);
> 
> Since I2C IRQs can be a bit tedious, could this be converted
> to a request_threaded_irq()? OK I know that is probably a bit
> intrusive and can very well be done later (so no blocker) but
> think about it.

hmm..I tried using request_threaded_irq, but seems not to be working at
the first step, did not debug further. So, I will post v2 patch fixing
the rest of your comments. Once I have this driver working fully with
threaded implementation, I will post a patch on top of it. Hope this is
OK.

Srinidhi 
