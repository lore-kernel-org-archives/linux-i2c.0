From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: remove_clientdata_to_null-branch
Date: Sat, 3 Apr 2010 20:27:17 +0200
Message-ID: <20100403202717.66a0743f@hyperion.delvare>
References: <20100403173646.GB2190@pengutronix.de>
	<20100403201317.1321b414@hyperion.delvare>
	<20100403182207.GC2190@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100403182207.GC2190-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sat, 3 Apr 2010 20:22:07 +0200, Wolfram Sang wrote:
> > I've seen it, but it is something for the power subsystem maintainer
> > (or akpm if there is none) to apply. I did kill drivers/i2c/chips for a
> > reason.
> 
> Oops, sorry my failure then. I asked Anton Vorontsov (power-maintainer) if he
> is fine with going this via the i2c-tree, so it will surely come after the
> needed modification of the core.

Both changes are independent. We all know that setting the driver data
back to NULL is cosmetic only, so nothing wrong will happen if we
don't. And the ds2782_battery fix is a no-op anyway (the code you're
removing did nothing.) Let's not invent patch dependencies where they
do not exist.

> That is why he "only" acked it. (I still think
> this sounds reasonable, the other cleaning-up patch should also go via i2c,
> right? Or am I missing something?)

I only pick patches in my i2c tree that touch other drivers if there is
a strong dependency between the changes. As this is not the case here,
I prefer the patch to go through the power subsystem tree.

-- 
Jean Delvare
