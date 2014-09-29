From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v2] i2c: axxia: Add I2C driver for AXM55xx
Date: Mon, 29 Sep 2014 12:13:19 +0200
Message-ID: <20140929101319.GB1559@katana>
References: <1411983159-4692-1-git-send-email-anders.berg@avagotech.com>
 <54292F74.2030209@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CUfgB8w4ZwR/yMy5"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <54292F74.2030209-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Varka Bhadram <varkabhadram-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Anders Berg <anders.berg-1wcpHE2jlwO1Z/+hSey0Gg@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--CUfgB8w4ZwR/yMy5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> >+	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>=20
> Error checking on *res*...?
>=20
> We should *return* on platform_get_resource() failure..
>=20
> >+	base =3D devm_ioremap_resource(&pdev->dev, res);

Nope. devm_ioremap_resource does that.


--CUfgB8w4ZwR/yMy5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUKTC+AAoJEBQN5MwUoCm2kqgP/RQj10pzNWmUtFQ1t4kHk2PL
8Oa7mbWJsMJuoMlc235rH975KxGFTkD/KxDdo7YOUNM2d8ted+kQBZQTNnwmt8rR
EBAgDsYcbLYFT6tZaPua15P+DdBD+CMQ1jSj7c9yEqHQSCofzxrGLrSiJB+awbPC
Ode2yNX5yqu9HzULxeKZTF0LpAKm0SiJnCKA4ABt2omUT+ZUY8a9eaqsdlidWDSo
eATHxTmSM3CxIlMHmVDkRyntO51W1eEVuvXXIS8/iIhNbK6Piz0rD18fIDVTvcXo
66R/6o5OMB5FSchHH/FaIVdb7VPM2BwjDdvY4/x+dWGQnnLQzr6joFYV2kzE1gTh
nLeEO4o2zWcwRjqyMYV7mPe0UOYoR0jK/xG1q2UVMdTzHp5lXQf+cw8zcNTzdd/X
SNAbb0zLUq6T5z9MGHnXgSUL+F9ToArD1rIWIzR2Aof7C+R1c1LoCKuxE16+iJa1
CwyMLCvugSaqXAJGDs5Njmrtq2B4DecfOezYSB4TqAnDYtWwfjerQ2MiBuhFPUKP
BJLlVMnhd1zJyL5WrPmKxxFKcjsBBMJ7MDZOECJxQjGHWL6jZPKdWv6K1s7suXfx
iuHhyQoMHNOFdjDuFEAVLu1nTl8YmXbzknVjOzuZF/oWmFlbEhDHQk+ehj0Tulr2
D1UkJ9ogO2bRyIaMRSZI
=uHhg
-----END PGP SIGNATURE-----

--CUfgB8w4ZwR/yMy5--
