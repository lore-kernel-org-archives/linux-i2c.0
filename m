From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] i2c: mxs: Fix misuse init_completion
Date: Wed, 23 Jan 2013 10:55:21 +0100
Message-ID: <20130123095521.GB3767@nekote.pengutronix.de>
References: <1353475146-28669-1-git-send-email-marex@denx.de>
 <201301210447.46939.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201301210447.46939.marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marek Vasut <marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


> > The init_completion() call does reinit not only the variable carrying
> > the flag that the completion finished, but also initialized the
> > waitqueue associated with the completion. On the contrary, the
> > INIT_COMPLETION() call only reinits the flag.
> > 
> > In case there was anything still stuck in the waitqueue, subsequent call
> > to init_completion() would be able to create possible race condition. This
> > patch uses the proper function and moves init_completion() into .probe()
> > call of the driver, to be issued only once.
> > 
> > Note that such scenario is impossible, since two threads can never enter
> > the mxs_i2c_xfer_msg(), since whole this section is protected by mutex in
> > I2C core. This by no means allows this issue to exit though.
> > 
> > Signed-off-by: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
> > Cc: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> > Cc: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> > Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> 
> Why is this not applied / not in stable please?

Thanks, applied. It will go to 3.8 but not to stable, since it is not
really a bugfix as you also mentioned.

> Also, what about the other MXS I2C patches?

Pending, obviously. New next branch probably this weekend.

Thanks,

   Wolfram
