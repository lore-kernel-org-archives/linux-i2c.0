From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 0/4] i2c: Introduce i2c listeners
Date: Wed, 4 Jun 2008 19:21:26 -0700
Message-ID: <200806041921.26293.david-b@pacbell.net>
References: <20080604201334.19636f30@hyperion.delvare>
	<200806041710.59338.david-b@pacbell.net>
	<9e4733910806041742va67401en608c8c4b8c4c11b9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <9e4733910806041742va67401en608c8c4b8c4c11b9-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wednesday 04 June 2008, Jon Smirl wrote:
> On 6/4/08, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org> wrote:
> >  > It then looks at that information and decides if it wants to
> >  > bind. Drivers return true/false if they want to bind.
> >
> >
> > Wrong.  The probe returns zero if it bound, else negative errno.
> >  Those functions don't return booleans.
> 
> You guys are so literal. I should have said return 0 or -ENODEV or
> some other error.

You seemed intent on describing some new and never-seen-before
model for how driver model probing works, though ...


> >  > If they return
> >  > false the device structure is destroyed (or reused for the next probe
> >  > call).
> >
> >
> > No.  The struct device is not destroyed at that time for ANY
> >  driver model code I've seen in Linux.  Destroying it would
> >  prevent driver modules from binding to that device when they
> >  get loaded later.
> 
> Don't they get destroyed when hotplug devices are removed from the
> system?

That's not "at that time".  That's "when the hardware is
removed" ... for busses which support such detection.
USB supports it.  PCI itself doesn't (like I2C, SPI, etc).

CardBus, Hotplug PCI, and hotplug PCIE do report removals,
so they can remove such device structs later.  But they
would never do it as part of enumeration.


> Could this be considered a hotplug, create struct device, 
> probe to see if it is claimed, unhotplug if not claimed, destroy
> struct device.

No.  Think more about what goes into hotplugging.  It's
not just "some device is at that address".  It's also
"device with such-and-such-identifiers is there".


> But I agree with what you meant, that they never get destroyed when
> there is known hardware backing them in the system.
> 
> >  > They search
> >  > for the hardware in the probe function. That's probably why it is
> >  > called "probe" but that predates my involvement in Linux.
> >
> >
> > And that legacy model is something that's getting removed
> >  everywhere practical.  Such "legacy drivers" don't support
> >  hotplugging or most of the other mechanisms defined by the
> >  driver model, since they have the driver creating the
> >  device structs (instead of bus infrastructure).
> 
> Those drivers are getting removed because the hardware is disappearing
> and we have ACPI/PNP now to tell if if is present, not because they
> misused the driver code. We just don't need the old style probing code
> anymore and it was unreliable.

I've seen folk re-inventing such probing for custom hardware,
FWIW.  (Such stuff doesn't get merged upstream very often.)


> There is is a parallel here. With PowerPC device trees I can put the
> exact address of the i2c device into the board specific device tree.
> Now there's no need to probe addresses. That's equivalent to what's
> happening with ACPI and serial ports. Maybe we'll implement device
> trees on all archs and then we can get rid of i2c device probing.

There are surely worse futures to envision!

ACPI would need to expose I2C/SMBus though.  I suspect that's
something many current x86 platform vendors would oppose.

- Dave


> 
> -- 
> Jon Smirl
> jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
> 



_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
