From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 7/7] OF/ACPI/I2C: Add generic match function for the
 aforementioned systems
Date: Wed, 4 Jun 2014 14:28:20 +0100
Message-ID: <20140604132820.GA19550@lee--X1>
References: <1401883796-17841-1-git-send-email-lee.jones@linaro.org>
 <1401883796-17841-8-git-send-email-lee.jones@linaro.org>
 <5769487.6cMQUCkisu@vostro.rjw.lan>
 <20140604125141.GB5214@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140604125141.GB5214-3PARRvDOhMZrdx17CPfAsdBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, 04 Jun 2014, Mika Westerberg wrote:
> On Wed, Jun 04, 2014 at 02:37:42PM +0200, Rafael J. Wysocki wrote:
> > On Wednesday, June 04, 2014 01:09:56 PM Lee Jones wrote:
> > > Currently this is a helper function for the I2C subsystem to aid =
the
> > > matching of non-standard compatible strings and devices which use=
 DT
> > > and/or ACPI, but do not supply any nodes (see: [1] Method 4).  Ho=
wever,
> > > it has been made more generic as it can be used to only make one =
call
> > > for drivers which support any mixture of OF, ACPI and/or I2C matc=
hing.
> > >=20
> > > The initial aim is for of_match_device() to be replaced by this c=
all
> > > in all I2C device drivers.
> > >=20
> > > [1] Documentation/i2c/instantiating-devices
> > >=20
> > > Signed-off-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> >=20
> > Mika, can you please have a look at this, please?
>=20
> I don't see any fundamental problems with this wrt. ACPI.
>=20
> That said, I find it kind of weird to have generic function that then
> has knowledge of how different buses do their matching.
>=20
> I would rather see something like firmware_device_match(dev) that goe=
s
> and matches from DT/ACPI and leave bus specific match to happen inter=
nal
> to that bus.

Unfortunately that completely defeats the object of the patch.  When a
of_match_device() is invoked it solely looks up devices based on OF
matching, but I2C is special in that devices can be registered via
sysfs, thus will no have device node.  If of_match_device() is called
in one of these instances it will fail.  The idea of this patch is to
generify the matching into something does has the knowledge to firstly
attempt a traditional match, and if that fails will fall back to a
special i2c_{of,acpi}_match_device() which knows how to deal with
node-less registration.

We don't support that for ACPI yet, as I don't have a system to test
it on, but when we do acpi_match_device() in the patch will too be
swapped out for an equivalent i2c_acpi_match_device().

Actually, I've just spotted that this patch is wrong I need to change
it in the following way:

> > > ---
> > >  include/linux/match.h | 40 +++++++++++++++++++++++++++++++++++++=
+++
> > >  1 file changed, 40 insertions(+)
> > >  create mode 100644 include/linux/match.h
> > >=20
> > > diff --git a/include/linux/match.h b/include/linux/match.h
> > > new file mode 100644
> > > index 0000000..20a08e2
> > > --- /dev/null
> > > +++ b/include/linux/match.h
> > > @@ -0,0 +1,40 @@
> > > +#include <linux/of.h>
> > > +#include <linux/acpi.h>
> > > +#include <linux/i2c.h>
> > > +
> > > +static void *device_match(struct device *dev)
> > > +{
> > > +	struct device_driver *driver =3D dev->driver;
> > > +
> > > +	if (!driver)
> > > +		return NULL;
> > > +
> > > +	/* Attempt an OF style match */
> > > +	if (IS_ENABLED(CONFIG_OF)) {
> > > +		const struct of_device_id *of_match =3D
> > > +			i2c_of_match_device(driver->of_match_table, dev);

This should be of_match_device()

> > > +		if (of_match)
> > > +			return (void *)of_match;
> > > +	}
> > > +
> > > +	/* Then ACPI style match */
> > > +	if (IS_ENABLED(CONFIG_ACPI)) {
> > > +		const struct acpi_device_id *acpi_match	=3D
> > > +			acpi_match_device(driver->acpi_match_table, dev);
> > > +		if (acpi_match)
> > > +			return (void *)acpi_match;
> > > +	}
> > > +
> > > +	/* Finally an I2C match */
> > > +	if (IS_ENABLED(CONFIG_I2C)) {
> > > +		struct i2c_client *client =3D i2c_verify_client(dev);
> > > +		struct i2c_driver *i2c_drv =3D to_i2c_driver(driver);
> > > +		struct i2c_device_id *i2c_match;

i2c_of_match_device() and later i2c_acpi_match_device() should be here.

> > > +		i2c_match =3D i2c_match_id(i2c_drv->id_table, client);
> > > +		if (i2c_match)
> > > +			return (void *)i2c_match;
> > > +	}
> > > +
> > > +	return NULL;
> > > +}
> > >=20
> >=20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
