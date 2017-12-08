From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: core: Use GPIO descriptors for recovery
Date: Fri, 8 Dec 2017 11:50:12 +0100
Message-ID: <20171208105010.xn6m4bl3hiaxhizq@ninjato>
References: <20171208102002.26456-1-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="z5rtavy7qdyoezzo"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:59372 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753397AbdLHKug (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 8 Dec 2017 05:50:36 -0500
Content-Disposition: inline
In-Reply-To: <20171208102002.26456-1-linus.walleij@linaro.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Keerthy <j-keerthy@ti.com>


--z5rtavy7qdyoezzo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 08, 2017 at 11:20:02AM +0100, Linus Walleij wrote:
> The I2C core contains code for handling a fallback recovery
> using GPIO when a piece of I2C hardware fails in duty.
>=20
> This code passes GPIO numbers from the global GPIO
> numberspace around and we want to get rid of this and use
> GPIO descriptors associated with the devices.
>=20
> After some digging it turns out that there are two users
> of the mechanism in the entire kernel:
>=20
> - i.MX that simply define "scl-gpios" and "sda-gpios" in
>   the device tree which is already creating descriptors
>   associated with the device, that we can pick up and use.
>=20
> - Two DaVinci boards that pass the SCL and SDA GPIOs using
>   custom platform data.
>=20
> Refactor the core to grab the SCL and SDA GPIO descriptors
> on-demand when doing recovery, and release them when
> recovery is done. Grab the named descriptors "scl" and
> "sda" which will make the i.MX method work out of the
> box.
>=20
> Augment the two DaVinci board files to pass descriptors
> using static tables.
>=20
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Sekhar Nori <nsekhar@ti.com>
> Cc: Kevin Hilman <khilman@kernel.org>
> Cc: Keerthy <j-keerthy@ti.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

We have this in i2c/for-next:

3991c5c80beaf7 ("i2c: Switch to using gpiod interface for gpio bus recovery=
")

Sorry, I just noticed you were not on CC. I wrongly remembered you took
part in that discussion, too.


--z5rtavy7qdyoezzo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAloqbl4ACgkQFA3kzBSg
Kbaf9g/7B0ox87xVaCjVSvhaEa3LYQffIZtxXFB+1TLhaFy8BRcYB8lQ+QylEMJt
OnyDYU1OF9UL4QoZ5fUR3xff8JJ+7Vj7ixgjlyeMm2GlFAVl52/1JPYZp0xX9uzL
LsghskkbIJCtE6HuYPuw2i9zr1Y9zG5kVHeuD4r1bytPfRgJ67za3o58RniNR2dT
m1dlwq/Pz7mWGgS/EyJz0ekGdEmxbQOvg0g5GuJ4gG86s1w7pzW6GhrGton3695X
CuTseXfGoUvbzPbK4GiZsPOiD7vqyJvQSSboHqx5e3IA2cCm6lW62RxUSTOwgwxf
Ikqb5a/2Ou04K1hhFzl+auEl5RhdWjZuoaRhqSydogPUj5C6KmMkCpLnJompJFt3
qpyfC3DXzNXiMmqnJuhh2ZDv033dBq21NCr7F2k8T2lQHVB+AQTw0G+UvUD0oF4X
jcoBsqQ1zCNWnM+uzRh+4l5WpsGt3XO3TzY1+W2uJteZe2QwEOcy613k957My++2
DxXgnUvFnmTLZUBNyhFsBDxHl8MAKJVz4t6t9Su9H5ghHDfUFKa74aImX91frHLe
Bd9QXAKgnIwAnXxtyI/bAYH3wVC17mV+0y0pn5wvTb8JVbOfsyBOZYYFwr/bcspw
EL/1gbvS/IXNyOan/Xvatd5XxTgSse2R+nhvxsdMTAdFvt+uPWE=
=YCkV
-----END PGP SIGNATURE-----

--z5rtavy7qdyoezzo--
