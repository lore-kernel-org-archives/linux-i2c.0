From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: imx: Include the right GPIO header
Date: Tue, 12 Dec 2017 23:33:26 +0100
Message-ID: <20171212223326.i3qnws7qmz7it5fp@ninjato>
References: <20171208133535.17562-1-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="negkx7ewbp7hb67r"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:46066 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752728AbdLLWd2 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 12 Dec 2017 17:33:28 -0500
Content-Disposition: inline
In-Reply-To: <20171208133535.17562-1-linus.walleij@linaro.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>


--negkx7ewbp7hb67r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 08, 2017 at 02:35:35PM +0100, Linus Walleij wrote:
> <linux/of_gpio.h> is not used in this file, by
> <linux/gpio/consumer.h> is.
>=20
> Someone is just lucky with their implicit includes.
>=20
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Applied to for-next, thanks!


--negkx7ewbp7hb67r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlowWTYACgkQFA3kzBSg
KbYutQ/+PZddQwcSxdgleAPbjUxoXnoqbqIW/NrTkn4c/uga3p6po8g9Kzs89lMs
WruFmq0dSa8b9RRiSCD3OvlRrtXLvmsxxBA6cxrQ3RH4YG4LGC1s/HJ3FzhFFY2W
rRc2rwi2SXsgKqh1O0p9vKAmEuQxOgzsLEgqVatUdPYQ5/gd1TYKDcmXiHgefVbk
ch5AOP9Rp9qXk55M0Z4o54ZQgaaHH/Du6DPWqKcr/Ny6dGLOUa676RY0XM9ZlMpK
YH28aYL9JCqdzj3rIgc4QN+BeCxFMjTQLtt8wnC6qdYr2B3m9c4Rp1YiORgn+NgB
B0QMuZIWnudkIqq2wO6EhVt3Y8MaIh+f2NRrFEIpwQHLQsEgfI+Q5ZpNKRkJqln9
eZdM2dvWTrWVGHlhmuH54cp7QPjfuUaKUeMlxBwLH1FJc/FbVPEwzWjtvq1lxzxJ
S3gjpn2ve/pxzDrPjLn5cZ01w9y6RiAUqyijA94HIv6Gbqz01MVUek27BsHplWO6
ELufCNXhb8YXT7j5SjcG/mluAR3vVkW+UHxMbONya/Sq2rLvj35L1sCnrR+oHLAt
GCwtrb/XSR6DmUVYwt8T6M14GrTBN9UUuxWEX+GrQTFWLmDrbpK0/MlnRNPGj8ej
0iZzh67FVjSLBJCIbGaPGHYWkwfCxKw/n/+s4bzojahroOUpAjg=
=4vl/
-----END PGP SIGNATURE-----

--negkx7ewbp7hb67r--
