From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH 1/2] I2C: Set I2C timing registers for mxs-i2c
Date: Mon, 30 Apr 2012 22:47:17 +0200
Message-ID: <201204302247.17242.marex@denx.de>
References: <1335738969-27445-1-git-send-email-marex@denx.de> <201204302209.12482.marex@denx.de> <20120430202742.GC28226@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120430202742.GC28226-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Detlev Zundel <dzu-ynQEQJNshbs@public.gmane.org>, Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Stefano Babic <sbabic-ynQEQJNshbs@public.gmane.org>, Wolfgang Denk <wd-ynQEQJNshbs@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Dear Wolfram Sang,

> > > > > > This sets the bus to run at 400kHz, prior to this,
> > > > > > the bus frequency was undefined.
> > > > > 
> > > > > Not exactly. The default values let it run at 100kHz.
> > > > 
> > > > Have you tried dumping the default values and comparing it with the
> > > > values for 100kHz in the manual?
> > > 
> > > Yes, sure. Doesn't it work for you? I just rechecked and the values are
> > > okay. That being said, if you make it configurable for 400kHz, it would
> > > in deed be better to rewrite the values for 100kHz, too.
> > 
> > They were different for me ... did you configure the i2c bus in your
> > bootloader possibly? Those values might have been written there since
> > then ... I didn't run i2c in u-boot before booting linux.
> 
> Nope, no I2C involved in the bootloader at all. Do you get the correct
> values after soft-resetting the device?
> 
> It doesn't really matter, though. Just reinit them to the proper values
> depending on the user setting.

Indeed. Default to 100kHz might be a good idea too, in case user entered some 
weird value. Eventually, it'd be nice if we could calculate the timing values 
for all possible frequencies, but I didn't got to deriving such formula ... 
dunno if it's worth it either, doubt so.

Best regards,
Marek Vasut
