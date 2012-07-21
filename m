From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH 2/2 V3] MXS: Implement DMA support into mxs-i2c
Date: Sat, 21 Jul 2012 17:54:29 +0200
Message-ID: <201207211754.29372.marex@denx.de>
References: <1341850974-11977-1-git-send-email-marex@denx.de> <201207211611.58956.marex@denx.de> <20120721154153.GA25874@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120721154153.GA25874-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Shawn Guo <shawn.guo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, devicetree-discuss-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, Wolfgang Denk <wd-ynQEQJNshbs@public.gmane.org>, Detlev Zundel <dzu-ynQEQJNshbs@public.gmane.org>, Stefano Babic <sbabic-ynQEQJNshbs@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Uwe =?iso-8859-1?q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Dong Aisheng <b29396-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, pavel-+ZI9xUNit7I@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Dear Wolfram Sang,

> > > Yet, if I know the compatible property for the mxs I2C driver, and also
> > > know the CPU type (be it MX23 or MX28), I can deduce from that a lot of
> > > information, including DMA channel. That is fix. Why encode it?
> > 
> > You know the compatible and the "fallback compatible". From the later
> > one, you can deduce nothing if that happens to kick in.
> 
> Even if the driver was matched because of an MX23-I2C "compatible"
> binding, both devicetree and runtime could provide data that it actually
> runs on MX28. That shouldn't be a problem.

You mean like ... cpu_is_mx28() ? We got rid of that in favor of DT.

> > btw. the PIO discussion on DT discuss is completely ignored. How shall we
> > proceed, this driver is stalled for too long.
> 
> IIRC I mentioned that a discussion about the bindings won't make the
> next merge window.

Yet another merge window, I have to mention. And only because very long pauses 
inbetween reviews and very minor nitpicks. I'm being annoyed by this patch so 
much I'm thinking of giving up on this. I wasted too much of my free time on 
this and the result is as is.

> That's why I proposed either module_parameter

Which I explained is not a way to go.

> or
> dropping the binding entirely as possible inbetween options.

Which is not an option either. And this discussion is only further stalling the 
patch.

We're adding fsl,something properties all over the DT all the time, yet this one 
is of concern?

Best regards,
Marek Vasut
