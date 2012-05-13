From: "Jayachandran C." <jayachandranc-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c-ocore: support 16 and 32-bit wide registers
Date: Sun, 13 May 2012 17:09:34 +0530
Message-ID: <20120513113933.GA22906@jayachandranc.netlogicmicro.com>
References: <1336483529-19140-1-git-send-email-jayachandranc@netlogicmicro.com>
 <1336483529-19140-3-git-send-email-jayachandranc@netlogicmicro.com>
 <20120512145648.GM20673@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120512145648.GM20673-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, Ganesan Ramalingam <ganesanr-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, devicetree-discuss-mnsaURCQ41sdnm+yROfE0A@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sat, May 12, 2012 at 04:56:48PM +0200, Wolfram Sang wrote:
> On Tue, May 08, 2012 at 06:55:29PM +0530, Jayachandran C wrote:
> > From: Ganesan Ramalingam <ganesanr-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
> > 
> > Some architectures supports only 16-bit or 32-bit read/write access
> > to their iospace. Add a 'regwidth' platform and OF parameter which
> > specifies the IO width to support these platforms.
> > 
> > regwidth can be specified as 1, 2 or 4, and has a default value
> > of 1 if it is unspecified.
> > 
> > Signed-off-by: Ganesan Ramalingam <ganesanr-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
> > Signed-off-by: Jayachandran C <jayachandranc-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org>
> 
> Hmm, this is a generic issue and should not be handled with a driver
> specific property. CCing devicetree-discuss, maybe there is already a
> way to handle this? The already existing 'regstep' looks suspicious, too?
> Can't find any documentation for it.

My suggestion would be to use "reg-shift" and "reg-io-width" like the
uart and some other devices. I am not sure why "regstep" was used when
there is already a standard "reg-shift" parameter.

We will post an updated patch that deprecates "regstep" and uses "reg-shift"
and "reg-io-width" if that is preferred.

Thanks,
JC.

> 
> > ---
> >  drivers/i2c/busses/i2c-ocores.c |   32 ++++++++++++++++++++++++++++++--
> >  include/linux/i2c-ocores.h      |    1 +
> >  2 files changed, 31 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
> > index ebd2700..1313145 100644
> > --- a/drivers/i2c/busses/i2c-ocores.c
> > +++ b/drivers/i2c/busses/i2c-ocores.c
> > @@ -19,6 +19,9 @@
> >   * - regstep         : size of device registers in bytes
> >   * - clock-frequency : frequency of bus clock in Hz
> >   * 
> > + * Optional properties:
> > + * - regwidth        : io register width in bytes (1, 2 or 4)
> > +
> >   * Example:
> >   *
> >   *  i2c0: ocores@a0000000 {
> > @@ -27,6 +30,7 @@
> >   *              interrupts = <10>;
> >   *
> >   *              regstep = <1>;
> > + *              regwidth = <1>;
> >   *              clock-frequency = <20000000>;
> >   *
> >   * -- Devices connected on this I2C bus get
> > @@ -60,6 +64,7 @@
> >  struct ocores_i2c {
> >  	void __iomem *base;
> >  	int regstep;
> > +	int regwidth;
> >  	wait_queue_head_t wait;
> >  	struct i2c_adapter adap;
> >  	struct i2c_msg *msg;
> > @@ -102,12 +107,22 @@ struct ocores_i2c {
> >  
> >  static inline void oc_setreg(struct ocores_i2c *i2c, int reg, u8 value)
> >  {
> > -	iowrite8(value, i2c->base + reg * i2c->regstep);
> > +	if (i2c->regwidth == 4)
> > +		iowrite32(value, i2c->base + reg * i2c->regstep);
> > +	else if (i2c->regwidth == 2)
> > +		iowrite16(value, i2c->base + reg * i2c->regstep);
> > +	else
> > +		iowrite8(value, i2c->base + reg * i2c->regstep);
> >  }
> >  
> >  static inline u8 oc_getreg(struct ocores_i2c *i2c, int reg)
> >  {
> > -	return ioread8(i2c->base + reg * i2c->regstep);
> > +	if (i2c->regwidth == 4)
> > +		return ioread32(i2c->base + reg * i2c->regstep);
> > +	else if (i2c->regwidth == 2)
> > +		return ioread16(i2c->base + reg * i2c->regstep);
> > +	else
> > +		return ioread8(i2c->base + reg * i2c->regstep);
> >  }
> >  
> >  static void ocores_process(struct ocores_i2c *i2c)
> > @@ -267,6 +282,10 @@ static int ocores_i2c_of_probe(struct platform_device* pdev,
> >  	}
> >  	i2c->clock_khz = be32_to_cpup(val) / 1000;
> >  
> > +	val = of_get_property(pdev->dev.of_node, "regwidth", NULL);
> > +	if (val)
> > +		i2c->regwidth = be32_to_cpup(val);
> > +
> >  	return 0;
> >  }
> >  #else
> > @@ -309,12 +328,21 @@ static int __devinit ocores_i2c_probe(struct platform_device *pdev)
> >  	pdata = pdev->dev.platform_data;
> >  	if (pdata) {
> >  		i2c->regstep = pdata->regstep;
> > +		i2c->regwidth = pdata->regwidth;
> >  		i2c->clock_khz = pdata->clock_khz;
> >  	} else {
> >  		ret = ocores_i2c_of_probe(pdev, i2c);
> >  		if (ret)
> >  			return ret;
> >  	}
> > +	if (i2c->regwidth == 0)
> > +		i2c->regwidth = 1;	/* not configured, use default */
> > +	else if (i2c->regwidth != 1 && i2c->regwidth != 2 &&
> > +			i2c->regwidth != 4) {
> > +		dev_err(&pdev->dev, "Invalid register width %d\n",
> > +			i2c->regwidth);
> > +		return -EINVAL;
> > +	}
> >  
> >  	ocores_init(i2c);
> >  
> > diff --git a/include/linux/i2c-ocores.h b/include/linux/i2c-ocores.h
> > index 4d5e57f..d1258ad 100644
> > --- a/include/linux/i2c-ocores.h
> > +++ b/include/linux/i2c-ocores.h
> > @@ -13,6 +13,7 @@
> >  
> >  struct ocores_i2c_platform_data {
> >  	u32 regstep;   /* distance between registers */
> > +	u32 regwidth;  /* io read/write register witdth */
> >  	u32 clock_khz; /* input clock in kHz */
> >  	u8 num_devices; /* number of devices in the devices list */
> >  	struct i2c_board_info const *devices; /* devices connected to the bus */
> > -- 
> > 1.7.9.5
> > 
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> > the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> -- 
> Pengutronix e.K.                           | Wolfram Sang                |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
