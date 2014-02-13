From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v2 2/2] ARM: sunxi: dt: Convert to the new i2c compatibles
Date: Thu, 13 Feb 2014 23:52:48 +0100
Message-ID: <20140213225248.GB15350@lukather>
References: <1391680285-16668-1-git-send-email-maxime.ripard@free-electrons.com>
 <1391680285-16668-3-git-send-email-maxime.ripard@free-electrons.com>
 <20140213082630.GA3119@katana>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DKU6Jbt7q3WqK7+M"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140213082630.GA3119@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--DKU6Jbt7q3WqK7+M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2014 at 09:26:30AM +0100, Wolfram Sang wrote:
>=20
> Why is the devicetree list not on CC? (Added now)
>=20
> On Thu, Feb 06, 2014 at 10:51:25AM +0100, Maxime Ripard wrote:
> > Switch the device tree to the new compatibles introduced in the i2c dri=
vers
> > to have a common pattern accross all Allwinner SoCs.
> >=20
> > Signed-off-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> > ---
> >  arch/arm/boot/dts/sun4i-a10.dtsi  |  6 +++---
> >  arch/arm/boot/dts/sun5i-a10s.dtsi |  6 +++---
> >  arch/arm/boot/dts/sun5i-a13.dtsi  |  6 +++---
> >  arch/arm/boot/dts/sun7i-a20.dtsi  | 10 +++++-----
> >  4 files changed, 14 insertions(+), 14 deletions(-)
> >=20
> > diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i=
-a10.dtsi
> > index 28273f9..ac65c8a 100644
> > --- a/arch/arm/boot/dts/sun4i-a10.dtsi
> > +++ b/arch/arm/boot/dts/sun4i-a10.dtsi
> > @@ -518,7 +518,7 @@
> >  		};
> > =20
> >  		i2c0: i2c@01c2ac00 {
> > -			compatible =3D "allwinner,sun4i-i2c";
> > +			compatible =3D "allwinner,sun4i-a10-i2c";
>=20
> Can't we have:
>=20
> 	compatible =3D "allwinner,sun4i-a10-i2c", "allwinner,sun4i-i2c";
>=20
> ? And keep the old "allwinner,sun4i-i2c" and extend it with a SoC
> specific a10 compatible entry when a distinction is needed?

Actually, the two are exactly equivalent. The point is that the
compatible naming scheme doesn't follow what we are using (which is
<family>-<soc>-i2c), so we wan't to get rid of the old naming scheme
all together.

> > diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i=
-a13.dtsi
> > index 6de40b6..537072c 100644
> > --- a/arch/arm/boot/dts/sun5i-a13.dtsi
> > +++ b/arch/arm/boot/dts/sun5i-a13.dtsi
> > @@ -377,7 +377,7 @@
> >  		};
> > =20
> >  		i2c0: i2c@01c2ac00 {
> > -			compatible =3D "allwinner,sun4i-i2c";
> > +			compatible =3D "allwinner,sun4i-a10-i2c";
>=20
> For non-a10, That should be at least
>=20
> 	compatible =3D "allwinner,sun4i-a13-i2c", "allwinner,sun4i-a10-i2c";
>=20
> or
>=20
> 	compatible =3D "allwinner,sun4i-a13-i2c", "allwinner,sun4i-i2c";
>=20
> depending on the outcome above.
>=20
> Or is my knowledge outdated already?
>=20

Since they are strictly compatible, we don't need to introduce any
different compatible string here.


--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--DKU6Jbt7q3WqK7+M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJS/UzAAAoJEBx+YmzsjxAgWqMP/2thalPTiivRYDtS1jiNsAxx
RRf6cbCB8c2CI19YU4juNwRjy2IOoRZaeDW8aW7O3Coj7oBb+KGwOBDyU0Ldj1v7
Nz/KOE8vikJjiBIEIhpkpPoau8JWrX8QkQvj8fgt7ZXwxRo4VEnIw6rx+wN4XsdL
mxQEDvV7mYhGqD9JjlxRdq62Gnb5uWGvjqeIthWVshD1foyzDfSfzdEGu1YlVNcW
sxlWfpCayD9lUrHB6CAc58xExpQwhQaEn3rwckotN8RhRezvV1abAIHZLOIg5aGL
oWbWqeUjiS0Z7Ja6M56tuIdUIR8MkBqJBvYRKnZcDVRW7Lsv6y4pXczJNNg1yEX9
dHlUwJ3HhT45CpMx8a/oI9VNMyeIg74JR6Tm/FLRyBc1F6QQfv9bEN3eHjAINvlu
SI01rqd7UQ8wUksxtzPUM5QStMZCYeoVI42UKHpFG56dhuIBlkkRAAhOaE2jwVLd
l4uFbSbnz8jOo9kOHnFStMoE52kjkuwcGIUx/4z9PUsnj3xfMg+NWPUpmoK/kPxC
S7nbApYtYbwlIrhbeiABvaEvk115TTfVL4gplYTtPYkRSA6pfiZH/sTkGw3MvnzD
HX7zLGMeJ6hGl5HSwNDSmkeZkcP+HffxMoXP46dAOcQ9eFnjnhJ+c6ddd4jqVxlV
tw6GXJVR+cVgpNImJmTU
=7c0p
-----END PGP SIGNATURE-----

--DKU6Jbt7q3WqK7+M--
