From: Wolfram Sang <wsa-dev@sang-engineering.com>
Subject: Re: [2/2] i2c: constify i2c_adapter_quirks structures
Date: Fri, 18 Nov 2016 02:00:08 +0100
Message-ID: <20161118010008.GA24025@katana>
References: <1476552722-12352-3-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="uAKRQypu60I7Lcqm"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1476552722-12352-3-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: Wolfram Sang <wsa@the-dreams.de>, kernel-janitors@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 15, 2016 at 07:32:02PM +0200, Julia Lawall wrote:
> Check for i2c_adapter_quirks structures that are only stored in the
> quirks field of an i2c_adapter structure.  This field is declared
> const, so i2c_adapter_quirks structures that have this property can be
> declared as const also.
>=20
> The semantic patch that makes this change is as follows:
> (http://coccinelle.lip6.fr/)
>=20
> // <smpl>
> @r disable optional_qualifier@
> identifier i;
> position p;
> @@
> static struct i2c_adapter_quirks i@p =3D { ... };
>=20
> @ok@
> identifier r.i;
> struct i2c_adapter e;
> position p;
> @@
> e.quirks =3D &i@p;
>=20
> @bad@
> position p !=3D {r.p,ok.p};
> identifier r.i;
> struct i2c_adapter_quirks e;
> @@
> e@i@p
>=20
> @depends on !bad disable optional_qualifier@
> identifier r.i;
> @@
> static
> +const
>  struct i2c_adapter_quirks i =3D { ... };
> // </smpl>
>=20
> The effect on the layout of the .o files is shown by the following
> output of the size command, first before then after the
> transformation:
>=20
>    text    data     bss     dec     hex filename
>    3651     472       8    4131    1023 drivers/i2c/busses/i2c-axxia.o
>    3683     440       8    4131    1023 drivers/i2c/busses/i2c-axxia.o
>=20
>    text    data     bss     dec     hex filename
>    1069     216       0    1285     505 drivers/i2c/busses/i2c-dln2.o
>    1101     192       0    1293     50d drivers/i2c/busses/i2c-dln2.o
>=20
>    text    data     bss     dec     hex filename
>    3211     484       1    3696     e70 drivers/i2c/busses/i2c-viperboard=
=2Eo
>    3243     460       1    3704     e78 drivers/i2c/busses/i2c-viperboard=
=2Eo
>=20
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Squashed with the other similar patch and applied to for-next, thanks!


--uAKRQypu60I7Lcqm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYLlKYAAoJEBQN5MwUoCm22BEP/1ttdvtqMLobFL5slwsq3d2S
V/D+79qsGfQrBmcBfJikAJq7kHQeYyBp8OAdO2Mp8TPN8T0vu7x4n44+/jmBLTQt
jXvbYsvl8pFnyJzeyhl+CMR/7MhZoIHH39Ec6j7N5YkCB0sdH7nIe8OKJvzLx4g6
oDZOCeJ60JoHwJOr7NYqpDrpWj7iUZe3iN5aFGRs/Aj5M8Gr8EQ6oiWiSnJ48q9o
jqdm2rWzNXXZ0tjVj9pQD7/UAhg3OFfpoRA2XohwhBM+9qV4evVOMJgf5gXE1toG
7TWMh8r8yIZyElT+1zI3ZQqKgsTfiu/ZcPHIxQJGGJ3uK3VtpxKTZTLvmUHndnbV
CMUOrgmqjFTDTdETL9757m6XbXgThyEkmBphSZwRR+2JrekvSjQpc5xKHquob2nu
+Tist0L5ZjzXTsEpfg3iFCv0dH10PjGNm20Wn2VNRAmEjU1Q9z+vUYcgXKFCMcv2
Z/6nvsgLLvW2rDbwxFSJOTs4hAwyznx7/UGfDskodm8AQ9UtBaksYwH9NLZ1D4PF
bT6mh+HJJ3XCOEwJ3ZlQsLMOKFpLqMrGqQwi5Jkv9IVC039wTQYjUXohmMTVGTut
KNVgORXNe/8Xh1wWMBHYaxFcuFwAQbvhaJoz48+hPm+OsEHJV4vhJEk1h3qrSuXc
9kyTTPYmxJFiY/1XIulV
=qoJv
-----END PGP SIGNATURE-----

--uAKRQypu60I7Lcqm--
