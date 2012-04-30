From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH 1/2] I2C: Set I2C timing registers for mxs-i2c
Date: Mon, 30 Apr 2012 14:05:42 +0200
Message-ID: <201204301405.42621.marex@denx.de>
References: <1335738969-27445-1-git-send-email-marex@denx.de> <20120430055825.GA7926@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120430055825.GA7926-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Detlev Zundel <dzu-ynQEQJNshbs@public.gmane.org>, Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Stefano Babic <sbabic-ynQEQJNshbs@public.gmane.org>, Wolfgang Denk <wd-ynQEQJNshbs@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Dear Wolfram Sang,

> On Mon, Apr 30, 2012 at 12:36:08AM +0200, Marek Vasut wrote:
> > This sets the bus to run at 400kHz, prior to this,
> > the bus frequency was undefined.
> 
> Not exactly. The default values let it run at 100kHz.

Have you tried dumping the default values and comparing it with the values for 
100kHz in the manual?

> Since not all
> slaves support 400kHz, I have to NACK this one. Making it configurable
> is the way to go here.

All right, that's a good point.
> 
> Thanks,
> 
>    Wolfram

Best regards,
Marek Vasut
