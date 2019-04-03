From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2] i2c: imx: don't leak the i2c adapter on error
Date: Wed, 3 Apr 2019 22:47:56 +0200
Message-ID: <20190403204756.mbc7zc5klfd5zydg@ninjato>
References: <20190401101437.9626-1-laurentiu.tudor@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="e5bv5jrwovk4okep"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190401101437.9626-1-laurentiu.tudor@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: laurentiu.tudor@nxp.com
Cc: u.kleine-koenig@pengutronix.de, mojha@codeaurora.org, linux-i2c@vger.kernel.org, wsa+renesas@sang-engineering.com, linux-imx@nxp.com, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, leoyang.li@nxp.com
List-Id: linux-i2c@vger.kernel.org


--e5bv5jrwovk4okep
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 01, 2019 at 01:14:37PM +0300, laurentiu.tudor@nxp.com wrote:
> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>=20
> Make sure to free the i2c adapter on the error exit path.
>=20
> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
> Reviewed-by: Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>
> Fixes: e1ab9a468e3b ("i2c: imx: improve the error handling in i2c_imx_dma=
_request()")

Applied to for-current, thanks!


--e5bv5jrwovk4okep
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlylG/sACgkQFA3kzBSg
KbY7NA/+OYTlxmIrzeQ96oMeThGobNltt9M5/8SMQzFO/sx9hUKRDFH2whp2ZVHB
UOFKvbfGUQUd1M24eRxqsrvqAQDxjfrOHRzZgxiCzCbGYdcgHeIr+IJjb9O7xxAm
ImAFZaTfsVxr0r6pwRLxmo/e7ID9rvq4uRDyu5k3u/CW0RZ1iT09/NbuiUFWV2Lr
yJYHNpHKz+kr1dAkxMGTOMUpdxSmQpHaNa89mPnPzgP6O8vdanJod+7kun6NGDTU
hAFO0HosTwbnVR2WySVLPITryXSpwg69oaaGyKkntjBwxbsulvP3olkk/+2d4+8N
GDkjOmEtfoTXMYdOEmzX5Il5ATjs1BSwoEKDjSBM2+VwzKWgioOQlwfh2xdKHZpp
oQp5Ug9Xt4bPsXJkZA13/BCBkR79JzdTJZZwAB+GoYIYAiPBtmg4vNcEIwjTqCSS
RhowyLiadlKtBBFl4/x6Bre4XS4m77mzl+U9RV5mqqFIqYnWjgRCzKxg6c5IsHTZ
9VU1w9Q2FGFqktNqMyRKJkj82RRI+xhaOI5J62GlNsnKJZ03lrzma9fUSkrZHV0d
FTOjWjIktcP+oBW0v1jRBahuDhTOfdEq2pqIIbHTi7Sa0eN8q1/8yuNRc9+yLEXq
GgH6i7jlC/V7rbi+vOxp7G/vIeo0b+AfUJAtC9r4jq3rZjW9Pj8=
=Oe0l
-----END PGP SIGNATURE-----

--e5bv5jrwovk4okep--
