From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: fix reference to functionality constants definition
Date: Thu, 19 Feb 2015 17:01:20 +0100
Message-ID: <20150219160119.GA1664@katana>
References: <4496c1554df0c37d12d109604426bd9a3ab1e974.1424343090.git.baruch@tkos.co.il>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NzB8fVQJ5HfG6fxh"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4496c1554df0c37d12d109604426bd9a3ab1e974.1424343090.git.baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 19, 2015 at 12:51:30PM +0200, Baruch Siach wrote:
> Since commit 607ca46e97 ('UAPI: (Scripted) Disintegrate include/linux') t=
he
> list of functionality constants moved to include/uapi/linux/i2c.h. Update=
 the
> reference accordingly.
>=20
> Fixes: 607ca46e97 ('UAPI: (Scripted) Disintegrate include/linux')
> Signed-off-by: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>

Applied to for-next, thanks!

--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU5gjPAAoJEBQN5MwUoCm2cZEP/iVKTzoBJkN+uTILJ+yzX0nF
zm2Z4CL73ESNXS+AL2J6fuaNPBJc2tUJbkTKPAlrMdMP7VxJCR7v0BFaZTMMRh0e
BBc2YEXmh6hhs32pULC/0JYU04yj60ikAoSpOuac4qNbRy+8Ew/PYA1aJQWBKnxy
ld6fK9o1no4JBHBPnEoosKJvEZqWmFHs27joQucOUWH0iv/fHWxUMECBPKEEKXeP
JX+fZkndFYQLUur9M0Pjaf78CXTl0ly/0lidnSW/QSivgaZbu9PZlj8sJBlO+LVy
QDwGksGXbgnbRwjAht3PjyT8gysKcsWRwHYC9x0QFiU6RFxhLDKvx1J6C7/hzouT
58gx3RugmJPyMDPdrLA83TOfa27ePIXs7qBJRj9UdY5KubnbFHOKxoYSEqTHyfLO
lAoer2Tn94izZYnv/xaA1wgaezZH3X5Fp91kJ1KAyjUdPb+X+s8sXj5NNDVnzxd8
KzKLftyy+5+ipzSAVk8CYqOyLpYZrvJn7cy3O3IHLBdzJEN7+48SW1JRGo/aJEKn
12dvfkZYdwvMg85vjgLuHs8UyBE5j2X2/zooNvch3QPlyTicdzb5XpoYRAbrfSGF
wLVjKb7ihElBILE7OdS10tU8w7bsXPo3kXygZtoNNFFCLaUUPNDD6xg0/pv4MHH4
fSLAmrHf0Yj/28qLTs7x
=ALSv
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--
