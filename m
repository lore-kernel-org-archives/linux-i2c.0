From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c: allow specifying separate wakeup interrupt in
 device tree
Date: Sun, 9 Aug 2015 22:59:36 -0700
Message-ID: <20150810055936.GB26735@dtor-ws>
References: <20150730201431.GA5255@dtor-ws>
 <20150809152255.GA2367@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150809152255.GA2367@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sun, Aug 09, 2015 at 05:22:55PM +0200, Wolfram Sang wrote:
> On Thu, Jul 30, 2015 at 01:14:31PM -0700, Dmitry Torokhov wrote:
> > Instead of having each i2c driver individually parse device tree data in
> > case it or platform supports separate wakeup interrupt, and handle
> > enabling and disabling wakeup interrupts in their power management
> > routines, let's have i2c core do that for us.
> > 
> > Platforms wishing to specify separate wakeup interrupt for the device
> > should use named interrupt syntax in their DTSes:
> > 
> > 	interrupt-parent = <&intc1>;
> > 	interrupts = <5 0>, <6 0>;
> > 	interrupt-names = "irq", "wakeup";
> > 
> > This patch is inspired by work done by Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org> for
> > pixcir_i2c_ts driver.
> > 
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> 
> I think it is a useful addition. Can someone add a paragraph describing
> this handling on top of the new generic i2c binding docs?
> 
> http://patchwork.ozlabs.org/patch/505368/

Yes, I will.

> 
> > @@ -659,20 +662,47 @@ static int i2c_device_probe(struct device *dev)
> >  	if (!device_can_wakeup(&client->dev))
> >  		device_init_wakeup(&client->dev,
> >  					client->flags & I2C_CLIENT_WAKE);
> 
> I was about to ask if we couldn't combine this and the later if-blocks
> with an if-else combination. But now I stumble over the above block in
> general: If the device cannot cause wake ups, then we might initialize
> it as a wakeup-device depending on client->flags??

I believe it is done so that we do not try to re-add wakeup source after
unbinding/rebinding the device. With my patch we clearing wakeup flag on
unbind, so it is OK, but there is still error path where we might want
to reset the wakeup flag as well.

> 
> > +
> > +	if (device_can_wakeup(&client->dev)) {
> > +		int wakeirq = -ENOENT;
> > +
> > +		if (dev->of_node) {
> > +			wakeirq = of_irq_get_byname(dev->of_node, "wakeup");
> > +			if (wakeirq == -EPROBE_DEFER)
> > +				return wakeirq;
> > +		}
> > +
> > +		if (wakeirq > 0 && wakeirq != client->irq)
> > +			status = dev_pm_set_dedicated_wake_irq(dev, wakeirq);
> > +		else if (client->irq > 0)
> > +			status = dev_pm_set_wake_irq(dev, wakeirq);
> > +		else
> > +			status = 0;
> > +
> > +		if (status)
> > +			dev_warn(&client->dev, "failed to set up wakeup irq");
> > +	}
> > +
> >  	dev_dbg(dev, "probe\n");
> >  
> >  	status = of_clk_set_defaults(dev->of_node, false);
> >  	if (status < 0)
> > -		return status;
> > +		goto err_clear_wakeup_irq;
> >  
> >  	status = dev_pm_domain_attach(&client->dev, true);
> >  	if (status != -EPROBE_DEFER) {
> >  		status = driver->probe(client, i2c_match_id(driver->id_table,
> >  					client));
> >  		if (status)
> > -			dev_pm_domain_detach(&client->dev, true);
> > +			goto err_detach_pm_domain;
> >  	}
> >  
> > +	return 0;
> > +
> > +err_detach_pm_domain:
> > +	dev_pm_domain_detach(&client->dev, true);
> > +err_clear_wakeup_irq:
> > +	dev_pm_clear_wake_irq(&client->dev);
> >  	return status;
> >  }
> >  
> > @@ -692,6 +722,10 @@ static int i2c_device_remove(struct device *dev)
> >  	}
> >  
> >  	dev_pm_domain_detach(&client->dev, true);
> > +
> > +	dev_pm_clear_wake_irq(&client->dev);
> > +	device_init_wakeup(&client->dev, 0);
> > +
> >  	return status;
> >  }
> >  
> > -- 
> > 2.5.0.rc2.392.g76e840b
> > 
> > 
> > -- 
> > Dmitry

Thanks.

-- 
Dmitry
