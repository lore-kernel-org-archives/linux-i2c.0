From: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/3] i2c: add DMA support for freescale i2c driver
Date: Fri, 28 Feb 2014 10:23:52 +0800
Message-ID: <20140228022348.GB28660@S2101-09.ap.freescale.net>
References: <1393481115-22136-1-git-send-email-yao.yuan@freescale.com>
 <1393481115-22136-2-git-send-email-yao.yuan@freescale.com>
 <201402272139.36076.marex@denx.de>
 <20140228021300.GJ13537@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140228021300.GJ13537-rvtDTF3kK1ictlrPMvKcciBecyulp+rMXqFh9Ls21Oc@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Yuan Yao <yao.yuan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, Feb 28, 2014 at 10:13:02AM +0800, Shawn Guo wrote:
> On Thu, Feb 27, 2014 at 09:39:35PM +0100, Marek Vasut wrote:
> > > @@ -193,6 +216,7 @@ static const struct imx_i2c_hwdata imx1_i2c_hwdata  = {
> > >  	.ndivs			= ARRAY_SIZE(imx_i2c_clk_div),
> > >  	.i2sr_clr_opcode	= I2SR_CLR_OPCODE_W0C,
> > >  	.i2cr_ien_opcode	= I2CR_IEN_OPCODE_1,
> > > +	.has_dma_support	= false,
> > > 
> > >  };
> > > 
> > > @@ -203,6 +227,7 @@ static const struct imx_i2c_hwdata imx21_i2c_hwdata  =
> > > { .ndivs			= ARRAY_SIZE(imx_i2c_clk_div),
> > >  	.i2sr_clr_opcode	= I2SR_CLR_OPCODE_W0C,
> > >  	.i2cr_ien_opcode	= I2CR_IEN_OPCODE_1,
> > > +	.has_dma_support	= false,
> > > 
> > >  };
> > > 
> > > @@ -213,6 +238,7 @@ static struct imx_i2c_hwdata vf610_i2c_hwdata = {
> > >  	.ndivs			= ARRAY_SIZE(vf610_i2c_clk_div),
> > >  	.i2sr_clr_opcode	= I2SR_CLR_OPCODE_W1C,
> > >  	.i2cr_ien_opcode	= I2CR_IEN_OPCODE_0,
> > > +	.has_dma_support	= true,
> > 
> > So why exactly don't we have a DT prop for determining whether the controller 
> > has DMA support ?
> 
> Using DMA or PIO is a decision that should be made by driver on its own,
> not device tree.

Sorry.  I misunderstood it.  Yes, we can look at the DT property 'dmas'
to know if the controller has DMA capability.

Shawn
