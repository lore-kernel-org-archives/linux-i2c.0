From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 7/7] OF/ACPI/I2C: Add generic match function for the
 aforementioned systems
Date: Thu, 5 Jun 2014 11:37:09 +0100
Message-ID: <20140605103709.GE19550@lee--X1>
References: <1401883796-17841-1-git-send-email-lee.jones@linaro.org>
 <1401883796-17841-8-git-send-email-lee.jones@linaro.org>
 <20140605103009.85BE4C40A4D@trevor.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140605103009.85BE4C40A4D-WNowdnHR2B42iJbIjFUEsiwD8/FfD2ys@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, 05 Jun 2014, Grant Likely wrote:

> On Wed,  4 Jun 2014 13:09:56 +0100, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> =
wrote:
> > Currently this is a helper function for the I2C subsystem to aid th=
e
> > matching of non-standard compatible strings and devices which use D=
T
> > and/or ACPI, but do not supply any nodes (see: [1] Method 4).  Howe=
ver,
> > it has been made more generic as it can be used to only make one ca=
ll
> > for drivers which support any mixture of OF, ACPI and/or I2C matchi=
ng.
> >=20
> > The initial aim is for of_match_device() to be replaced by this cal=
l
> > in all I2C device drivers.
> >=20
> > [1] Documentation/i2c/instantiating-devices
> >=20
> > Signed-off-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>=20
> I don't like this. It drops all type safety on the match entry
> and the caller has no idea what it got back.

Okay, so what's the best way forward?

Introduce a i2c_of_match_device() call instead?

> > ---
> >  include/linux/match.h | 40 +++++++++++++++++++++++++++++++++++++++=
+
> >  1 file changed, 40 insertions(+)
> >  create mode 100644 include/linux/match.h
> >=20
> > diff --git a/include/linux/match.h b/include/linux/match.h
> > new file mode 100644
> > index 0000000..20a08e2
> > --- /dev/null
> > +++ b/include/linux/match.h
> > @@ -0,0 +1,40 @@
> > +#include <linux/of.h>
> > +#include <linux/acpi.h>
> > +#include <linux/i2c.h>
> > +
> > +static void *device_match(struct device *dev)
> > +{
> > +	struct device_driver *driver =3D dev->driver;
> > +
> > +	if (!driver)
> > +		return NULL;
> > +
> > +	/* Attempt an OF style match */
> > +	if (IS_ENABLED(CONFIG_OF)) {
> > +		const struct of_device_id *of_match =3D
> > +			i2c_of_match_device(driver->of_match_table, dev);
> > +		if (of_match)
> > +			return (void *)of_match;
> > +	}
> > +
> > +	/* Then ACPI style match */
> > +	if (IS_ENABLED(CONFIG_ACPI)) {
> > +		const struct acpi_device_id *acpi_match	=3D
> > +			acpi_match_device(driver->acpi_match_table, dev);
> > +		if (acpi_match)
> > +			return (void *)acpi_match;
> > +	}
> > +
> > +	/* Finally an I2C match */
> > +	if (IS_ENABLED(CONFIG_I2C)) {
> > +		struct i2c_client *client =3D i2c_verify_client(dev);
> > +		struct i2c_driver *i2c_drv =3D to_i2c_driver(driver);
> > +		struct i2c_device_id *i2c_match;
> > +
> > +		i2c_match =3D i2c_match_id(i2c_drv->id_table, client);
> > +		if (i2c_match)
> > +			return (void *)i2c_match;
> > +	}
> > +
> > +	return NULL;
> > +}
>=20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
