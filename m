From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: NXP SC16IS752 dual-UART driver?
Date: Sat, 8 Jan 2011 19:16:10 +0100
Message-ID: <20110108181610.GA4045@pengutronix.de>
References: <AANLkTim6+ccRvJunhofBeYhtniLW83dLA52a-LW2w0Gm@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <AANLkTim6+ccRvJunhofBeYhtniLW83dLA52a-LW2w0Gm-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Steve Sakoman <sakoman-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> I will soon be working with an ARM based system that incorporates an
> NXP SC16IS752 dual-UART on the i2c bus.
>=20
> Is anyone aware of an existing linux driver for this part?

Search for "SC16IS7x2 driver" and you will find a few references, for SPI
though. I did not have a deeper look, but usually it is possible to abstract
the IO-access so you could use I2C, too. I did it for max7300/1 (in
drivers/gpio) once.

Good luck :)

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAk0oqeoACgkQD27XaX1/VRvnuQCferRL2GExi+T/AV5MRpgqFiBi
iiIAoLGq4b3srs2ZgmrJ+XzxbFQfw6+u
=zSiZ
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--
