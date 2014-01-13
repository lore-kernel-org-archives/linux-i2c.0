From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: designware: remove HAVE_CLK build dependecy
Date: Mon, 13 Jan 2014 13:39:19 +0100
Message-ID: <20140113123918.GC2586@katana>
References: <f3ebead75d45623e4b649c7a8d0112584ffd1788.1388392279.git.baruch@tkos.co.il>
 <20140104224846.GH3150@katana>
 <20140105050410.GA5316@tarshish>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="raC6veAxrt5nqIoY"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140105050410.GA5316@tarshish>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--raC6veAxrt5nqIoY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> The platform code (i2c-designware-platform.c) uses the clk API, but the=
=20
> Kconfig dependency on HAVE_CLK is not needed anymore. The core code=20
> (i2c-designware-core.c) doesn't use clk. Originally the driver was in a s=
ingle=20
> file, including the clk handling. This code has been moved to the platfor=
m=20
> file, so the core file doesn't need the clk.h include.

Ah, now I got it. Updated the commit msg slightly to make clear about
the platform driver vs core difference and applied to for-next, thanks!


--raC6veAxrt5nqIoY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJS0952AAoJEBQN5MwUoCm22+AP/ipMR7D3xFSX7SoBWQkUvVer
Wn6yHS3BTyqRYDr5hYl7qHR0Uqp+A6FtoFux1U9ZoHpQ1CXMvns2N8Mzh1O4Rr/V
5jUYJeAMNSbftGnABwTJalnHCNCaDBNxFqKssDXp+MyluCE7ZP+H1dK0uG15hEF4
Xhapxkjy5jNAy1xqpoW0MP23vPQ/pOsnYnY0Pi+epL4Ag67/cJ2dHfPJKPJDoiKV
1Eyy91hsUsh9ossNI2EL6mgVpHP9P/GWugqpGLFgulpshg6otlxhUxsNHAtYI+Vz
vyVD8LrSpLg6Xi6Sd3JJRlgTZ8I2o7x3jp9luip+s7q64wK4I85Ta9y5JQXYo6DJ
XLIEXUXpTfp6X2ywvMCszHxgf3XLiRfq/zvmCElgdxGNY0MmOl9Ov3J8PBV6pjYg
sSvHO5+KIKLRHm3L65P900sTrHzpmfsEjkNj1fJyuF2I9GUfprgu3JB3tXT6AQW1
/YKJeu+zGM90Sjtm5tunhaVFDmyEu3o6wp23qgbTLpoflIg+/dR/Kze+fTwOOQze
k46KhWuMjxZMPg3SAjE7ti30G4AxPQfcqN3NPfPWX1C6ZMWQV1LDOYuKQAm6/MdC
oGYzNSbZQQuhFajaEQk2l9EcjIqUDmxoG01lefhsY4JgAPzDeZB6GdJYr/Ks87vF
Muy7Z9ZVJuWjJb2Q7bgD
=GWwY
-----END PGP SIGNATURE-----

--raC6veAxrt5nqIoY--
