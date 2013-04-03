From: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 3/3] watchdog: Add Congatec CGEB watchdog driver
Date: Wed, 3 Apr 2013 19:06:30 +0200
Message-ID: <20130403170630.GZ1906@pengutronix.de>
References: <1360663374-30951-1-git-send-email-s.hauer@pengutronix.de>
 <1360663374-30951-4-git-send-email-s.hauer@pengutronix.de>
 <CAH9NwWd7YdtK0urutisVgKoE7NmPFLpG3wFG5W6P7o45vUqAng@mail.gmail.com>
 <20130326143331.GA5529@roeck-us.net>
 <20130403150952.GX1906@pengutronix.de>
 <20130403153000.GA30641@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130403153000.GA30641-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Cc: Christian Gmeiner <christian.gmeiner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Apr 03, 2013 at 08:30:00AM -0700, Guenter Roeck wrote:
> On Wed, Apr 03, 2013 at 05:09:52PM +0200, Sascha Hauer wrote:
> [ ... ]
> 
> > > 
> > > On a side note, if the driver supports devicetree, it might make sense to call
> > > watchdog_init_timeout, since it initializes the timeout from devicetree data.
> > 
> > The driver does not support devicetree.
> > 
> I should have said "the system". Calling watchdog_init_timeout is the only thing
> a watchdog driver has to do to support devicetree.

The system does not use devicetrees. I'm very familiar with devicetrees
on ARM, but I have never seen a x86 system with devicetree support
(although I know they exist)

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
