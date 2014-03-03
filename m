From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH 1/3] i2c: add DMA support for freescale i2c driver
Date: Mon, 3 Mar 2014 12:14:12 +0100
Message-ID: <201403031214.12605.marex@denx.de>
References: <1393481115-22136-1-git-send-email-yao.yuan@freescale.com> <201402272139.36076.marex@denx.de> <3bbad0af0bc74f04bc386b141dadedb3@BL2PR03MB338.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <3bbad0af0bc74f04bc386b141dadedb3-AZ66ij2kwaZYLYlmg7qx2OO6mTEJWrR4XA4E9RH9d+qIuWR1G4zioA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Yao Yuan <yao.yuan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org" <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Monday, March 03, 2014 at 11:23:33 AM, Yao Yuan wrote:
> Hi, Marek
> 
> Marek Vasut wrote:
> > On Thursday, February 27, 2014 at 07:05:14 AM, Yuan Yao wrote:
> > 
> > [...]
> > 
> > > +static void i2c_imx_dma_free(struct imx_i2c_struct *i2c_imx) {
> > > +	struct imx_i2c_dma *dma = i2c_imx->dma;
> > > +	struct dma_chan *dma_chan;
> > > +
> > > +	dma_chan = dma->chan_tx;
> > > +	dma->chan_tx = NULL;
> > > +	dma->buf_tx = 0;
> > > +	dma->len_tx = 0;
> > > +	dma_release_channel(dma_chan);
> > > +
> > > +	dma_chan = dma->chan_rx;
> > > +	dma->chan_tx = NULL;
> > > +	dma->buf_rx = 0;
> > > +	dma->len_rx = 0;
> > > +	dma_release_channel(dma_chan);
> > 
> > You must make _DEAD_ _SURE_ this function is not ever called while the
> > DMA is still active. In your case, I have a feeling that's not handled.
> 
> Thanks for your attention.
> This few days I look up the code for the realization of
> dma_release_channel(). I found that it will disable the dma request first.
> So it's may safe. And drivers hadn't check whether dma is still active
> before dma_release_channel() as a usually usage. Because it will be
> disabled automatic.
> 
> The only problem is that, it will be forced to cancel the transfer which
> was not yet completed. Looking forward to hearing from you.

OK

Best regards,
Marek Vasut
