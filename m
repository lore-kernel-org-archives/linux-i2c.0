From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC,PATCH] i2c: fix device_init_wakeup place
Date: Sun, 10 Aug 2008 16:04:04 -0700
Message-ID: <20080810230404.B2943B2AB@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
References: <200807291535.45689.marc.pignat@hevs.ch>
 <20080809185619.6211fbf3@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754668AbYHJW67@vger.kernel.org>
In-Reply-To: <20080809185619.6211fbf3@hyperion.delvare>
Sender: linux-kernel-owner@vger.kernel.org
To: marc.pignat@hevs.ch, khali@linux-fr.org
Cc: linux-kernel@vger.kernel.org, i2c@lm-sensors.org
List-Id: linux-i2c@vger.kernel.org

> > The current code calls device_init_wakeup() before device_register, but
> > device_register will disable device wakeup.
> > 
> > This patch (against 2.6.27-rc1) move the device_init_wakeup() call in
> > the bus probe function,just before the probe call.
>
> David, can you please help? This part of the code is yours and I have
> no idea how it works.

Patch looked OK to me, except for the one comment below.

The root cause of the bug could be blamed on the new-style code
recycling the legacy i2c_attach_client() code instead of taking
a more driver-model-ish approach.

That forced use of device_register(), instead of device_add() ...
and register() always zero-initializes those wakeup flags.  On the
other hand, add() just takes their original value.  This patch
seems like the most concise fix possible.


>	I am surprised that according to Marc the code
> simply doesn't work at the moment. Didn't you test it?

I thought I had.  The one board I had with a wake-capable I2C
device (i2c/chips/menelaus.c) seems to have an ugly workaround
for the problem this addresses ... I probably just forgot to
remove that workaround, so of course it (still) worked.

(Well, actually I have another now, but its Linux support is
still incomplete, notably power managment.  www.beagleboard.org
can't yet run with mainline kernels.)


> > This will fix 3bbb835d4c53faf0bca62f0e39835926bef40b1f ('New style
> > devices can support driver modle wakeup flags') which in fact has
> > no effect. I think there is no need to fix -stable, because there
> > is no in-tree users of the I2C_CLIENT_WAKE flag.
>
> Interesting point... David, what are you using this code for then? Same
> question for you Marc.

The goal was to make sure that wakeup flags could be initialized
sanely for I2C devices, with RTCs being the most common example.

It would be wrong to have the drivers setting such flags, since they
can't actually know when their IRQs (or whatever) are wakeup-capable.
That kind of information is specific to how any given board is wired.


> > This patch also include a small functionnal change: the I2C_CLIENT_WAKE
> > is no more removed from the client flags, but this should't hurt.
>
> Why do you want to change this?

It's kind of essential to making this patch work!  Else the flag
won't be available when the i2c core gets control of that device
node again, after device_initialize() code zeroes those flags.


> > --- a/drivers/i2c/i2c-core.c
> > +++ b/drivers/i2c/i2c-core.c
> > @@ -108,6 +108,7 @@ static int i2c_device_probe(struct device *dev)
> >  	if (!driver->probe || !driver->id_table)
> >  		return -ENODEV;
> >  	client->driver = driver;

Better would be to preserve any existing settings:

	if (!device_can_wakeup(&client->dev))
		device_init_wakeup(...)

That way the userspace policy setting is preserved unless the
device itself gets removed ... instead of being clobbered by
the simple act of (re)probing a driver.

- Dave


> > +	device_init_wakeup(&client->dev, client->flags & I2C_CLIENT_WAKE);
> >  	dev_dbg(dev, "probe\n");
> >  
> >  	status = driver->probe(client, i2c_match_id(driver->id_table, client));
> > @@ -262,9 +263,8 @@ i2c_new_device(struct i2c_adapter *adap, struct i2c_board_info const *info)
> >  	client->adapter = adap;
> >  
> >  	client->dev.platform_data = info->platform_data;
> > -	device_init_wakeup(&client->dev, info->flags & I2C_CLIENT_WAKE);
> >  
> > -	client->flags = info->flags & ~I2C_CLIENT_WAKE;
> > +	client->flags = info->flags;
> >  	client->addr = info->addr;
> >  	client->irq = info->irq;
> >  
>
