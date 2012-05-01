From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH 2/2] I2C: Implement DMA support into mxs-i2c
Date: Tue, 1 May 2012 16:14:01 +0200
Message-ID: <201205011614.02140.marex@denx.de>
References: <1335738969-27445-1-git-send-email-marex@denx.de> <201205011602.56563.marex@denx.de> <20120501140910.GM2194@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120501140910.GM2194-rvtDTF3kK1ictlrPMvKcciBecyulp+rMXqFh9Ls21Oc@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Wolfgang Denk <wd-ynQEQJNshbs@public.gmane.org>, Detlev Zundel <dzu-ynQEQJNshbs@public.gmane.org>, Stefano Babic <sbabic-ynQEQJNshbs@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Dear Shawn Guo,

> On Tue, May 01, 2012 at 04:02:56PM +0200, Marek Vasut wrote:
> > Dear Shawn Guo,
> > 
> > > On Mon, Apr 30, 2012 at 11:01:08PM +0200, Wolfram Sang wrote:
> > > > > > > It complains that data might be undefined, do you want it in a
> > > > > > > separate patch then ?
> > > > > > 
> > > > > > Yes, but only if you can prove that the compiler is right.
> > > > > 
> > > > > It's not right, because that variable is always initialized, but
> > > > > this at least squashes the compile warning.
> > > > 
> > > > The compiler needs to be fixed, not the kernel.
> > 
> > I second this.
> 
> I agree on this too.
> 
> > > Heh, this is coming up again.  I'm not convincing you to take the
> > > change, but just curious what if this is not a compile warning but
> > > an error for the same cause that compiler is not right.
> > 
> > Can you elaborate?
> 
> Will we have the kernel not compilable for a few cycles until the
> compiler fixing is available, or we work it around to keep kernel
> compiling and working before we have the compiler fixed?

This is kind of lacmus paper showing if the compiler was fixed. On the other 
hand, many people won't have a fixed compiler for a long time, so I'd be for 
applying this patch.

Best regards,
Marek Vasut
