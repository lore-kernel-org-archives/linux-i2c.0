From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH] i2c-designware: add optional regulator support
Date: Mon, 19 Mar 2012 17:41:30 +0200
Message-ID: <20120319154130.GX32276@intel.com>
References: <1332161180-32502-1-git-send-email-mika.westerberg@linux.intel.com>
 <20120319142807.GA9334@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120319142807.GA9334-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Jani Nikula <jani.nikula-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Kirill A. Shutemov" <kirill.shutemov-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Mar 19, 2012 at 02:28:07PM +0000, Mark Brown wrote:
> On Mon, Mar 19, 2012 at 02:46:20PM +0200, Mika Westerberg wrote:
> 
> > It is possible that some of the i2c busses are supplied by a separate
> > regulator which needs to be enabled before we can access the bus. Thus add
> > support for an optional regulator.
> 
> No, support for critical supplies should not be optional.  I'm getting
> rather fed up with having to point this out.  There's always a regulator
> there supplying the bus, the driver should just assume that the system
> provides it.

Right, but not all platforms have regulator for this. That's why we made it
optional.

On the other hand if we assume it is always provided by the system then I
guess there is no way to turn it off for example during system sleep which
might result unneeded power consumption.

> > We also implement enabling/disabling the regulator on system and runtime PM
> > hooks.
> 
> This is suspicious too...
> 
> If this is just the external buffer/reference voltage for the bus then
> I'd really not expect the controller to have to worry about it, the
> drivers for the target devices ought to be making sure they've powered
> up the devices prior to trying to talk to them anyway (and most of the
> time will need the supplies on for *much* longer than just the time
> spent doing I2C transactions).  There's no harm in having support in the
> controller driver but I'd be surprised if the clients were happy with
> having their I/O voltage bounced on them...

It is meant for controlling bus voltage for given I2C bus in case some
other platform using designware I2C controller might have use for such.

Having the controller controlling the bus voltage should not cause problems
for its clients as they get suspended before the bus itself and vice versa
in case of resume. Or have I misunderstood something?

On one Medfield platform we actually have a LCD panel which misbehaves when
its supply voltage is cut off (it drives the I2C lines low). This made the
whole bus unusable.

So we worked it around by adding an artificial regulator to I2C controller
which then drives LCD supply voltage as well (it is shared with LCD driver
and I2C controller driver). This way we were able to make sure that the bus
is functional when any I2C transactions are performed.

In our case we really want to turn off the LCD voltage when not needed as
it consumes ~500mW power.

> > +	if (i2c->controller->regulator)
> > +		regulator_enable(i2c->controller->regulator);
> 
> > +	controller->regulator = regulator_get(&pdev->dev, "v-i2c");
> > +	if (IS_ERR(controller->regulator))
> > +		controller->regulator = NULL;
> > +	else
> > +		regulator_enable(controller->regulator);
> 
> There's no error checking at all in this ccode - if it fails to request
> the supply the driver silently ignores the error and if the regulator is
> there but fails to enable the error will also be silently ignored.

The first case is because the regulator is optional - if we don't get it we
don't try to use it. The other case is overlook from our side and should be
fixed to handle the errors correctly.
