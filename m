From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH v4 1/2] i2c: add DMA support for freescale i2c driver
Date: Fri, 4 Apr 2014 13:49:07 +0200
Message-ID: <201404041349.07721.marex@denx.de>
References: <1396579272-19542-1-git-send-email-yao.yuan@freescale.com> <1396579272-19542-2-git-send-email-yao.yuan@freescale.com> <533E8033.70904@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <533E8033.70904-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: sourav <sourav.poddar-l0cyMroinI0@public.gmane.org>
Cc: Yuan Yao <yao.yuan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Friday, April 04, 2014 at 11:49:39 AM, sourav wrote:

[...]

> > +/* Functions for DMA support */
> > +static int i2c_imx_dma_request(struct imx_i2c_struct *i2c_imx,
> > +						dma_addr_t phy_addr)
> > +{
> > +	struct imx_i2c_dma *dma;
> > +	struct dma_slave_config dma_sconfig;
> > +	struct device *dev =&i2c_imx->adapter.dev;
> > +	int ret;
> > +
> > +	dma = devm_kzalloc(dev, sizeof(struct imx_i2c_dma), GFP_KERNEL);
> > +	if (!dma) {
> > +		dev_info(dev, "can't allocate DMA struct\n");
> > +		return -ENOMEM;
> > +	}
> > +
> > +	dma->chan_tx = dma_request_slave_channel(dev, "tx");
> > +	return 0;
> 
> ?? Looks to be some leftover?

Nice find.

btw. you might want to trim the email only to the relevant parts when replying 
so it's easier to find your commments in the entire body of text.
 
> > +	if (!dma->chan_tx) {
> > +		dev_info(dev, "DMA tx channel request failed\n");
> > +		ret = -ENODEV;
> > +		goto fail_al;
> > +	}

[...]

Best regards,
Marek Vasut
