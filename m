From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 1/2 V2] MXS: Set I2C timing registers for mxs-i2c
Date: Mon, 9 Jul 2012 14:05:23 +0200
Message-ID: <20120709120523.GG1296@pengutronix.de>
References: <1341554956-17416-1-git-send-email-marex@denx.de>
 <20120709105338.GE1296@pengutronix.de>
 <201207091307.35860.marex@denx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="O8XZ+2Hy8Kj8wLPZ"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201207091307.35860.marex-ynQEQJNshbs@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Detlev Zundel <dzu-ynQEQJNshbs@public.gmane.org>, Dong Aisheng <b29396-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Linux ARM kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Stefano Babic <sbabic-ynQEQJNshbs@public.gmane.org>, Uwe =?iso-8859-15?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Wolfgang Denk <wd-ynQEQJNshbs@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--O8XZ+2Hy8Kj8wLPZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > > diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.d=
tsi
> > > index ee3778a..832d30a 100644
> > > --- a/arch/arm/boot/dts/imx28.dtsi
> > > +++ b/arch/arm/boot/dts/imx28.dtsi
> [...]
> > > @@ -428,6 +429,7 @@
> > >=20
> > >  				compatible =3D "fsl,imx28-i2c";
> > >  				reg =3D <0x8005a000 2000>;
> > >  				interrupts =3D <110 69>;
> > >=20
> > > +				clock-frequency =3D <400000>;
> >=20
> > NACK on that. Not all slaves can do 400KHz, so this is not a sensible
> > default.
>=20
> How many of such chips are there and how many of the chips can do 400kHz =
? I=20
> believe the majority shouldn't suffer because of minority.

The kernel should work for all users, not only for the majority, so:
Better safe than sorry.

Also, defaults should make the system work. Tuning can be done later by
somebody who understands what is needed.

And frankly, this attitude which made you add a potential regression is
worrisome. I'd suggest to give stability a higher priority.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--O8XZ+2Hy8Kj8wLPZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk/6yQMACgkQD27XaX1/VRtZvQCfUMLT5iXKG9YRPX3PhkNq/9rN
hRgAn1h1Uqxzn7jKpZQtMdHsym21sXbO
=DaxW
-----END PGP SIGNATURE-----

--O8XZ+2Hy8Kj8wLPZ--
