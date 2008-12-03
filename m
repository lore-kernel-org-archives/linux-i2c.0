From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH][resend] iMX/MXC support for I2C
Date: Wed, 3 Dec 2008 14:27:52 +0100
Message-ID: <20081203132751.GA12064@pengutronix.de>
References: <gh3f1h$fto$1@ger.gmane.org> <Pine.LNX.4.64.0812031355120.4717@axis700.grange> <gh609o$gs0$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <gh609o$gs0$1@ger.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Darius <augulis.darius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


On Wed, Dec 03, 2008 at 03:07:08PM +0200, Darius wrote:
> Guennadi Liakhovetski wrote:
>> One more thing: you also want to do something like this
>>
>> 	i2c_imx->adapter.class		=3D I2C_CLASS_HWMON | I2C_CLASS_SPD;
>
> some time ago, it was I2C_CLASS_ALL, but Jean told, that it will be remov=
ed at all :)

I also think it is better to not ask for probing. Those flags were
recently removed for some platforms, see for example commit
0a346dacee18ff69f6162d9860d723a058f47321 or commit
618b26d52843c0f85b8eb143cf2695d7f6fd072d. It usually causes more
problems on embedded boards.

Kind regards,

   Wolfram

--=20
  Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry

--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkk2iVcACgkQD27XaX1/VRuN4wCbB6jEULX4+s0UNTmVcDgDz3zM
q14An0d3s9sd5BYjcTm8fn/PZWBknYoD
=q1oy
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--
