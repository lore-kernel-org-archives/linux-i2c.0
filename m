From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 0/2] Use demuxer for i2c1 and i2c5
Date: Mon, 22 Jan 2018 13:22:04 +0100
Message-ID: <20180122122204.n25jf2rtaoxmi2yq@katana>
References: <1516620563-7965-1-git-send-email-biju.das@bp.renesas.com>
 <20180122114026.uqozk4cbhfrjwqmd@katana>
 <KL1PR06MB170270EA30591C7636941361B8EC0@KL1PR06MB1702.apcprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="endxsjuhdqhrhiw3"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <KL1PR06MB170270EA30591C7636941361B8EC0@KL1PR06MB1702.apcprd06.prod.outlook.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Biju Das <biju.das@bp.renesas.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Chris Paterson <Chris.Paterson2@renesas.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org


--endxsjuhdqhrhiw3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> How do i2c-bus gets details of gpio lines associated with i2c bus for bus=
 recovery?

As you can see in the code, you don't need GPIOs if you can control SDA
and SCL directly. The I2C IP can do this.

> On top of renesas-dev branch, I am using the below i2c-rcar driver relate=
d patches.
>=20
> https://www.mail-archive.com/linux-renesas-soc@vger.kernel.org/msg22278.h=
tml

Those should be enough. They are not?


--endxsjuhdqhrhiw3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlpl12gACgkQFA3kzBSg
KbYI5BAAgmXrxBBASKj4al3twXgcIqptQksef0iIX/eT346Sb9oguGAdvdDDuZXs
mmSYtA9dLJdRZvG0u/Jyqp3zzEdcty+fyF0o98KpgYbKqcsd9QqiQ3AF+nCibd6S
eqeH113Xdu/FcdhkLCzkpmgz8ZRRlTZ7ybXE21BYaOlL+C+KpR3NAIUwMiTmBwpE
hk4esGtzANK7rClIrU9Wbnwyv+R3sNN/ZJDgBCe5kHtq+ntoQMJ823m2KRnhAYhD
1s+ld+/D+0NeRwmERJmJGEHTCFfC5Ms+h22V7Xc2JQWukMEOOS5Dqbs8YWf2FEm6
vmEbw2apOcbKM5NGcEV1hgp3FRTufV5Z9tpLTfwxRPVmE8PKNMutPLTwAgCjTSHX
WY1WJTynOBIoX4mIP/T+6iTfrNLdTc/+kgC7pzpiS7EkR7aa3UCHaSBslkxEuBvK
MTXhgfafSE5x/xgr2x6331EPcZFO/ExLxSWwS9bSJkaB5FMU1QDV0O/fLHH/exxO
v8wGLF6+D1XdES/UAb3Oiu5L4a6/2XLxV0LZu3SZ8XvytmQj8v8GnUG1q5CmH+H+
E3tE1shSHWDLGZ70yD1HA4gRw8+YfMhOcw+MUkpFCIg+Rrx0D6CErP0zLAeZV5Xj
G5nJsbzk08fkEvmxsWUqUVKMYaXe0D2qUPfX2uSQGfQSmdF9jxo=
=2kgH
-----END PGP SIGNATURE-----

--endxsjuhdqhrhiw3--
