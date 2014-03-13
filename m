From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v3 2/2] ARM: sunxi: dt: Convert to the new i2c compatibles
Date: Thu, 13 Mar 2014 22:27:25 +0100
Message-ID: <20140313212725.GF2696@katana>
References: <1394710643-3411-1-git-send-email-maxime.ripard@free-electrons.com>
 <1394710643-3411-3-git-send-email-maxime.ripard@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ChQOR20MqfxkMJg9"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1394710643-3411-3-git-send-email-maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--ChQOR20MqfxkMJg9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a=
20.dtsi
> index 4cc2f5f2ecad..c1fd510fd2c4 100644
> --- a/arch/arm/boot/dts/sun7i-a20.dtsi
> +++ b/arch/arm/boot/dts/sun7i-a20.dtsi
> @@ -762,7 +762,7 @@
>  		};
> =20
>  		i2c0: i2c@01c2ac00 {
> -			compatible =3D "allwinner,sun4i-i2c";
> +			compatible =3D "allwinner,sun4i-a10-i2c";

I still wonder why there is no "allwinner,sun4i-a20-i2c" entry first
(even if there is no similar entry in the driver *yet*). From the
devicetree wiki [1]:

=3D=3D=3D

compatible is a list of strings. The first string in the list specifies
the exact device that the node represents in the form
"<manufacturer>,<model>". The following strings represent other devices
that the device is compatible with.

For example, the Freescale MPC8349 System on Chip (SoC) has a serial
device which implements the National Semiconductor ns16550 register
interface. The compatible property for the MPC8349 serial device should
therefore be: compatible =3D "fsl,mpc8349-uart", "ns16550". In this case,
fsl,mpc8349-uart specifies the exact device, and ns16550 states that it
is register-level compatible with a National Semiconductor 16550 UART.

Note: ns16550 doesn't have a manufacturer prefix purely for historical
reasons. All new compatible values should use the manufacturer prefix.

This practice allows existing device drivers to be bound to a newer
device, while still uniquely identifying the exact hardware.

=3D=3D=3D

[1] http://www.devicetree.org/Device_Tree_Usage#Understanding_the_compatibl=
e_Property

--ChQOR20MqfxkMJg9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTIiK9AAoJEBQN5MwUoCm2KGcP+QFv9g+78S9jUBBiYDxow+mE
agsUATAymubAEIlXeonV5Brbxh59PQslMHjrjDGydaj/joFJ2jNB2rBGSqmJZqbh
UT2zeGOk5cgMuX4Wr929TqU+tnZ3J08umx/vlyiEJT9idTAQlhJERFHKkc8OXaTf
8ZmXH2SXeZo/1FmIKA/eS1NHbMLziWdZtJIo30tnNbos59cPFy5FCi315bgusypK
LU7NebekFUCyknX4CFQjuU8LvsCbczzN27U8mAX8CBXBXuD+CAqIuODyWwke9ntj
GszuyeywW1CRf+FO9MErZa1D6jgrWIy331hp4t3OqZp0CI0QlM2fywWoZC5GMehR
Y8ZEkm50/N4fZpq+BU5MthtsWNaIY3QZUV6gRvAZuxPXOFf14D2UHsEfEqAOVYzj
teO+fueqLEujtEHi3A1p/dq0EOWj6blh4C7/FRJZsAFi7YcSdJBSFHBEdLOZvryc
04Q3fPi5EagC5JQLds0ItcxLOqpZBiu3HKa6N1QCEFE0JWGJHH9/jkhBbGYq7CaU
iXpcnsyHBiDjm0dhzH0kg9kUE7sXxC2QIhbpdcwYL/rLuODFs6mszsynQUCn4TMN
1Io52wkqGZyFIu4q6Ywhzl1i/G31jxClfXmEZpVMdcUFwobegeWF03OtXmt0NWsV
aSgXI36VRgonECBAPzbp
=7cc5
-----END PGP SIGNATURE-----

--ChQOR20MqfxkMJg9--
