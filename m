From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [RFC PATCH] i2c: new bus driver for efm32
Date: Thu, 13 Mar 2014 23:14:33 +0100
Message-ID: <20140313221433.GI2696@katana>
References: <1392027598-29015-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20140310075558.GD2571@katana>
 <20140313212613.GB15674@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OfrWf2Fun5Ae4m0Y"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140313212613.GB15674-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Uwe =?iso-8859-15?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--OfrWf2Fun5Ae4m0Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> it is, at least in mainline. My (not very strong) POV is that it's not
> much effort/code size to support both. I dropped the non-DT part, it's
> easily readded if need should arise.

Thanks, I think it simplifies the review for this first (public)
iteration of the driver.

> > > +		break;
> > > +	case REG_STATE_STATE_WAIT:
> > > +		/* huh, this shouldn't happen */
> > > +		BUG();
> >=20
> > Is this really a reason to halt the kernel?
> No, probably not. What do you suggest? Reinit the hardware, report and
> return an error?

Can't really say, because I don't know what the HW is waiting for. What
you say sounds sensible, though.

> > Check the core. It has per adapter locks. So the lock can go away.
> ok. So I can also drop the "if (ddata->msgs)" check, right?

Yes.

> > Check Documentation/i2c/fault-codes for more fine grained responses.
> ok, I have EAGAIN for arbitration lost, ENXIO for NAck in address phase
> and EIO for NAck in data phase now. Sounds good?

Yup!

> > That is usually enough. Make sure you checked SMBUS_QUICK, though
> > (i2cdetect -q ...).
> Both -q and -r seem to do the right thing.

Good.

> > Huh? Is this an accepted binding? Doesn't look like it because of a
> > generic name and IMO a specific use-case. BTW the binding documentation
> > for this driver is missing.
> Regarding the generic name: I don't care much, but I don't have a
> problem with it. IMHO it's implicitly name-spaced by the compatible
> string which starts with "efm32," and so is fine. I'd like to have the
> same property name for all efm32 device drivers and "location" matches
> the hardware reference manual (apart from capitalization).

I would in deed have expected a binding like "efm32,location" to
emphasize this is an efm32 specific thing. I know vendor-specific
"setup" bindings from elsewhere. Since it has been accepted already in
other places, we should keep it likes this.

> > > +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > > +	if (!res) {
> > > +		dev_err(&pdev->dev, "failed to determine base address\n");
> >=20
> > devm_ioremap_resource() checks for a valid resource. Drop this.
> But resource_size doesn't ...

Right (another reason to drop the check in my book ;))

> =20
> > > +		return -ENODEV;
> > > +	}
> > > +
> > > +	if (resource_size(res) < 0x42) {
> > > +		dev_err(&pdev->dev, "memory resource too small\n");
> > > +		return -EINVAL;
> > > +	}
> >=20
> > I'd drop this check since, but I won't force you to.
> I'd understand your sentence with s/since//, not sure about it as is.
> Anyhow, I like this check.

A leftover. I was about to write "since the check is somewhat heuristic
and does not proof much". But then I decided it is not worth spending
too much discussion on it :)

> > > +	clkdiv =3D DIV_ROUND_UP(rate, 8 * ddata->pdata.frequency) - 1;
> > > +	if (clkdiv >=3D 0x200) {
> > > +		dev_err(&pdev->dev,
> > > +				"input clock too fast (%lu) to divide down to bus freq (%lu)",
> > > +				rate, ddata->pdata.frequency);
> > > +		ret =3D -EIO;
> > > +		goto err_disable_clk;
> > > +	}
> >=20
> > -EIO for clocks errors? Is this common?
> Changed to ENODEV. Ok?

Nope, then the driver core will silent drop the error. -EINVAL?

Regards,

   Wolfram


--OfrWf2Fun5Ae4m0Y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTIi3JAAoJEBQN5MwUoCm2TNMP/R/Es9XS1AUXijcdt5NLGQzw
grsB935Dm/Zk7+ebMmyfMjxQ7rgu5YTYlUOy9ep0yQcL5+xGI5EpjuubIV5D+yRJ
qbKjgajdKiM2ylYPM0GDx38FfKu4bkVzrv9jU7QgoA8VSVodOGwBMcoUoeYjYzFD
8l6rqOVc7QC9M1u7ZZF/CARYonFK06EcTlXuZZpniq/ivLmYV6/eYBxxqtyBgoRi
NL2cTHpNs1lj4q78hxRhX6P73F/Z19RX2kkD8p7cpUFRjbFu4jFQkGBOnYh+sKXK
LC59CiyfO4f9y7cjpAbUo25EmzwirXYLImfk58XLpOG1aNMg1cxc141bdP8e+H2m
Ci60LaUElewS8H8h3rmZo6MKyKuS+l1UVwYREtQIOizBAY5byJjavmbzJbb6D4Zb
nAEpeJ1afK9+yfLEqWpxKbcwctv0wP7/IQAh7xz5s2UYHXoHE8qi2TgxgaFz2Iim
aEyW1wSxHHxFuYN9kpQS37SB9X0XsHlIysViMhDl3glj5ND0v3YELhblhl+uyQOZ
HZczzDWZqnXG93Ob9yZq+DVJ+AMlZm6sdDV+t/zyzRzm9SpvtwpTGlSjyaPTVH0J
FXJN1gywPgH/y0BJDtKJBYz8WDYyirKLAFPSjAarKW5sCmNy4Xz2Q0YskiemOjX8
gMwceNLG1Uo0NrTWna9Q
=VdBn
-----END PGP SIGNATURE-----

--OfrWf2Fun5Ae4m0Y--
