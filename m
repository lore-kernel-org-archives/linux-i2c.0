From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH v2 1/2] i2c: add DMA support for freescale i2c driver
Date: Thu, 6 Mar 2014 05:41:21 +0100
Message-ID: <201403060541.21665.marex@denx.de>
References: <1394002352-8380-1-git-send-email-yao.yuan@freescale.com> <201403060339.45611.marex@denx.de> <1c0c5f2ce69849d4bf482601ac431da6@BL2PR03MB338.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1c0c5f2ce69849d4bf482601ac431da6-AZ66ij2kwaZYLYlmg7qx2OO6mTEJWrR4XA4E9RH9d+qIuWR1G4zioA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Yao Yuan <yao.yuan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: "wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org" <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thursday, March 06, 2014 at 05:36:14 AM, Yao Yuan wrote:
> On Thu, March 06, 2014 at 11:23:50 AM, Marek Vasut wrote:
> > On Wednesday, March 05, 2014 at 07:52:31 AM, Yuan Yao wrote:
> > > Add dma support for i2c. This function depend on DMA driver.
> > > You can turn on it by write both the dmas and dma-name properties in
> > > dts node.
> > > 
> > > Signed-off-by: Yuan Yao <yao.yuan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> > > ---
> > 
> > [...]
> > 
> > > @@ -601,6 +826,7 @@ static int i2c_imx_probe(struct platform_device
> > 
> > *pdev)
> > 
> > >  	void __iomem *base;
> > >  	int irq, ret;
> > >  	u32 bitrate;
> > > 
> > > +	u32 phy_addr;
> > > 
> > >  	dev_dbg(&pdev->dev, "<%s>\n", __func__);
> > > 
> > > @@ -611,6 +837,7 @@ static int i2c_imx_probe(struct platform_device
> > 
> > *pdev)
> > 
> > >  	}
> > >  	
> > >  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > > 
> > > +	phy_addr = res->start;
> > 
> > Uh ... Shawn, I really think I am lost here. Don't you need to map this
> > memory before you can use it for DMA ? The DMA mapping function should
> > give you the physical address and is the right way to go about this
> > instead of pulling the address from here, no ?
> > 
> > I might be wrong here, I am rather uncertain, so please help me out.
> > Thanks!
> 
> Hi, Marek, Thanks for your suggestion.
> Here you can review the code in include/linux/ioport.h
> The resource->start describes the entity on the CPU bus as a starting
> physical address. So I thinks it can used for dma directly.

This doesn't feel right for some reason. If this is a register area, you should 
ioremap() it. If it's a memory area you do DMA to/from, you need to make sure 
you correctly flush/invalidate caches and properly handle the effects the write 
buffer might have. But I have a feeling you actually do DMA to/from register 
space here ?

Best regards,
Marek Vasut
