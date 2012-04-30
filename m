From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH 2/2] I2C: Implement DMA support into mxs-i2c
Date: Mon, 30 Apr 2012 23:19:32 +0200
Message-ID: <201204302319.32619.marex@denx.de>
References: <1335738969-27445-1-git-send-email-marex@denx.de> <201204302245.57958.marex@denx.de> <20120430210108.GE28226@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120430210108.GE28226-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Detlev Zundel <dzu-ynQEQJNshbs@public.gmane.org>, Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Stefano Babic <sbabic-ynQEQJNshbs@public.gmane.org>, Wolfgang Denk <wd-ynQEQJNshbs@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Dear Wolfram Sang,

> > > > It complains that data might be undefined, do you want it in a
> > > > separate patch then ?
> > > 
> > > Yes, but only if you can prove that the compiler is right.
> > 
> > It's not right, because that variable is always initialized, but this at
> > least squashes the compile warning.
> 
> The compiler needs to be fixed, not the kernel.
> 
> > > Yes, send V2 with DMA by default, and I will give a try on the
> > > mode-switching later, too.
> > 
> > I'd prefer to have PIOQ by default, to avoid breaking some of the boards.
> > Or can you test on all of them?
> 
> ? What kind of breakage do you expect? I think it is okay if we pull it
> in during the merge window; we can fix issues then till the relase (and
> maybe mode switching works, after all).

Ok, so be it then.

Best regards,
Marek Vasut
