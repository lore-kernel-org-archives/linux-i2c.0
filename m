From: Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [CORRECTED] I2C driver supporting Moorestown and Medfield
 platform
Date: Mon, 9 Aug 2010 13:23:45 +0100
Message-ID: <20100809132345.44fdbaea@linux.intel.com>
References: <20100803143431.23655.31975.stgit@localhost.localdomain>
	<4C5FDFA9.60703@fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4C5FDFA9.60703-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

> I would much prefer this to be called i2c-moorsetown, we have modern
> systems which can handle >8 character names.

Moorestown. Everything else in the kernel uses 'mrst' so this would
make the driver differ from the rest of the tree. I don't care too much
what its called. Given its now for Medfield etc as well it probably
should be i2c_intel_mid to match the rest of the kernel

> Hmm, if this is a synopsys block, then is it a standard one and if so
> can we get some standard support?

See other reply on this one.

> > +static inline u32 mrst_i2c_read(void __iomem *reg)
> > +{
> > +	return __raw_readl(reg);
> > +}
> 
> ioremap, but using __raw_read and __raw_write? readl/writel
> should be used. if they can't be used, then please explain
> why.

Good point. I think this is an escapee from early stuff will double
check.

> > +	if ((p1->flags ^ p2->flags) & I2C_M_TEN)
> > +		return 1;
> > +	return 0;
> > +}
> 
> would have been better to return bool.

Can do but most of the kernel never uses bool so again it would be a
quirky style. If its preferred i2c style no problem.


> > +	for (i = 0; i < length; i++)
> > +		mrst_i2c_write(i2c->base + IC_DATA_CMD,
> > +			       (uint16_t)(*(buf + i)));
> 
> you say length in bytes, but write u16?
> also, would be neater to have a u16 *buf?

Ermm no - that would be most peculiar as you'd then only send every
alternate byte of data. Then again the cast ought to be implied by the
types of mrst_i2c_write - will review


> > +	mutex_init(&mrst->lock);
> > +	init_completion(&mrst->complete);
> > +	err = request_irq(dev->irq, mrst_i2c_isr, IRQF_DISABLED,
> > +			  mrst->adap.name, mrst);
> 
> are you sure you want this, IRQF_DISABLED is marked DEPRECATED.

Will review - I don't think it's needed.


> > +	struct mrst_i2c_private *mrst = (struct mrst_i2c_private *)
> > +					pci_get_drvdata(dev);
> 
> no need to cast.

Yep

> 
> > +	{PCI_VDEVICE(INTEL, 0x082E), 2 },
> > +	{0,}
> 
> style, "{ "

Ok

Alan
