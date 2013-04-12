From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: I2C_M_RECV_LEN for i2c-mxs
Date: Fri, 12 Apr 2013 17:37:57 +0200
Message-ID: <20130412153757.GA10241@the-dreams.de>
References: <20130412093003.GE30416@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130412093003.GE30416-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Uwe =?iso-8859-15?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, Wolfram Sang <wolfram-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Uwe,

please prefer wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org for kernel stuff.

>  - Is it correct to have I2C_FUNC_SMBUS_EMUL in .functionality without
>    supporting I2C_M_RECV_LEN?

Yes. Check the #define and you'll see that it does not contain
BLOCK_READ and BLOCK_PROC_CALL.

All the best,

   Wolfram
