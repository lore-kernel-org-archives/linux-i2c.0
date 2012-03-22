From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c: Dynamically assign adapter id if it wasn't
	explictly specified
Date: Thu, 22 Mar 2012 16:11:34 +0000
Message-ID: <20120322161134.GA1577@n2100.arm.linux.org.uk>
References: <1331900343-6743-1-git-send-email-k.lewandowsk@samsung.com> <1331900343-6743-3-git-send-email-k.lewandowsk@samsung.com> <4F6B4532.7090806@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4F6B4532.7090806-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Karol Lewandowski <k.lewandowsk-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, hskinnemoen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Rade Bozic <rade.bozic.ext-OYasijW0DpE@public.gmane.org>, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, David Daney <ddaney-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Mar 22, 2012 at 04:28:50PM +0100, Karol Lewandowski wrote:
> Dear Haavard, Rade, Wolfram and Russel
> 
> Could you review following changes for gpio, octeon, pca-platform
> and versatile i2c controller drivers (for which you are, or were,
> maintainers)?
> 
> Grant requested explicit Ack to get this merged.

All I have is the patch below, which doesn't make sense on its own.  Where
is patch 1, which is presumably the core changes ?

> 
> Thanks!
> 
> > 
> > diff --git a/drivers/i2c/busses/i2c-gpio.c b/drivers/i2c/busses/i2c-gpio.c
> > index a651779..50a2a94 100644
> > --- a/drivers/i2c/busses/i2c-gpio.c
> > +++ b/drivers/i2c/busses/i2c-gpio.c
> > @@ -144,12 +144,7 @@ static int __devinit i2c_gpio_probe(struct platform_device *pdev)
> >  	adap->class = I2C_CLASS_HWMON | I2C_CLASS_SPD;
> >  	adap->dev.parent = &pdev->dev;
> >  
> > -	/*
> > -	 * If "dev->id" is negative we consider it as zero.
> > -	 * The reason to do so is to avoid sysfs names that only make
> > -	 * sense when there are multiple adapters.
> > -	 */
> > -	adap->nr = (pdev->id != -1) ? pdev->id : 0;
> > +	adap->nr = pdev->id;
> >  	ret = i2c_bit_add_numbered_bus(adap);
> >  	if (ret)
> >  		goto err_add_bus;
> > diff --git a/drivers/i2c/busses/i2c-octeon.c b/drivers/i2c/busses/i2c-octeon.c
> > index ee139a5..8470232 100644
> > --- a/drivers/i2c/busses/i2c-octeon.c
> > +++ b/drivers/i2c/busses/i2c-octeon.c
> > @@ -581,7 +581,7 @@ static int __devinit octeon_i2c_probe(struct platform_device *pdev)
> >  
> >  	i2c->adap = octeon_i2c_ops;
> >  	i2c->adap.dev.parent = &pdev->dev;
> > -	i2c->adap.nr = pdev->id >= 0 ? pdev->id : 0;
> > +	i2c->adap.nr = pdev->id;
> >  	i2c_set_adapdata(&i2c->adap, i2c);
> >  	platform_set_drvdata(pdev, i2c);
> >  
> > diff --git a/drivers/i2c/busses/i2c-pca-platform.c b/drivers/i2c/busses/i2c-pca-platform.c
> > index 2adbf1a..675878f 100644
> > --- a/drivers/i2c/busses/i2c-pca-platform.c
> > +++ b/drivers/i2c/busses/i2c-pca-platform.c
> > @@ -171,7 +171,7 @@ static int __devinit i2c_pca_pf_probe(struct platform_device *pdev)
> >  	i2c->io_size = resource_size(res);
> >  	i2c->irq = irq;
> >  
> > -	i2c->adap.nr = pdev->id >= 0 ? pdev->id : 0;
> > +	i2c->adap.nr = pdev->id;
> >  	i2c->adap.owner = THIS_MODULE;
> >  	snprintf(i2c->adap.name, sizeof(i2c->adap.name),
> >  		 "PCA9564/PCA9665 at 0x%08lx",
> > diff --git a/drivers/i2c/busses/i2c-versatile.c b/drivers/i2c/busses/i2c-versatile.c
> > index 6055601..9458568 100644
> > --- a/drivers/i2c/busses/i2c-versatile.c
> > +++ b/drivers/i2c/busses/i2c-versatile.c
> > @@ -102,13 +102,8 @@ static int i2c_versatile_probe(struct platform_device *dev)
> >  	i2c->algo = i2c_versatile_algo;
> >  	i2c->algo.data = i2c;
> >  
> > -	if (dev->id >= 0) {
> > -		/* static bus numbering */
> > -		i2c->adap.nr = dev->id;
> > -		ret = i2c_bit_add_numbered_bus(&i2c->adap);
> > -	} else
> > -		/* dynamic bus numbering */
> > -		ret = i2c_bit_add_bus(&i2c->adap);
> > +	i2c->adap.nr = dev->id;
> > +	ret = i2c_bit_add_numbered_bus(&i2c->adap);
> >  	if (ret >= 0) {
> >  		platform_set_drvdata(dev, i2c);
> >  		return 0;
> 
> 
> 
> -- 
> Karol Lewandowski | Samsung Poland R&D Center | Linux/Platform
