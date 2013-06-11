From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c-piix4 - Add support for secondary SMBus on AMD SB800
 and AMD FCH chipsets
Date: Tue, 11 Jun 2013 21:35:41 +0200
Message-ID: <20130611193539.GG3376@katana>
References: <5196B32D.7060501@assembler.cz>
 <1369294522.12648.11.camel@mattotaupa>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="m972NQjnE83KvVa/"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1369294522.12648.11.camel@mattotaupa>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Paul Menzel <paulepanter-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: Rudolf Marek <r.marek-/xGekIyIa4Ap1Coe8Ar9gA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--m972NQjnE83KvVa/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > To detect i2c devices on the second bus.
>=20
>         $ sudo i2cdetect 9
>         WARNING! This program can confuse your I2C bus, cause data loss a=
nd worse!
>         I will probe file /dev/i2c-9.
>         I will probe address range 0x03-0x77.
>         Continue? [Y/n]=20
>              0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
>         00:          -- -- -- -- -- -- -- -- -- -- -- -- --=20
>         10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --=20
>         20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --=20
>         30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --=20
>         40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --=20
>         50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --=20
>         60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --=20
>         70: -- -- -- -- -- -- -- --

Do you know if there should be something connected?

> Rudolf, it looks like your patch could also update the i2c files under
> `Documentation`. At least there are some patches doing that.

Do you mean 'busses/i2c-piix4'?


--m972NQjnE83KvVa/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRt3wLAAoJEBQN5MwUoCm2fIAQAI5/ULGfVa63IN0MysbL5Q95
s+wdCisIrHAlUekntwvJqA8PDqPAQamau5F65CnSxGsI8IoGfCiBpGyBv2LIu71O
PPAqTO5NLafa1z12x/5D+v+dykUL9x/ZrO4fA5GJUPAMU13jCsJ0llN0Vp4OYP5x
sq7e/9Tg/FWf+XjiW5AN68xQU+ZR4cQqaqovvCbTWVPAUt6TbRaa5k5C0j/bQmmQ
3vQLO82fe9GIAdiHDK8QsJvOROmfUn55D8IFPg67tw7AAE58/rHaAPp7ZUd++Fhl
c5zZ+XJnAqDobGCTFmlgXjFqRMQZmabX9ijwyfYSjixfyHz6/o7mJiqxlzI61DsU
Z9g4e6q8wB3n/fVv1To5jtKHYRgm5jjZ9im8F42vr2PtyixA3wQj99vTRnNkXtep
UEoMNAQirdm5U+Zxd+wM29cK4bz9FFeHVRVU+BXcfG3PARw3JmaiDDJOfGXhsLny
70P1DHMBWy/gIerXM0YWpv+NXOph1MIs+EFhiaTKmdXjzZMK562c44BIfQ9P1+OC
cq278JfGTb1GkDhTrAuh3hmz0fm4j9LVw8mdWfsukHzMl9NpnHuFLFYKA9OZCZPq
XRbrcnkPD3OStKkGN+VaExkt+IYLtr1vPn+HT8/9JZiB4ajhnCWmb4BvCcYDDc7r
l5JsQiSayB942RaYPJWn
=WMsR
-----END PGP SIGNATURE-----

--m972NQjnE83KvVa/--
