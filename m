From: Yao Yuan <yao.yuan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCH v9 3/3] i2c: imx: add DMA support for freescale i2c driver
Date: Mon, 17 Nov 2014 10:41:56 +0000
Message-ID: <BL2PR03MB33877C76779D5588D1B3E30838B0@BL2PR03MB338.namprd03.prod.outlook.com>
References: <1413025032-14958-1-git-send-email-yao.yuan@freescale.com>
 <1413025032-14958-4-git-send-email-yao.yuan@freescale.com>
 <20141108173513.GA4900@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141108173513.GA4900@katana>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: "marex-ynQEQJNshbs@public.gmane.org" <marex-ynQEQJNshbs@public.gmane.org>, "LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org" <LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "fugang.duan-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <fugang.duan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Thanks for your review.
Your suggestions is really helpful.

I will correct them in v10.

Best Regards,
Yuan Yao

> -----Original Message-----
> From: Wolfram Sang [mailto:wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org]
> Sent: Sunday, November 09, 2014 1:35 AM
> To: Yuan Yao-B46683
> Cc: marex-ynQEQJNshbs@public.gmane.org; LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org; mark.rutland-5wv7dgnIgG8@public.gmane.org; Duan
> Fugang-B38611; shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-
> arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org; linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Subject: Re: [PATCH v9 3/3] i2c: imx: add DMA support for freescale i2c
> driver
> 
> Hi,
> 
> mostly looking good...
> 
> > +#define IMX_I2C_DMA_THRESHOLD	16
> 
> Have you guessed or measured this value? A comment about this value would
> be nice.
> 
> >
> > +struct imx_i2c_dma {
> > +	struct dma_chan		*chan_tx;
> > +	struct dma_chan		*chan_rx;
> > +	struct dma_chan		*chan_using;
> > +	struct completion	cmd_complete;
> > +	dma_addr_t		dma_buf;
> > +	unsigned int		dma_len;
> > +	unsigned int		dma_transfer_dir;
> > +	unsigned int		dma_data_dir;
> 
> Please use proper types as there are things like 'enum
> dma_data_direction' and the likes...
> 
> > +	dmaengine_submit(txdesc);
> 
> This can fail, too. Use dma_submit_error() to check.
> 
> > +	result = wait_for_completion_interruptible_timeout(
> > +				&i2c_imx->dma->cmd_complete,
> > +				msecs_to_jiffies(IMX_I2C_DMA_TIMEOUT));
> 
> Have you tested signals extensively? I can't really recommend the
> _intrruptible_ here. I don't see any cleaning up to get the bus to a
> consistent state again. Most people drop the interruptible sooner or
> later.
> 
> > +	/* Init DMA config if support*/
> > +	i2c_imx_dma_request(i2c_imx, phy_addr);
> 
> Make this function void? DMA is optional anyhow.
> 
> Thanks,
> 
>    Wolfram
