From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c-intel-mid: remove obsolete driver
Date: Wed, 5 Jun 2013 16:06:34 +0200
Message-ID: <20130605140633.GD2934@katana>
References: <1370250303-17414-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IMjqdzrDRly81ofr"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1370250303-17414-1-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--IMjqdzrDRly81ofr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 03, 2013 at 12:05:03PM +0300, Andy Shevchenko wrote:
> Moorestown support is removed from kernel and Medfield is supported by
> i2c-designware-pci. But i2c-intel-mid is still in upstream and community
> resources are wasted to maintain it.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

Happily applied to for-next, thanks! I guess your previous attempt was
probably overlooked. BTW, designware-pci still supports Moorestown.


--IMjqdzrDRly81ofr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRr0XpAAoJEBQN5MwUoCm2og4P/2WuCs27ANI7ts8lu9pFAZx+
JvZbBu03jLTElVdQA2GrBk5LDsNDedtmw+RlEhuyijXMni7LT73XepzrNNpQ3Irg
VcS+zu5yp9eIiYX2Op2psTD61zmjT5S0raM3Z+AzOKUekLajhfrR9OTpTE9xBJiF
QC1R/F+PoMKT+F/wlsPa1o31li8hDwN85vmsmnmaflo5ylcjo4pbZmPyNlU/tEIQ
ryAvHWqNZoS9pz5fpa9g0CskrziXdlK/IR3db3tLz4GIkG+CauuctQ5iBwAMv9Cg
hT+fAUOMbd/mzbo2ZH4obGx4JZDQrWlXfT4uHjN5XyjIK29VBhjF2tkvLOsqZZbe
HyMXABZ6WJ13KeyxMWJXtgEeD6DnBHMF56mPex5e0Yr0MrYkIsjt2MDGkkEZ+N4R
e8CVJha/KT0fv3qOYty45H4ol6+BKBnK7fh40qi8kkmpaFbRDMjnxbGuuMn6SyDm
0z2XNTYlIRhiXXQUTlcuEEhNA2YeSwbBR15ZpBa8EHVLhtBfxGRgkZ6r6eW7QlQl
3iDJ23l2UmEFXFKkcA98erR8X49wCbWi2JgScycOn/mQ2yHqO4CtLv1w3wmE/MiO
CvCAOAPJdw3gIYIkDtjQZ2uYT5Ga+L/DHLFBHT28moKzh/Ala1TScYDQQp+ZGxuQ
Lpf0YsA2F7EHOVeB1pLl
=RB4e
-----END PGP SIGNATURE-----

--IMjqdzrDRly81ofr--
