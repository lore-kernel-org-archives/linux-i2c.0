From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c: allow specifying separate wakeup interrupt in
 device tree
Date: Mon, 3 Aug 2015 13:02:46 -0700
Message-ID: <20150803200246.GB38878@dtor-ws>
References: <20150730201431.GA5255@dtor-ws>
 <55BB54B1.80603@ti.com>
 <20150803102121.GO16878@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150803102121.GO16878-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Tony,

On Mon, Aug 03, 2015 at 03:21:21AM -0700, Tony Lindgren wrote:
> * Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org> [150731 04:00]:
> > On 07/31/2015 01:44 AM, Dmitry Torokhov wrote:
> > > Instead of having each i2c driver individually parse device tree data in
> > > case it or platform supports separate wakeup interrupt, and handle
> > > enabling and disabling wakeup interrupts in their power management
> > > routines, let's have i2c core do that for us.
> 
> Good idea, yes the dedicated wake-up interrupts can be handled
> at the bus level to keep device drivers generic.
> 
> One question below though..
> 
> > > @@ -639,11 +640,13 @@ static int i2c_device_probe(struct device *dev)
> > >  	if (!client->irq) {
> > >  		int irq = -ENOENT;
> > >  
> > > -		if (dev->of_node)
> > > -			irq = of_irq_get(dev->of_node, 0);
> > > -		else if (ACPI_COMPANION(dev))
> > > +		if (dev->of_node) {
> > > +			irq = of_irq_get_byname(dev->of_node, "irq");
> > > +			if (irq == -EINVAL || irq == -ENODATA)
> > > +				irq = of_irq_get(dev->of_node, 0);
> > > +		} else if (ACPI_COMPANION(dev)) {
> > >  			irq = acpi_dev_gpio_irq_get(ACPI_COMPANION(dev), 0);
> > > -
> > > +		}
> > >  		if (irq == -EPROBE_DEFER)
> > >  			return irq;
> > >  		if (irq < 0)
> > > @@ -659,20 +662,47 @@ static int i2c_device_probe(struct device *dev)
> > >  	if (!device_can_wakeup(&client->dev))
> > >  		device_init_wakeup(&client->dev,
> > >  					client->flags & I2C_CLIENT_WAKE);
> > > +
> > > +	if (device_can_wakeup(&client->dev)) {
> > > +		int wakeirq = -ENOENT;
> > > +
> > > +		if (dev->of_node) {
> > > +			wakeirq = of_irq_get_byname(dev->of_node, "wakeup");
> > > +			if (wakeirq == -EPROBE_DEFER)
> > > +				return wakeirq;
> > > +		}
> > > +
> > > +		if (wakeirq > 0 && wakeirq != client->irq)
> > > +			status = dev_pm_set_dedicated_wake_irq(dev, wakeirq);
> > > +		else if (client->irq > 0)
> > > +			status = dev_pm_set_wake_irq(dev, wakeirq);
> > > +		else
> > > +			status = 0;
> 
> Hmm why do we need the check for if (device_can_wakeup(&client->dev)))?

Because of the code in device_wakeup_attach_irq():

	ws = dev->power.wakeup;
	if (!ws) {
		dev_err(dev, "forgot to call call device_init_wakeup?\n");
		return -EINVAL;
	}

> 
> Also wondering about the dev vs &client->dev usage here.. But I take
> you have checked that we end up calling the runtime PM calls of the
> client instead of the i2c bus controller :)

dev *is* clent->dev in this context:

	struct i2c_client *client = i2c_verify_client(dev);

Thanks!

-- 
Dmitry
