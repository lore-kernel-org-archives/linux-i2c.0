From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 6/6] media: i2c: Convert to new i2c device probe()
Date: Wed, 31 Jul 2019 21:53:46 +0200
Message-ID: <20190731195346.GH4084@kunai>
References: <20190710215149.9208-1-kieran.bingham+renesas@ideasonboard.com>
 <20190710215149.9208-7-kieran.bingham+renesas@ideasonboard.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pfTAc8Cvt8L6I27a"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190710215149.9208-7-kieran.bingham+renesas@ideasonboard.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc: linux-i2c@vger.kernel.org, linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Mauro Carvalho Chehab <mchehab@kernel.org>, Leon Luo <leonl@leopardimaging.com>, Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>, "Lad, Prabhakar" <prabhakar.csengg@gmail.com>, Steve Longerbeam <slongerbeam@gmail.com>, Luis Oliveira <lolivei@synopsys.com>, Jacopo Mondi <jacopo@jmondi.org>, Wenyou Yang <wenyou.yang@microchip.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, Akinobu Mita <akinobu.mita@gmail.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Andrzej Hajda <a.hajda@samsung.com>, Mats Randgaard <matrandg@cisco.com>, Hans Verkuil <hans.verkuil@cisco.com>, Wolfram Sang <wsa+renesas@sang-engi>
List-Id: linux-i2c@vger.kernel.org


--pfTAc8Cvt8L6I27a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2019 at 10:51:49PM +0100, Kieran Bingham wrote:
> The I2C core framework provides a simplified probe framework from commit
> b8a1a4cd5a98 ("i2c: Provide a temporary .probe_new() call-back type").
>=20
> These drivers do not utilise the i2c_device_id table in the probe, so we
> can easily convert them to utilise the simplfied i2c driver
> registration.
>=20
> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> ---
>  drivers/media/i2c/adv7343.c  | 5 ++---
>  drivers/media/i2c/imx274.c   | 5 ++---
>  drivers/media/i2c/max2175.c  | 5 ++---
>  drivers/media/i2c/mt9m001.c  | 5 ++---
>  drivers/media/i2c/mt9m111.c  | 5 ++---
>  drivers/media/i2c/ov2640.c   | 5 ++---
>  drivers/media/i2c/ov2659.c   | 5 ++---
>  drivers/media/i2c/ov5640.c   | 5 ++---
>  drivers/media/i2c/ov5645.c   | 5 ++---
>  drivers/media/i2c/ov5647.c   | 5 ++---
>  drivers/media/i2c/ov772x.c   | 5 ++---
>  drivers/media/i2c/ov7740.c   | 5 ++---
>  drivers/media/i2c/ov9650.c   | 5 ++---
>  drivers/media/i2c/s5k5baf.c  | 5 ++---
>  drivers/media/i2c/s5k6a3.c   | 5 ++---
>  drivers/media/i2c/tc358743.c | 5 ++---
>  drivers/media/i2c/ths8200.c  | 5 ++---
>  drivers/media/i2c/tvp5150.c  | 5 ++---
>  drivers/media/i2c/tvp7002.c  | 4 ++--

These drivers, I did not review visually but build tested them and
verified they didn't show any build warnings or failures. Glimpsed
through the conversion pattern. Looks all good.

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--pfTAc8Cvt8L6I27a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl1B8ckACgkQFA3kzBSg
KbYEMRAAhmwhczAhbJim7z/RwnJLFoLsdVmxLuFphdE5tArR1CVlmSnLmePsb+SV
oUHKtP20MJqd0JG5BQPthFD14pLhhgPSqEfx5wuEZ8D6JVHIVnj1Xghr+eg7B3/2
+3o9zhbn57geSAmR56Mqm23SR9Je9WeggL8jtQll/JScKzyMo672s8U6sX5fJhy6
tQ87t59yQ6QhMX1uu4yCPLwlbryhoFYwB8zeYtDsMJdgyg9AbMCLT7XePRmZdR6B
BDmzajGEOrRYtW48Nl0xI7lyO79iLuD8JvqiqMPmM5sbz0GntdItUMgwbLFHgaAN
tWLRMJlg/WffwWP7HEzPctBR1EMgfoCBDbPTdbckYuzhbtXnUn2bZe4yJalo73U2
aoAnO4/LUqPkheQSrZklOhc6IdAuYCVvRs5DfryTubv7UcHpFVwTAZpVqWvU4mN+
O351GpW8QdkBqCwu7M2J/dbCF2Xbz9kRuDdD1v+gS4eaMoVy68CB2IcYUgh52EnW
aWqLKnIn1Vkz02N9sM35OvIYZKBaX5/EXjJSGkjltV65bSC20CqFBMFwRfuE+4vB
SfkxTnwTI5beAn2ouZope7AanpO08QHCSb46JC86fMTt+3M9lzw0ehBw8cPv1A1j
VPldElHq9IVpVRUyy4gZMJmvDzWtR8LCXFG3lsQ6rYTLa8dlI54=
=FykV
-----END PGP SIGNATURE-----

--pfTAc8Cvt8L6I27a--
