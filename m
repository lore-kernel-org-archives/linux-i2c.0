From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH] i2c-designware: add optional regulator support
Date: Mon, 19 Mar 2012 16:24:34 +0000
Message-ID: <20120319162434.GC5132@opensource.wolfsonmicro.com>
References: <1332161180-32502-1-git-send-email-mika.westerberg@linux.intel.com>
 <20120319142807.GA9334@sirena.org.uk>
 <20120319154130.GX32276@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kfjH4zxOES6UT95V"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120319154130.GX32276-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Jani Nikula <jani.nikula-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Kirill A. Shutemov" <kirill.shutemov-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--kfjH4zxOES6UT95V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 19, 2012 at 05:41:30PM +0200, Mika Westerberg wrote:
> On Mon, Mar 19, 2012 at 02:28:07PM +0000, Mark Brown wrote:

> > No, support for critical supplies should not be optional.  I'm getting
> > rather fed up with having to point this out.  There's always a regulator
> > there supplying the bus, the driver should just assume that the system
> > provides it.

> Right, but not all platforms have regulator for this. That's why we made it
> optional.

No, really.  They'll have a regulator - the buffer voltage isn't just
randomly going to appear without something supplying it.  It might not
be a software controlled supply but there will be something there.  This
all applies to essentially any supply and is therefore handled in the
core, it compiles itself out transparently when not enabled and there's
facilities for providing stub regulators too.  Just ignoring the errors
isn't a good way of handling this.

> > If this is just the external buffer/reference voltage for the bus then
> > I'd really not expect the controller to have to worry about it, the
> > drivers for the target devices ought to be making sure they've powered
> > up the devices prior to trying to talk to them anyway (and most of the

> Having the controller controlling the bus voltage should not cause problems
> for its clients as they get suspended before the bus itself and vice versa
> in case of resume. Or have I misunderstood something?

That's extremely unusual for an I2C controller and probably suboptimal
for your system - due to the nature of I2C the devices don't need the
controller to be around except when the controller wants to interact
with them.  Normally the runtime power management for I2C controllers
suspends the controller whenever it's not actively talking on the bus
ignoring the state of the children, allowing the SoC to save power on a
controller that's just sitting there idle.

> On one Medfield platform we actually have a LCD panel which misbehaves when
> its supply voltage is cut off (it drives the I2C lines low). This made the
> whole bus unusable.

> So we worked it around by adding an artificial regulator to I2C controller
> which then drives LCD supply voltage as well (it is shared with LCD driver
> and I2C controller driver). This way we were able to make sure that the bus
> is functional when any I2C transactions are performed.

> In our case we really want to turn off the LCD voltage when not needed as
> it consumes ~500mW power.

This is all exactly what I'd expect and really sounds exactly like the
case I described - the panel needs the supply so the panel driver should
be managing it when required.  There's nothing system or controller
specific about the fact that the panel needs all its supplies up to run,
and indeed there's already some LCD and backlight drivers which manage
their supplies.

> > > +	if (i2c->controller->regulator)
> > > +		regulator_enable(i2c->controller->regulator);

> > > +	controller->regulator = regulator_get(&pdev->dev, "v-i2c");
> > > +	if (IS_ERR(controller->regulator))
> > > +		controller->regulator = NULL;
> > > +	else
> > > +		regulator_enable(controller->regulator);

> > There's no error checking at all in this ccode - if it fails to request
> > the supply the driver silently ignores the error and if the regulator is
> > there but fails to enable the error will also be silently ignored.

> The first case is because the regulator is optional - if we don't get it we
> don't try to use it. The other case is overlook from our side and should be

So what happens in a system where the regulator is required but fails to
appear for some reason is that the driver happily runs on without saying
anything which isn't going to be great for diagnostics and will produce
some interesting races when we start to deploy deferred probe.

There's really nothing sensible an individual driver can do except for
assume that the device needs power, the concept of things being supplied
by fixed voltage regulators outside of software control is so widespread
that it'd be crazy to implement support for it in individual drivers.

--kfjH4zxOES6UT95V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPZ127AAoJEBus8iNuMP3dEwMQAInySHxuy6/EdY/AB06IFDA9
jAEteBcCOvn5S2Je06PeoJKfshI+FXXopyCND1FGzrSCbu9wxNW+EblL3+n6lOp1
OkZzq/1fR4h+JcJhj/Xil4HtUzj6aIT8wisDWAnndg4ZWQm1JPdE4q9X8MX7dYeg
is4nu8Xh2mKSUFevG0sfVL6FAVyl1ic65lgUdqPqZlaaN1QYTFtpUGp6s2X0ktIY
xp3pod2toNM3NYi8uWr+dN7aOJfZC/Dwc5FRio+EpHZ3KRFDf/kYmrHlzom4F7F6
PuwAv0KExgdEMbCbwbeiJTNjDx6q7zzdkGU0/l04i8s1ufjHQWVUei2UDAPAErU6
LUpxMAi7t1wxqxRCHYA7tNtFBZQHWGQfhqgP9GgNzRXgJei19kXJWwD0GGKPSeAm
Dvd1LyNCx/BOBhbRyaTMBOlxi5aVniCX9UnBIktXAAZD3kZmGGfyxo4adGkmxntA
pTjmZgQ7xlGG/AwEJ3Osx9idqP14Kjqy/7NcqM9wlzdnNfAM2+SwiMLsexFFN/Ru
ExKs4j1B5oHdT0Uqi7wX9dLBeSOdQ/PtNMzyA6Y+N0hONrzhZ0iNtELGTzChmjQ+
KCPMLKv4jG9KEiqY2y1sVtykCX98SYwusIzk+a60W7ktn+VbfNYKOBZcl2TbYVs4
Hea2AVcbqz1LeFW+MO4v
=xgta
-----END PGP SIGNATURE-----

--kfjH4zxOES6UT95V--
