From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: acorn: add MODULE_LICENSE tag
Date: Mon, 15 Jan 2018 18:10:28 +0100
Message-ID: <20180115171027.ynorej3x7nal7ttj@ninjato>
References: <20180111103751.1506236-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="u2ejlrlilorcyerl"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:40583 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965441AbeAORK3 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 15 Jan 2018 12:10:29 -0500
Content-Disposition: inline
In-Reply-To: <20180111103751.1506236-1-arnd@arndb.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Russell King <rmk@arm.linux.org.uk>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org


--u2ejlrlilorcyerl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2018 at 11:37:45AM +0100, Arnd Bergmann wrote:
> As of v4.15, Kbuild warns about missing MODULE_LICENSE tags:
>=20
> WARNING: modpost: missing MODULE_LICENSE() in drivers/i2c/busses/i2c-acor=
n.o
>=20
> This adds a license, author and description tag, matching the
> comment at the start of the acorn i2c driver.
>=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Looks good, but since rmk is still around, let's add him to CC...

> ---
>  drivers/i2c/busses/i2c-acorn.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/i2c/busses/i2c-acorn.c b/drivers/i2c/busses/i2c-acor=
n.c
> index 9d7be5af2bf2..6463189ca183 100644
> --- a/drivers/i2c/busses/i2c-acorn.c
> +++ b/drivers/i2c/busses/i2c-acorn.c
> @@ -94,3 +94,7 @@ static int __init i2c_ioc_init(void)
>  }
> =20
>  module_init(i2c_ioc_init);
> +
> +MODULE_AUTHOR("Russell King <rmk@arm.linux.org.uk>");
> +MODULE_DESCRIPTION("ARM IOC/IOMD i2c driver");
> +MODULE_LICENSE("GPL v2");
> --=20
> 2.9.0
>=20

--u2ejlrlilorcyerl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlpc4IMACgkQFA3kzBSg
KbZEzw/+POHGbdQIAeZ4YrB/q/YFsyhLWnABFTw0ac3MR6r7SjL+s1JQ1Omy3xPV
f83epBlwigtcUONzUJsCJyRlRyywO2Cv3crNo/5ibszMtd3jcVyKtUtKSvDL8vvF
PSbaLdVUJdm+pfxNDQaaFVsSqA7heSXmDX8Iw3N927FtmhwIRc59Qo1aGkIqvx+A
yLte+dIIT0KjQ9sR3va5ek5Fl14Wl/0WMhM2ageirPgyvASioVDcZcgUNFZYRJco
go92eDzqQpx+GfOgux6S7G1FJa0HoYoSsqIbQ2x2QMPVHmq0t2ctJSszLWlBHYMt
SyYgbU2XI9DjKH9h6SzqOQJhLxIZcaw1D8WEswMp0HfDoaXR5x48E3+EWTQHtXSD
KjWjhZyWSSc718Y699/yk7hmYwbf/D//E3oxMLQZHhS9ty2cAb9Qhr61uv6jOvNC
BZfD7ONMh4SqAYnOpuTog+Yd9Cir9dr4uJ4G5AFgfwL9y4e8DbOY0LeCbwtnM9pJ
byk40AqZKqQC9T0qzH+n2e5RksTF23FP6P3Fp5izClTMn5wcxdZr+24n320RoLne
xjzIpMUN9XHoFXm2cxAmxAFSHro50lcQ/xO0fC8r2MDUFMiJ4yBX82Xgge/4QLNl
VP5z9d7FVnOwdGqFrMKDv86jEAlIce5HYvn1oyC9E+L6e+DSZPQ=
=1GQl
-----END PGP SIGNATURE-----

--u2ejlrlilorcyerl--
