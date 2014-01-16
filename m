From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c designware make SCL and SDA falling time
 configurable
Date: Thu, 16 Jan 2014 20:43:03 +0100
Message-ID: <20140116194303.GC4127@katana>
References: <20130828153429.GB7066@ab42.lan>
 <1381244455-3836-1-git-send-email-romainba@abilis.com>
 <20131009075538.GQ3521@intel.com>
 <5255FAB5.7080803@gmail.com>
 <525A85D6.3090608@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="da4uJneut+ArUgXk"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <525A85D6.3090608-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shinya Kuribayashi <skuribay-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
Cc: rmallon-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, Romain.Baeriswyl-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, pierrick.hascoet-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org, vgupta-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org, chiau.ee.chew-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, romainba-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--da4uJneut+ArUgXk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> >You can also use the gcc-ism, which is a bit more concise:
> >
> >	sda_falling_time =3D dev->sda_falling_time ?: 300;
>=20
> +1

ditto


--da4uJneut+ArUgXk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJS2DZHAAoJEBQN5MwUoCm2qmMP/i30l5qC0IveqNude9EHHU2i
GdLGveQ6xKL5rvqytQ/u13psjSWf+ba+gnUv8+tY2ExlH9s2tNEdwWtBfU+tVhhw
GImF3z+Lau8NA0bOA5VBkLQUnEmFKb2N9IJ29uEi6CGFAWdvRcQfT8ohvjvGC99J
UChSq9LJeo28BNp2lOR86TM0UzoWvzAS+Qzb7q55VJxgYvmg+LZWJhb0AKm8Za5w
5hInrXOLPd6m4yNj17Tl/V2nGES46n28D7ZPYjp02Tf4Xkjpcx0/A9xIhDl3gq2h
3uJk65kq6iyqgHYgv2B7C092zF8YjSBp3r8vAWCOACx90rKdYKkeRzRRDfCc/FP4
7HqWK33kXHAcBJYBz6mp1Vjt05plaF498OF0Wp+ONn+SSxtlSvUFwhAKx6Qu2cg+
M+tiuuAvFmTB+w4+cALNeoE7uRCyXUzcNP+J8LBcnatcdBzoyEDVCgsSKY+fgLXW
xchSNFMh8h4Bla2yef9vJjZhHI+5C5VBvpCUfRFCu+EPhNGamiymuDA4vw/jhUk6
7LdDj1ElTQgdaNnbxEPo9uTsBuyud3qHOgbdhXvsXPWxkPoHy2uZWk4e92KqHmzk
GTL9lPcx80lkSWm40ntB/jyjXOy7B6nkd+Ba1D2XCjZc5Mcd2I1k+OysMrqqe+4c
JSZjPYBNI2zYIPiuoZN8
=kRrR
-----END PGP SIGNATURE-----

--da4uJneut+ArUgXk--
