From: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] i2c: add i2c adapter driver for i.MX3x SoCs
Date: Mon, 10 Nov 2008 12:57:14 +0100
Message-ID: <20081110115714.GD4511@pengutronix.de>
References: <Pine.LNX.4.64.0811071857460.4513@axis700.grange> <20081110110431.GA4511@pengutronix.de> <Pine.LNX.4.64.0811101214090.4248@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0811101214090.4248-0199iw4Nj15frtckUFj5Ag@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guennadi Liakhovetski <lg-ynQEQJNshbs@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Nov 10, 2008 at 12:30:07PM +0100, Guennadi Liakhovetski wrote:
> Hi Sascha,
> 
> Thanks for the comments,
> 
> On Mon, 10 Nov 2008, Sascha Hauer wrote:
> 
> > > +static struct resource mxci2c1_resources[] = {
> > > +	[0] = {
> > > +		.start = I2C_BASE_ADDR,
> > > +		.end = I2C_BASE_ADDR + SZ_4K - 1,
> > > +		.flags = IORESOURCE_MEM,
> > > +	}, [1] = {
> > > +		.start = MXC_INT_I2C,
> > > +		.end = MXC_INT_I2C,
> > > +		.flags = IORESOURCE_IRQ,
> > > +	},
> > > +};
> > 
> > Can we drop the [0] and [1]? gcc knows how to count.
> 
> I certainly hope so too:-) I normally only use indices in array 
> initialisations when they are important, however, here this is not the 
> case. Will drop.
> 
> > > +{
> > > +	switch (i2c_num) {
> > > +	case 0:
> > > +		mxc_iomux_mode(IOMUX_MODE(MX31_PIN_I2C_CLK, IOMUX_CONFIG_FUNC));
> > > +		mxc_iomux_mode(IOMUX_MODE(MX31_PIN_I2C_DAT, IOMUX_CONFIG_FUNC));
> > > +		break;
> > > +	case 1:
> > > +		mxc_iomux_mode(IOMUX_MODE(MX31_PIN_CSPI2_MOSI, IOMUX_CONFIG_ALT1));
> > > +		mxc_iomux_mode(IOMUX_MODE(MX31_PIN_CSPI2_MISO, IOMUX_CONFIG_ALT1));
> > > +		break;
> > > +	case 2:
> > > +		mxc_iomux_mode(IOMUX_MODE(MX31_PIN_CSPI2_SS2, IOMUX_CONFIG_ALT1));
> > > +		mxc_iomux_mode(IOMUX_MODE(MX31_PIN_CSPI2_SCLK, IOMUX_CONFIG_ALT1));
> > > +	}
> > > +}
> > 
> > This should be moved to the platform part. You make the driver MX31
> > specific with this.
> 
> First, even though the driver is called (also in Freescale sources) "mxc," 
> I am not sure which other *mx* SoCs have the same i2c controller, do you 
> know that? So, it might anyway _be_ i.MX3* specific.

It works at least on MX2 (where I use a variant of this driver) and
should work on MX1 which has the same register layout.

> Next, I could just 
> configure pins in i2c platform device registration code, but I don't know 
> if anyone ever comes up with an idea to dynamically switch between, say, 
> I2C #2 and SPI #2...

Sounds unlikely.

> Shall I make this a platform hook?

I asked myself whether it was worth the effort to implement a platform
hook for each and every device instead of just creating a long list of
pins and just configure them during board initialization. But this might
get interesting when it comes to powermanagement. So a platform hook
seems good, boards are still free to ignore the platform hooks and use a
list instead.

> 
> > Also, care to update the macros in iomux-mx3.h
> > instead of constructing the pin definitions directly using IOMUX_MODE?
> > (btw how is the general feeling about these macros? I really like it
> > using these macros since I don't have to read the datasheet to lookup up
> > a specific pin, but I may be the only one)
> 
> You mean these:
> 
> /*
>  * Convenience values for use with mxc_iomux_mode()
>  *
>  * Format here is MX31_PIN_(pin name)__(function)
>  */
> #define MX31_PIN_CSPI3_MOSI__RXD3	IOMUX_MODE(MX31_PIN_CSPI3_MOSI, IOMUX_CONFIG_ALT1)
> ...
> 
> ? Well, I usually only define macros if they are used more than once. If a 
> value is used only once I usually don't bother... But if you like, I can 
> define them, sure.

Well, they are used once for every board implementing I2C.

> 
> > > +/**
> > > + * Function enables the I2C module and initializes the registers.
> > > + *
> > > + * @param   dev   the mxc i2c structure used to get to the right i2c device
> > > + * @param   trans_flag  transfer flag
> > > + */
> > > +static void mxc_i2c_module_en(struct mxc_i2c_device *dev, int trans_flag)
> > > +{
> > > +	clk_enable(dev->clk);
> > > +	/* Set the frequency divider */
> > > +	writew(dev->clkdiv, dev->membase + MXC_IFDR);
> > 
> > Can't we do this only once during probe()?
> 
> Hm, would have to test...
> 
> I'll address your other comments in the next version too.

Thank you

Sascha

-- 
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
