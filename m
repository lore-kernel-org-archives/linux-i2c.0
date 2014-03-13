From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c: exynos5: remove unnecessary cast of void pointer
Date: Thu, 13 Mar 2014 22:21:04 +0100
Message-ID: <20140313212104.GE2696@katana>
References: <000501cf3cc8$4b7f8d90$e27ea8b0$%han@samsung.com>
 <000601cf3cc8$70627460$51275d20$%han@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ep0oHQY+/Gbo/zt0"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <000601cf3cc8$70627460$51275d20$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Naveen Krishna Ch' <ch.naveen-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Taekgyun Ko' <taeggyun.ko-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--ep0oHQY+/Gbo/zt0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2014 at 10:22:59AM +0900, Jingoo Han wrote:
> Remove unnecessary cast of void pointer, because 'algo_data' of
> 'struct i2c_adapter' is a void pointer. Casting the void pointer
> is redundant. The conversion from void pointer to any other
> pointer type is guaranteed by the C programming language.
>=20
> Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

Applied to for-next, thanks!


--ep0oHQY+/Gbo/zt0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIbBAEBAgAGBQJTIiFAAAoJEBQN5MwUoCm2BKsP91LpW87KX3C1AHD35zUKWPOI
PAUytzywXoK0CkBl0Mj1mJWkWn1t+pblB37xv6n+SUr7tUs8qm8UJUdBRE1ONP1m
wYvWfEdFxIZIdDHgxwlWRGDQRBC0xRrdW9NcwDqk/37ueFfPGMTrBluL1nXdjw0s
U9auMGteZIrDwLIEayDyjfaPjSq5tFC5ABSPfrIAXCpy5ylE12NLvsXFcOlpoalt
QhYpgzi1j1EdiEg1iCI8T/LbGTCzitLl+F9PBd1R912ThOY4wQkbv1AmS41qACAQ
oqPsLC0FqYq+KhxTkl8dNueiJ39sPIXf9SVny9LE0LARDSh64vAocz69eVGvYKRI
swkcn8+obn5nqscrVB7EvQqXm8upjr/EK46LVnDjMznH2XFmwBriEAjtaRZbeHgi
3zxTWe7bMEKM4t4IbD2qz42pSKQDajd/9RE9W7b1yudVCG/oOt6QyNFs/4j0Ju7Q
sPHPxrYW6LrM7JYlbZbNdYnvj3ngn/SGwAN1Lh5NmXYPeHKZmamRvaeuWaYxQ3Jh
KS6CxHf523FvLGye4E5afy7gKHiX6kuB2rahySQPW5B/ziKq/f4RpnF5YGCOQJaD
49OUQAVDvmVOZ33wtkRShli1cAVgcRM1eucLFfU5q2qbBRiOShCHWESSsI20z4ak
xy4sQ917q6ciV8g0Rn4=
=tIFC
-----END PGP SIGNATURE-----

--ep0oHQY+/Gbo/zt0--
