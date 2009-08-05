From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] TSL2550: extended mode bugfix
Date: Wed, 5 Aug 2009 17:22:46 +0200
Message-ID: <20090805152245.GB3148@pengutronix.de>
References: <4A79A055.1010602@valueteam.com> <20090805171452.592a2bbd@hyperion.delvare>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5/uDoXvLw7AC5HRs"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20090805171452.592a2bbd-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: "Michele De Candia (VT)" <michele.decandia-EZxuzQJkuwwybS5Ee8rs3A@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--5/uDoXvLw7AC5HRs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Operating on values before you check for errors is wrong. I'd rather do:
>=20
>     ret =3D tsl2550_calculate_lux(ch0, ch1);
>     if (ret < 0)
>         return ret;
>     if (data->operating_mode =3D=3D 1) /* extended mode */
>         ret *=3D 5;

I just wanted to suggest the same :) Pity that "operating_mode" is exported=
 to
sysfs, "extended_mode" would have been a better name, me thinks...

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--5/uDoXvLw7AC5HRs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkp5o8UACgkQD27XaX1/VRsetwCeNOU96q+13x8iuXEX2wKOfiGD
+GUAoIMnkTzQQqDkJ+qCuRiBPiASvfrX
=JCJ6
-----END PGP SIGNATURE-----

--5/uDoXvLw7AC5HRs--
