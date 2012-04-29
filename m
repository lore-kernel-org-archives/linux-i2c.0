From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH] i2c: mxs: disable QUEUE when sending is done
Date: Sun, 29 Apr 2012 11:11:13 +0200
Message-ID: <201204291111.13333.marex@denx.de>
References: <1335536631-28202-1-git-send-email-w.sang@pengutronix.de> <201204281533.35277.marex@denx.de> <20120429084324.GA3001@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120429084324.GA3001-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Uwe =?iso-8859-1?q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Dear Wolfram Sang,

> > > > I am wondering if we should only set QUEUE_RUN bit here.
> > > 
> > > I didn't check the manual, but I guess writing to MXS_I2C_QUEUECTRL_CLR
> > > just clears the QUEUE_RUN bit and nothing else?!
> > 
> > I think the RUN bit will be cleared by the controller anyway, so this
> > patch is pointless.
> 
> How do you get this idea? Given 27.3.2 and our experiences, I'd be very
> surprised. Try putting the system under heavy load without this patch
> and you'll see that FIFOs might be sent half filled when interrupted
> while filling.

All right, I won't argue here ;-)

Best regards,
Marek Vasut
