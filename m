From: Shawn Guo <shawn.guo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [PATCH 2/2 V3] MXS: Implement DMA support into mxs-i2c
Date: Sun, 15 Jul 2012 16:17:16 +0800
Message-ID: <20120715081715.GA2429@S2100-06.ap.freescale.net>
References: <1341850974-11977-1-git-send-email-marex@denx.de>
 <1341850974-11977-2-git-send-email-marex@denx.de>
 <20120713082249.GF32184@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120713082249.GF32184-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Detlev Zundel <dzu-ynQEQJNshbs@public.gmane.org>, Dong Aisheng <b29396-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Linux ARM kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Stefano Babic <sbabic-ynQEQJNshbs@public.gmane.org>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Wolfgang Denk <wd-ynQEQJNshbs@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, Jul 13, 2012 at 10:22:49AM +0200, Wolfram Sang wrote:
> > +	/*
> > +	 * TODO: This is a temporary solution and should be changed
> > +	 * to use generic DMA binding later when the helpers get in.
> > +	 */
> 
> @Shawn: Any idea when this is going to happen? And why do we need this?

See thread [1] for current statues.  I'm not sure when it's going to
happen though.

> AFAICT it will be always channel 6/7 on mx28?
> 
Yes, but it might be a different channel on mx23.  Just like we define
IO region and interrupt number in device tree, dma channel is just
another resource of hardware block that we choose to define in device
tree.

Regards,
Shawn

[1] http://thread.gmane.org/gmane.linux.ports.arm.omap/75828
