From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: I2C_M_RECV_LEN for i2c-mxs
Date: Sun, 14 Apr 2013 13:57:58 +0200
Message-ID: <20130414115757.GA9013@the-dreams.de>
References: <20130412093003.GE30416@pengutronix.de>
 <20130412153757.GA10241@the-dreams.de>
 <20130412182611.GG30416@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130412182611.GG30416-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Uwe =?iso-8859-15?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, Wolfram Sang <wolfram-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Uwe,

> The reason I used wolfram@... is probably:

Looking up MAINTAINERS would have done it :)

> Ah, ok. But then there is a different problem: Even though "my" driver
> only advertises I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL calling
> i2c_smbus_read_block_data in userspace results in .master_xfer being
> called with I2C_M_RECV_LEN set.

>From Documentation/i2c/functionality:

Because not every I2C or SMBus adapter implements everything in the 
I2C specifications, a client can not trust that everything it needs
is implemented when it is given the option to attach to an adapter:
the client needs some way to check whether an adapter has the needed
functionality...

Regards,

   Wolfram
