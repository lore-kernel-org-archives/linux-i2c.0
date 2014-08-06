From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: RE: [PATCH] i2c: i2c-imx: Fix format warning for dev_dbg
Date: Wed, 6 Aug 2014 03:28:23 +0000
Message-ID: <665de450db8e4edd8c76ce7175106b0d@BY2PR0301MB0613.namprd03.prod.outlook.com>
References: <1407293685-7003-1-git-send-email-Li.Xiubo@freescale.com>
 <1407294597.31231.2.camel@joe-AO725>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1407294597.31231.2.camel@joe-AO725>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: "wsa@the-dreams.de" <wsa@the-dreams.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "jg1.han@samsung.com" <jg1.han@samsung.com>, "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jingchang Lu <jingchang.lu@freescale.com>
List-Id: linux-i2c@vger.kernel.org

> > drivers/i2c/busses/i2c-imx.c: In function i2c_imx_probe()
> > drivers/i2c/busses/i2c-imx.c:689:2: warning: format 0x%x expects argument
> > of type unsigned int, but argument 4 has type resource_size_t [-Wformat=]
> >   dev_dbg(&i2c_imx->adapter.dev, "device resources from 0x%x to 0x%x\n",
> []
> > diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
> []
> > @@ -687,9 +687,9 @@ static int i2c_imx_probe(struct platform_device *pdev)
> >
> >  	dev_dbg(&i2c_imx->adapter.dev, "claimed irq %d\n", irq);
> >  	dev_dbg(&i2c_imx->adapter.dev, "device resources from 0x%x to 0x%x\n",
> > -		res->start, res->end);
> > +		(unsigned int)res->start, (unsigned int)res->end);
> 
> Probably better to use:
> 
> 	dev_dbg(&i2c_imx->adapter.dev, "device resources: %pR\n, res);
> 

Yes, this is perfect.

> >  	dev_dbg(&i2c_imx->adapter.dev, "allocated %d bytes at 0x%x\n",
> > -		resource_size(res), res->start);
> > +		(unsigned int)resource_size(res), (unsigned int)res->start);
> 
> and remove this.
> 

I will follow your advice.

Thanks,
BRs
Xiubo
