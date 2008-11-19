From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [patch 2.6.27-rc7] i2c: smbalert# support
Date: Wed, 19 Nov 2008 10:08:40 -0800
Message-ID: <200811191008.41199.david-b@pacbell.net>
References: <200804161434.54335.laurentp@cse-semaphore.com> <200811181401.34809.david-b@pacbell.net> <20081119145712.1abaa63f@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20081119145712.1abaa63f-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wednesday 19 November 2008, Jean Delvare wrote:

> > +/*
> > + * The alert IRQ handler needs to hand work off to a task which can issue
> > + * SMBus calls, because those sleeping calls can't be made in IRQ context.
> > + */
> > +static void smbus_alert(struct work_struct *work)
> > +{
> > +	struct i2c_adapter	*bus;
> > +
> > +	bus = container_of(work, struct i2c_adapter, alert);
> > +	for (;;) {
> > +		s32			status;
> > +		struct alert_data	data;
> > +
> > +		/* Devices with pending alerts reply in address order, low
> > +		 * to high, because of slave transmit arbitration.  After
> > +		 * responding, an SMBus device stops asserting SMBALERT#.
> > +		 *
> > +		 * NOTE that SMBus 2.0 reserves 10-bit addresess for future
> > +		 * use.  We neither handle them, nor try to use PEC here.
> > +		 */
> > +		status = i2c_smbus_read_byte(bus->ara);
> > +		if (status < 0)
> > +			break;
> > +
> > +		data.flag = (status & 1) != 0;
> 
> This is equivalent to just "status & 1".

If you rely on "true == 1", which I always like to avoid.
I'll change that for you though, and make "flag" a u8.


> > +		data.addr = status >> 1;
> > +		dev_dbg(&bus->dev, "SMBALERT# %s from dev 0x%02x\n",
> > +				data.flag ? "true" : "false", data.addr);
> 
> The flag is really only a data bit, it has no true/false meaning, so
> presenting it that way is confusing. Please display it as 0/1 instead.

For bits, "1" == "high" == "true" is the normal convention.
But I changed it to "u8" and treat it as a number.


> > +
> > +		/* Notify driver for the device which issued the alert. */
> > +		device_for_each_child(&bus->dev, &data, i2c_do_alert);
> > +	}
> > +
> > +	/* We handled all alerts; reenable level-triggered IRQs. */
> > +	if (!bus->alert_edge_triggered)
> > +		enable_irq(bus->irq);
> > +}


> Or even better... get rid of smbalert_driver altogether and add
> { "smbus_alert", 0 } to dummy_driver instead. This will simplify the
> bookkeeping a lot.

Done.  :)


> > @@ -369,6 +375,14 @@ struct i2c_adapter {
> >  	struct list_head clients;	/* DEPRECATED */
> >  	char name[48];
> >  	struct completion dev_released;
> > +
> > +	/* SMBALERT# support */
> > +	unsigned		do_setup_alert:1;
> > +	unsigned		has_alert_irq:1;
> > +	unsigned		alert_edge_triggered:1;
> > +	int			irq;
> > +	struct i2c_client	*ara;
> > +	struct work_struct	alert;
> >  };
> >  #define to_i2c_adapter(d) container_of(d, struct i2c_adapter, dev)
> 
> It would be nice to have kernel doc for all these new struct members.

Easiest for i2c_client, which already has kerneldoc...


> I also would like you to document the new API, either in
> Documentation/i2c or Documentation/DocBook/kernel-api.tmpl, as you
> prefer. This new API is not trivial and there's only one example in the
> kernel tree at the moment (i2c-gpio) so driver authors will need
> detailed information on how to add support for SMBus alert in their bus
> and chip drivers.

OK, I'll work on that.  It won't be done this week though.

Key point:  three models for smbalert# configuration.
(a) none, don't set those new values
(b) adapter handles it, just set do_setup_alert flag and then
    schedule_work(&adapter->alert) as needed
(c) i2c-core handles it, set irq (and maybe alert_edge_triggered)

So (b) would be a missing example.

 
> As a side note, I tried to add support for SMBus alert to the
> i2c-parport driver, but I can't get it to work. I'll post my patch
> later today in case someone has an idea what I am doing wrong.

Parport IRQs ... I almost started to muck with those at one point.
Right now only one of my systems even has a parport.  ;)

- Dave
