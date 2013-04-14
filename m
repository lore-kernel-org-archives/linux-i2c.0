From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: I2C_M_RECV_LEN for i2c-mxs
Date: Sun, 14 Apr 2013 19:54:38 +0200
Message-ID: <201304141954.38902.marex@denx.de>
References: <20130412093003.GE30416@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130412093003.GE30416-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Uwe =?iso-8859-1?q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Wolfram Sang <wolfram-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Uwe,

CCing Lucas Stach too, are you two not in the same office now ? ;-)

> Hello,
> 
> I'm currently trying to teach the i2c-mxs driver to handle the
> I2C_M_RECV_LEN flag but failed up to now. Maybe someone has an good idea
> how to make it running?
> 
> My current patch looks as follows:

Try basing your patch on top of Lucas's, they looked very reasonable. I think WS 
should have applied them by now. Wolfram, what's the status of those three mxs-
i2c patches from Lucas, can you tell?

Best regards,
Marek Vasut
