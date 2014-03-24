From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v3 2/2] ARM: sunxi: dt: Convert to the new i2c compatibles
Date: Mon, 24 Mar 2014 15:39:18 +0100
Message-ID: <20140324143918.GJ5416@lukather>
References: <1394710643-3411-1-git-send-email-maxime.ripard@free-electrons.com>
 <1394710643-3411-3-git-send-email-maxime.ripard@free-electrons.com>
 <20140313212725.GF2696@katana>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5VuzLDXibKSJvVYD"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140313212725.GF2696@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--5VuzLDXibKSJvVYD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2014 at 10:27:25PM +0100, Wolfram Sang wrote:
> > diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i=
-a20.dtsi
> > index 4cc2f5f2ecad..c1fd510fd2c4 100644
> > --- a/arch/arm/boot/dts/sun7i-a20.dtsi
> > +++ b/arch/arm/boot/dts/sun7i-a20.dtsi
> > @@ -762,7 +762,7 @@
> >  		};
> > =20
> >  		i2c0: i2c@01c2ac00 {
> > -			compatible =3D "allwinner,sun4i-i2c";
> > +			compatible =3D "allwinner,sun4i-a10-i2c";
>=20
> I still wonder why there is no "allwinner,sun4i-a20-i2c" entry first
> (even if there is no similar entry in the driver *yet*).=20

Ahh, I didn't understand it like that in your previous mail. Yes, it
makes sense.

I'll update the patches and resend.

Thanks,
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--5VuzLDXibKSJvVYD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJTMEOWAAoJEBx+YmzsjxAgR/MQAMK2+MSfDYqtbSvn2d9HsOHx
2QET/meVaNdzkhC4ftoGS2Z4mBvKLebsdf2iVsjz1rgFtLgte2OCvInoH2THBOrX
LletSZKadj2Wg6OFcKDL0bLbnqr626bgFMkRCgIuagjA2ZUGzvXY77jm+6UCbrx4
xPAFGZPfv8g7TfL7lNgWb3p3NUCWvyWd0N1NaT7NPxbFDklXSHUpCp3VqOILy8BT
OmOO9pxrrwEANsF4QzkxNMITkFPFq5aCVEq6T4qvs4uIM+F898iiV/4LJcY7CIpG
5BhPCXD+6WZb0vpzJRsN8yVLgeZk5FIDydJl02EqsWZ9xdCX6YoxKpYt8uuJheaz
Rgv8klYsYw4wtC1jYY2l4PeZw9RNoUCat83cpRH0F7EVy2LuBY6VxybjPnQt/Z63
OU6y/3iZRSGTJJtsOzlcXOHFdd/39Wrine0YdplPxxaDHDMuC1pWwee7sYn+CWT2
XeaP80TI8zR/iVvj4zn65nWj3LqTUF8FvdF9eaTkooO6uFFH18+0iQXl76o7s4yq
XbK6Y1rqX/cvgR40qEzkDzlFGtpJlfa07bIDYslJDIl+SNjeuJ6l4JA7mxWbaIiH
168FrpsaIhQsLgtTROcNN/AJTa0lkJZDvwZAmZlaLikYclM+8tnefCxCWBNRjhEx
TokqLQEwNkG7y8YcmhpI
=rBu+
-----END PGP SIGNATURE-----

--5VuzLDXibKSJvVYD--
