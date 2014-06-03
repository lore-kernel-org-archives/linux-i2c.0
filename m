From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 3/3] i2c: Make I2C ID tables non-mandatory for DT'ed
 and/or ACPI'ed devices
Date: Tue, 3 Jun 2014 09:11:36 +0100
Message-ID: <20140603081136.GE3060@lee--X1>
References: <1401716463-23457-1-git-send-email-lee.jones@linaro.org>
 <1401716463-23457-4-git-send-email-lee.jones@linaro.org>
 <20140602153417.2065c1a5@alan.etchedpixels.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140602153417.2065c1a5-mUKnrFFms3BCCTY1wZZT65JpZx93mCW/@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: One Thousand Gnomes <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, 02 Jun 2014, One Thousand Gnomes wrote:

> On Mon,  2 Jun 2014 14:41:03 +0100
> Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
>=20
> > Currently the I2C framework insists on devices supplying an I2C ID
> > table.  Many of the devices which do so unnecessarily adding quite =
a
> > few wasted lines to kernel code.  This patch allows drivers a means
> > to 'not' supply the aforementioned table and match on either DT
> > and/or ACPI match tables instead.
> >=20
> > Signed-off-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> > ---
> >  drivers/i2c/i2c-core.c | 13 ++++++++++++-
> >  1 file changed, 12 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> > index d0c7180..811b78f 100644
> > --- a/drivers/i2c/i2c-core.c
> > +++ b/drivers/i2c/i2c-core.c
> > @@ -271,7 +271,18 @@ static int i2c_device_probe(struct device *dev=
)
> >  		return 0;
> > =20
> >  	driver =3D to_i2c_driver(dev->driver);
> > -	if (!driver->probe || !driver->id_table)
> > +	if (!driver->probe)
> > +		return -EINVAL;
> > +
> > +	/*
> > +	 * An I2C ID table is not madatory, if and only if, a suitable De=
vice
>=20
> typo "madatory"..
>=20
> > +	 * Tree and/or ACPI match table entry is supplied for the probing
> > +	 * device.
> > +	 *
> > +	 * TODO: Provide 'device type' to 'ACPI node' call and match here=
=2E
> > +	 */
> > +	if (!driver->id_table &&
> > +	    !of_match_device(dev->driver->of_match_table, dev))
> >  		return -ENODEV;
> > =20
>=20
> Looks sensible to me other than that.

Can I add your Ack once the typo is fixed?

> >  	if (!device_can_wakeup(&client->dev))

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
