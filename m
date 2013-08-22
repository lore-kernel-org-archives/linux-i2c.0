From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v6 3/4] ARM: dts: mvebu: Introduce a new compatible
 string for mv64xxx-i2c
Date: Thu, 22 Aug 2013 18:22:43 +0200
Message-ID: <20130822162241.GC31704@katana>
References: <1377181169-17483-1-git-send-email-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="32u276st3Jlj2kUU"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1377181169-17483-1-git-send-email-gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Nicolas Pitre <nico-vtqb6HGKxmzR7s880joybQ@public.gmane.org>, Lior Amsalem <alior-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Maen Suleiman <maen-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Tawfik Bayouk <tawfik-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Shadi Ammouri <shadi-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Eran Ben-Avi <benavi-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Yehuda Yitschak <yehuday-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Ike Pan <ike.pan-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Chris Van Hoof <vanhoof-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Dan Frazier <dann.frazier-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Leif Lindholm <leif.lindholm-5wv7dgnIgG8@public.gmane.org>, Jon Masters <jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, David Marlin <dmarlin-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--32u276st3Jlj2kUU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> --- a/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
> @@ -5,6 +5,8 @@ Required properties :
> =20
>   - reg             : Offset and length of the register set for the device
>   - compatible      : Should be "marvell,mv64xxx-i2c" or "allwinner,sun4i=
-i2c"
> +                     or for controller which support the I2C Transaction
> +                     Generator "marvell,mv64xxx-i2c","marvell,mv7230-i2c"

Too complicated IMO:
+			or "marvell,mv7230-i2c".

DT creators don't need to know about transaction generators. They just
supply the compatible string and the driver knows the details.

> +For a controller which support the I2C Transaction Generator:

"For the Armada XP" - there might be later IP cores on later SoC with
transaction generators and different errata. They will just get a new
compatible and the driver know the details.

> +
> +	i2c@11000 {
> +		compatible =3D "marvell,mv78230-i2c", "marvell,mv64xxx-i2c";
> +		reg =3D <0x11000 0x100>;
> +		interrupts =3D <29>;
> +		clock-frequency =3D <100000>;
> +	};
> --=20
> 1.8.1.2
>=20

--32u276st3Jlj2kUU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSFjrRAAoJEBQN5MwUoCm2wBYQAKWM/b1rFdi//9tvOhpA2hEx
I8sk2MrVmumbPqFgRmeLIPtJUNvvKrrfIuknMz+D94QIPaKzTvoPGE+lqKHzaADw
A4LRtogsl9xDVkbgzixvqCWAw7Hi3x8CZYONBVjAPhSh9upRwkugPnkYhb9Zild/
3LGANoN/ijnGk/FGFhxG9ZRt+CDf695hyXMHGOB1kB9Irn1NE7gQ/S1Y5lDKTcSx
eCeLawNErzt/07TSKFw/QJ0x0mjDmS3Zj23BOQ0VWAspOMO3IS6YoxqyykRpsVxg
Uait6QOZKcecUgfSNafESbjllIJFNTlAqntZV+TMDRJ/A2AwQQJl+TeXSuM5AD68
EixKsoRmTaV17TykVt6eqD8fN+0mZZf2bQNR4Ksui73PQr39VnRKbTV60Ec5Z3kM
XWMpjd1/67YeJ68L8HlgQ+czS3fL4r2TKODd02Ocj2s33bxheKj8e1bN1p94TURg
HX3tk6fRvKasl01Ri1lJx3BFNj/y8DuDw9vigVN/T9u5OSnJeG5VlkoF2tVd/OdN
aE1Tun+muMz1VLfC4ev7DrimdwMJZJdQmKtteVuWClf6pEn/rA7x9yqBegt2O5p+
Y0D/oRLlwN57a8UlkE2038DymbDyTIwtdXUkOqwTCa8H2ePSnzvTLjJ0n2feqAwM
0UnW6p8qBEicL2ZHjH5o
=MUfN
-----END PGP SIGNATURE-----

--32u276st3Jlj2kUU--
