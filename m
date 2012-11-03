From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] i2c: at91: add a sanity check on i2c message length
Date: Sat, 3 Nov 2012 15:16:24 +0100
Message-ID: <20121103141624.GA24952@pengutronix.de>
References: <1349879158-27268-1-git-send-email-ludovic.desroches@atmel.com>
 <20121101222922.GD22956@pengutronix.de>
 <5093A8CD.60006@atmel.com>
 <20121102111432.GD21313@pengutronix.de>
 <5093EE2B.8080005@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5093EE2B.8080005-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "ludovic.desroches" <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Cc: "Voss, Nikolaus" <N.Voss-+umVssTZoCsb1SvskN2V4Q@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> >>Yes SMBUS quick command is supported but is not managed in the
> >>driver, we have to tell explicitly the IP that we want to send this
> >>command.
> >
> >Ok, so unless you want to implement the support, please update this
> >patch with a comment that SMBUS_QUICK is a TODO and remove the
> >SMBUS_QUICK capability.
> >
>=20
> Implementation should not be a huge task, only one bit to set in a
> register but I have no device to test it.

'i2cdetect' from i2c-tools uses SMBUS_QUICK as one method to detect
chips. Most slaves (both I2C and SMBus) react to that, so that would do
in my book.

> Did you test the driver with SMBus compatible devices? Can I keep
> other SMBus capabilities from SMBUS_EMUL?

The rest should be fine.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlCVJzgACgkQD27XaX1/VRtJzwCeLyhG/dThypgDS0WiMXOQTacW
WX4AoLPwrX91Kj3XlOR9BZ4zreZu1v2G
=o5Bn
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--
