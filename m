From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 1/4] i2c: imx: Fix reinit_completion() use
Date: Mon, 23 Jul 2018 20:08:49 +0200
Message-ID: <20180723180848.ctfwxrk2www2ede2@ninjato>
References: <20180709094304.8814-1-esben.haabendal@gmail.com>
 <20180709094304.8814-2-esben.haabendal@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7wqed2ci7gvcette"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180709094304.8814-2-esben.haabendal@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Esben Haabendal <esben.haabendal@gmail.com>
Cc: linux-i2c@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Yuan Yao <yao.yuan@freescale.com>, Esben Haabendal <eha@deif.com>, Phil Reid <preid@electromag.com.au>, Lucas Stach <l.stach@pengutronix.de>, Linus Walleij <linus.walleij@linaro.org>, Peter Rosin <peda@axentia.se>, Fabio Estevam <fabio.estevam@nxp.com>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--7wqed2ci7gvcette
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 09, 2018 at 11:43:01AM +0200, Esben Haabendal wrote:
> From: Esben Haabendal <eha@deif.com>
>=20
> Make sure to call reinit_completion() before dma is started to avoid race
> condition where reinit_completion() is called after complete() and before
> wait_for_completion_timeout().
>=20
> Signed-off-by: Esben Haabendal <eha@deif.com>
> Fixes: ce1a78840ff7 ("i2c: imx: add DMA support for freescale i2c driver")
> Reviewed-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Applied to for-current and added stable, thanks!

Uwe, do you have comments for the other patches, too?


--7wqed2ci7gvcette
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAltWGbAACgkQFA3kzBSg
KbaOjBAApJ9ECR3ZplMNccodfIHepXh8Wubqou0RJDT81hu1E+2MCS9ihe8jBSEN
Qg34DOXUWwNrF59XeUbp+zUwIxBgKIM1xZdXk3aYNts5sW79dSOYVccsnHGAQ4Ai
tO85xI1YbJv4Llawx0wyspnNYYvAyFXZjcChlE+qCojbBTX1TFCHZzFEOk4yd92P
QJLOxp0D7CMKd0qHzPPg2BZkEPrfzARjnAtcRU5oae8fP3R3xjizp2uVe8pTSRcZ
IY6dWZNkbsGzJ+pFu1ng5kEtiZb66oHnNZlUQj2vvjAGZ/Cr9/Yjn0m2+E7NRglJ
eJSwENEdr96e4A08h7fKZM4cRQ0vOv2Mh9AkODgDTDUCcn6ipzI+zFeXXM2PXaOp
PVIp0cLq54LKvA+Tp/lvPZI89DbPM7BVYc1rwFWR9AOUAXpcfJcjd6RoqSjPxipY
sCV8AaXfZK0varFF7RVibJ5U8vc1+FAW37WSOPYpFkXCyw/3AbnKYw4KgZEYDgzg
mD0A6uAHWRpu/MF2QopiqRZPjpDAkbVUf0AUelhVAn9AE5jVhgIR+nCt9nKRLZpY
YPlwwMdM4WTFbh4+Z43T5WI9yw3do94nPx7OZK10KzBY2vlPfbaIK+hsBURcXL/+
wBsk7CdjzPqDNH0DqeN/h7mm+6erF9TMBGDZCnBcWKswoQwuANI=
=ANsa
-----END PGP SIGNATURE-----

--7wqed2ci7gvcette--
