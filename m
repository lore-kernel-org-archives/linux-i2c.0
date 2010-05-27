From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: Controlling Driver Load Order
Date: Fri, 28 May 2010 00:09:51 +0200
Message-ID: <20100527220951.GD5636@pengutronix.de>
References: <AANLkTikzDvWakd7JW3DzTHinjS3dAlqzPx6K8V2qMDG7@mail.gmail.com> <AANLkTinkY8JYh44UOEPflBUDyQ2wat_AKShRjA3HPxrf@mail.gmail.com> <20100526235246.GA31068@pengutronix.de> <AANLkTikj8yGSK5Ovud_k8f6jWloojqDJmQ_H6pD_IFgM@mail.gmail.com> <20100527041358.GA14070@pengutronix.de> <AANLkTilKUfcYsPqr5kXlONJQAFCaE8D8U9ltQybIzCPu@mail.gmail.com> <4BFEDF6D.3090100@bluewatersys.com> <20100527214209.GC5636@pengutronix.de> <4BFEEA08.70401@bluewatersys.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0/kgSOzhNoDC5T3a"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4BFEEA08.70401-7Wk5F4Od5/oYd5yxfr4S2w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ryan Mallon <ryan-7Wk5F4Od5/oYd5yxfr4S2w@public.gmane.org>
Cc: Robert Emanuele <rob-3bOSxtzXIkJzbRFIqnYvSA@public.gmane.org>, Linus Walleij <linus.ml.walleij-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--0/kgSOzhNoDC5T3a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > Always ask which kernel is used, sigh...
>=20
> Sorry? I didn't see a kernel version mentioned. I went looking because I
> had though that i2c-gpio was already subsys_initcall.

Sorry, I missed emphasizing that my comment was meant as a "note-to-myself".
You were perfectly right, of course, I should have done the same.

> >> There was a discussion a while back to make all of the embedded i2c
> >> busses be subsys_initcall since i2c is often a system bus on embedded
> >=20
> > Oh, where was that? Can't recall (but couldn't recall that I acked the =
i2c-gpio
> > patch above as well ;))
> >=20
>=20
> Moving the embedded i2c busses to subsys_initcall was discussed here:
> http://lists.lm-sensors.org/pipermail/i2c/2008-June/004142.html. The
> i2c_gpio bus got mentioned, which is why I thought it had already been
> changed.

Thanks for the pointer!

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--0/kgSOzhNoDC5T3a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkv+7a8ACgkQD27XaX1/VRuc9wCgymAtRYtaOyJW3582ZSSFSUqx
f9cAn3yMHm8XvI1aT/fL+Gm1m/tnJwJX
=6q1m
-----END PGP SIGNATURE-----

--0/kgSOzhNoDC5T3a--
