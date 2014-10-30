From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: I2C OF IRQ parsing issue due to probe ordering
Date: Thu, 30 Oct 2014 14:21:36 +0100
Message-ID: <20141030132136.GA23852@katana>
References: <2287003.09eTeKUr1V@avalon>
 <20141027125819.GA12641@katana>
 <20141030125645.GA19386@ulmo>
 <1441244.9DO8HMds24@avalon>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1441244.9DO8HMds24@avalon>
Sender: linux-kernel-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > See:
> >=20
> > 	9ec36cafe43b of/irq: do irq resolution in platform_get_irq
> >=20
> > I suspect a similar thing could be done for I2C.
>=20
> That could work. We would need to introduce a new i2c_get_irq() function=
=20
> though. Wolfram, would you be fine with that ?

I'd think it will look pretty similar to platform_get_irq, no? That is
fine with me.


--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUUjtgAAoJEBQN5MwUoCm2kEUQAJMwlni8AXCmzVG5wNPuEZHJ
DLfxkUzXyDoOB0VLMlVcPHoaoxpZBbgzOhS1ODFVtfcoTBMmjWN4Xq5SR5BgeWxu
BHfywPFgxdGKBKYqeB0wRMOhhVyhU112XgOYQHhJhyTQHmkMYrHjImrX8zqc2KEQ
lpQhUCVawaVQd+fE+CTkDkAJozGHksGGA6HA/lg7JF2e0EfSVmcLUITLpR+aHFCc
g2GZ95VVJDH2ISgaEpf1Az23UJcy2xczsew6hAPrhNBIMlXsEmTUwJxvzA6F8JwS
4zVKiKfApguJioYRnKU6q8X6FtBsn0h1JYVDzn+f0tdjBtBiLQxJ5mLuKopCdWCr
QzgvITd8xCoHYhjRSmVBBMYTC19tjqhZoOR/HNZliXRwpONDLJNVEbDQYj42CLcr
8Eo9TDcu2hDeXY9FqPg/SI4KSYBow5OwDQs5uQ6jEiBVrhm24OX0shbjx4NZ3JKf
0RPyCuJGObbuLixN++4R1H2o82HSxO7lmTdFnVqbVHGjuLZ6LoeMxn0yIe2l1DQ6
nCB0YG0fWPbSz0+vWp4hi4PkWe5jf3iITZ+lDus9CfENy4Jz/UjmVZ94FPHIVW2g
mDMcig3Koh19Fe+OkXXGhL4CZFiklzHJN55Iic4wFKH5Ws0gbCgyg7jS/cFyYO3O
oZHOptiqZcmCw0AzCj+J
=fJtU
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--
