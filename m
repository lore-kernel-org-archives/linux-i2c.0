From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 3/6] mfd: add bcm59056 pmu driver
Date: Tue, 4 Feb 2014 14:47:31 +0000
Message-ID: <20140204144731.GA3154@lee--X1>
References: <1391516352-32359-1-git-send-email-mporter@linaro.org>
 <1391516352-32359-4-git-send-email-mporter@linaro.org>
 <20140204132951.GE13529@lee--X1>
 <20140204143119.GA4627@beef>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140204143119.GA4627@beef>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Matt Porter <mporter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Tim Kryger <tim.kryger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Christian Daudt <bcm-xK7y4jjYLqYh9ZMKESR00Q@public.gmane.org>, Devicetree List <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux I2C List <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hold your horses. :)

> > > Add a driver for the BCM59056 PMU multi-function device. The driv=
er
> > > initially supports regmap initialization and instantiation of the
> > > voltage regulator device function of the PMU.
> > >=20
> > > Signed-off-by: Matt Porter <mporter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> > > Reviewed-by: Tim Kryger <tim.kryger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> > > Reviewed-by: Markus Mayer <markus.mayer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> > > ---
> > >  drivers/mfd/Kconfig          |   8 +++
> > >  drivers/mfd/Makefile         |   1 +
> > >  drivers/mfd/bcm59056.c       | 119 +++++++++++++++++++++++++++++=
++++++++++++++
> > >  include/linux/mfd/bcm59056.h |  35 +++++++++++++
> > >  4 files changed, 163 insertions(+)
> > >  create mode 100644 drivers/mfd/bcm59056.c
> > >  create mode 100644 include/linux/mfd/bcm59056.h

<snip>

> > I thought this was a DT only driver? If so, you probably want to us=
e
> > of_match_device() instead.
>=20
> Correct, I'll use of_match_device()

If you're going to use this ...

<snip>

> > You've gone to the trouble of setting a device version here, but yo=
u
> > don't seem to use it?
>=20
> I'll drop the device version

=2E.. then you'll still need this.

> > > +static const struct i2c_device_id bcm59056_i2c_id[] =3D {
> > > +	{ "bcm59056", BCM59056 },
> > > +	{ }
> > > +};
> >=20
> > Ah, I guess this is where id->driver comes from.
> >=20
> > It's pretty silly that the I2C subsystem demands the presence of th=
is
> > table, despite not using it if an of_device_id table is present.
>=20
> It does make it very difficult to follow DT enabled I2C client driver=
s
> :( I'll drop the BCM59056 too.

And I don't think you can drop this, as the I2C subsystem still
insists on it.

> > > +/* chip id */
> > > +#define BCM59056		0
> >=20
> > Lonely, oh so lonely!
>=20
> Understood. Will remove.

I think you need to keep this to supply the silly I2C ID table.

I would just omit the '.data =3D (void *) VERSION' from the
of_match_table until you require it.=20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
