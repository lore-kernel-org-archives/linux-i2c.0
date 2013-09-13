From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v2 1/9] i2c: prepare runtime PM support for I2C client
 devices
Date: Fri, 13 Sep 2013 20:31:49 +0300
Message-ID: <20130913173149.GE7393@intel.com>
References: <1378913560-2752-1-git-send-email-mika.westerberg@linux.intel.com>
 <1378913560-2752-2-git-send-email-mika.westerberg@linux.intel.com>
 <87vc25pvvm.fsf@linaro.org>
 <20130913065434.GZ7393@intel.com>
 <87bo3whjz4.fsf@linaro.org>
 <20130913145022.GC7393@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130913145022.GC7393-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lv Zheng <lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Aaron Lu <aaron.lu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mauro Carvalho Chehab <m.chehab-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, Sep 13, 2013 at 05:50:22PM +0300, Mika Westerberg wrote:
> On Fri, Sep 13, 2013 at 07:30:55AM -0700, Kevin Hilman wrote:
> > Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> writes:
> > 
> > > On Thu, Sep 12, 2013 at 02:34:21PM -0700, Kevin Hilman wrote:
> > >> > diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> > >> > index f32ca29..44374b4 100644
> > >> > --- a/drivers/i2c/i2c-core.c
> > >> > +++ b/drivers/i2c/i2c-core.c
> > >> > @@ -248,11 +248,30 @@ static int i2c_device_probe(struct device *dev)
> > >> >  					client->flags & I2C_CLIENT_WAKE);
> > >> >  	dev_dbg(dev, "probe\n");
> > >> >  
> > >> > +	/* Make sure the adapter is active */
> > >> > +	pm_runtime_get_sync(&client->adapter->dev);
> > >> > +
> > >> > +	/*
> > >> > +	 * Enable runtime PM for the client device. If the client wants to
> > >> > +	 * participate on runtime PM it should call pm_runtime_put() in its
> > >> > +	 * probe() callback.
> > >> > +	 */
> > >> > +	pm_runtime_get_noresume(&client->dev);
> > >> > +	pm_runtime_set_active(&client->dev);
> > >> 
> > >> Why the set_active here?
> > >> 
> > >> For hardware that is disabled/powered-off on startup, there will now be
> > >> a mismatch between the hardware state an the RPM core state.
> > >
> > > The call to pm_runtime_get_noresume() should make sure that the device is
> > > in active state (at least in state where it can access the bus) if I'm
> > > understanding this right.
> > 
> > No, after _get_noresume(), nothing happens to the hardware.  It simply
> > increments the usecount.  From pm_runtime.h:
> > 
> > static inline void pm_runtime_get_noresume(struct device *dev)
> > {
> > 	atomic_inc(&dev->power.usage_count);
> > }
> > 
> > So after the _get_noresume() and _set_active() you're very likely to
> > have a disconnect between the hardware state and what state RPM thinks
> > the hardware is in.
> 
> Good point.
> 
> I suppose calling pm_runtime_get() here would work (and make the state
> active in all case)? I used _noresume() here because at this point the
> driver itself hasn't had change to install it's RPM hooks.

I take that back.

[ It has been some time since this code was originally written so I can't
remember all the details :-/ ]

The pm_runtime_get_noresume() is there just to increment the refcount. It
has nothing to do to "activate" the device in question. Sorry about the
confusion from my part.

This is what happens in case the device is enumerated from ACPI:

	// This makes sure that the controller itself is powered on
	// (adapter device follows its parent which is the controller). The
	// controller is attached to the ACPI power domain so it is
	// brought to D0 now.
	pm_runtime_get_sync(&client->adapter->dev);

	// This binds the client device to the ACPI power domain, and in
	// addition to that brings the client device to D0.
	if (ACPI_HANDLE(&client->dev))
		acpi_dev_pm_attach(&client->dev, true);

	// Increase the refcount so that client can start runtime PM
	// transitions when it calls _put().
	pm_runtime_get_noresume(&client->dev);

	// Mark the device being active as
	//  1) In ACPI case we know that is true as we just powered the
	//     device on.
	//  2) We treat the device by default to be runtime PM active and
	//     powered on (that's in the changelog and should follow what
	//     the PCI bus did).
	pm_runtime_set_active(&client->dev);

	// Enable runtime PM but nothing happens yet as long as the client
	// driver doesn't call _put().
	pm_runtime_enable(&client->dev);

So, yes there might be a disconnect between the runtime PM state and the
device HW state now (same is with default to suspended).

When the driver ->probe() is called, it needs to power on the device (which
it probably needs to do anyway to be able to talk to the device and probe
its registers, etc.). Once the driver calls _put() the device is eventually
moved to suspended state (and its RPM hooks are called). I might be missing
something but is there a case where this is not beneficial?
