From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH v3 1/2] i2c: add DMA support for freescale i2c driver
Date: Wed, 26 Mar 2014 07:26:36 +0100
Message-ID: <201403260726.36812.marex@denx.de>
References: <1394675277-24913-1-git-send-email-yao.yuan@freescale.com> <201403260442.42970.marex@denx.de> <cd88de7e04734400b897c0e2bcf07eab@BL2PR03MB338.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cd88de7e04734400b897c0e2bcf07eab-AZ66ij2kwaZYLYlmg7qx2OO6mTEJWrR4XA4E9RH9d+qIuWR1G4zioA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Yao Yuan <yao.yuan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: "wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org" <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wednesday, March 26, 2014 at 06:56:34 AM, Yao Yuan wrote:
> On Wednesday, March 26, 2014 at 11:43:27 AM, Marek Vasut wrote:
> > On Wednesday, March 26, 2014 at 04:08:27 AM, Yao Yuan wrote:
> > 
> > [...]
> > 
> > > > > +		i2c_imx->use_dma = false;
> > > > > +	} else if (i2c_imx_dma_request(i2c_imx, (dma_addr_t)phy_addr))
> > 
> > {
> > 
> > > > > +		dev_info(&pdev->dev,
> > > > > +				"can't request dma chan, faild use dma.
\n");
> > > > > +		i2c_imx->use_dma = false;
> > > > > +	} else {
> > > > > +		i2c_imx->use_dma = true;
> > > > > +	}
> > > > 
> > > > Can you not just check if i2c_imx->dma is valid pointer or NULL
> > 
> > pointer ?
> > 
> > > > Then you won't need a separate variable, for this purpose ... right ?
> > > 
> > > Sorry and I think what I know is just to check whether it is NULL.
> > > Then for the second question, maybe there are some other ways, But I
> > > think it is more tidy and easier understanding for using a separate
> > > variable, for this purpose.
> > 
> > You are just wasting space and duplicating data, unless I am wrong.
> 
> Well, Do you have a better idea? Although I think it's necessary.

I think we disconnected here, sorry. Why can you not use (i2c_imx->dma != NULL) 
instead of (i2c_imx->use_dma == true) please ?

Best regards,
Marek Vasut
