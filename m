From: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] I2C: Implement DMA support into mxs-i2c
Date: Tue, 1 May 2012 21:58:03 +0800
Message-ID: <20120501135800.GL2194@S2101-09.ap.freescale.net>
References: <1335738969-27445-1-git-send-email-marex@denx.de>
 <201204302207.39112.marex@denx.de>
 <20120430203016.GD28226@pengutronix.de>
 <201204302245.57958.marex@denx.de>
 <20120430210108.GE28226@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120430210108.GE28226-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, Wolfgang Denk <wd-ynQEQJNshbs@public.gmane.org>, Detlev Zundel <dzu-ynQEQJNshbs@public.gmane.org>, Stefano Babic <sbabic-ynQEQJNshbs@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Apr 30, 2012 at 11:01:08PM +0200, Wolfram Sang wrote:
> 
> > > > It complains that data might be undefined, do you want it in a separate
> > > > patch then ?
> > > 
> > > Yes, but only if you can prove that the compiler is right.
> > 
> > It's not right, because that variable is always initialized, but this at least 
> > squashes the compile warning.
> 
> The compiler needs to be fixed, not the kernel.
> 
Heh, this is coming up again.  I'm not convincing you to take the
change, but just curious what if this is not a compile warning but
an error for the same cause that compiler is not right.

-- 
Regards,
Shawn
