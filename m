From: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 1/2] i2c: add DMA support for freescale i2c driver
Date: Thu, 3 Apr 2014 15:37:03 +0800
Message-ID: <20140403073701.GL2801@dragon>
References: <1394675277-24913-1-git-send-email-yao.yuan@freescale.com>
 <201403260726.36812.marex@denx.de>
 <8984936f9e914442995d79039543cb58@BL2PR03MB338.namprd03.prod.outlook.com>
 <201403260826.28114.marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201403260826.28114.marex-ynQEQJNshbs@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: Yao Yuan <yao.yuan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org" <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Mar 26, 2014 at 08:26:27AM +0100, Marek Vasut wrote:
> > > I think we disconnected here, sorry. Why can you not use (i2c_imx->dma !=
> > > NULL) instead of (i2c_imx->use_dma == true) please ?
> > 
> > But there are two judge conditions. But only the "i2c_imx->dma", but also
> > whether "i2c_imx_dma_request" success.
> > 
> > "i2c_imx->use_dma == true" be equivalent to "i2c_imx->dma != NULL &&
> > !i2c_imx_dma_request()"
> 
> +       /* Init DMA config if support*/
> +       i2c_imx->dma = devm_kzalloc(&pdev->dev, sizeof(struct imx_i2c_dma),
> +                                       GFP_KERNEL);
> +       if (!i2c_imx->dma) {
> +               dev_info(&pdev->dev,
> +                               "can't allocate dma struct faild use dma.\n");
> +               i2c_imx->use_dma = false;
> +       } else if (i2c_imx_dma_request(i2c_imx, (dma_addr_t)phy_addr)) {
> +               dev_info(&pdev->dev,
> +                               "can't request dma chan, faild use dma.\n");
> +               i2c_imx->use_dma = false;
> +       } else {
> +               i2c_imx->use_dma = true;
> +       }
> 
> OK, looking at this one more time, why don't you wrap the allocation of i2c_imx-
> >dma into i2c_imx_dma_request() ? Even better, you can allocate *dma as a local 
> variable in i2c_imx_dma_request() and then assign it into i2c_imx->dma only at 
> the end of the i2c_imx_dma_request() function , at the point where you are sure 
> nothing failed. Then you can check i2c_imx->dma != NULL throughout the code to 
> check if the DMA is available, no ?
> 
> Shawn, Wolfram, am I talking nonsense or am I just not connecting ?

I'm with you, Marek.

Shawn
