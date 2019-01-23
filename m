From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: imx: fix inconsistent IS_ERR and PTR_ERR
Date: Wed, 23 Jan 2019 09:28:49 +0100
Message-ID: <20190123082849.GA1129@kunai>
References: <20190123003741.GA12068@embeddedor>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VbJkn9YxBvnuCH5J"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190123003741.GA12068@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, NXP Linux Team <linux-imx@nxp.com>, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 22, 2019 at 06:37:41PM -0600, Gustavo A. R. Silva wrote:
> Fix inconsistent IS_ERR and PTR_ERR in i2c_imx_dma_request.
>=20
> The proper pointer to be passed as argument is dma->chan_tx.
>=20
> This bug was detected with the help of Coccinelle.
>=20
> Fixes: 5b3a23a3cc94 ("i2c: imx: notify about real errors on dma i2c_imx_d=
ma_request")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

I pushed a similar fix to linux-next yesterday.


--VbJkn9YxBvnuCH5J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxIJcEACgkQFA3kzBSg
KbbPdA/+LdO8wwH7iCh/9IZ4wC1rMppcRk1eXJf3wcUgYi0wCrAF/yiFO4GAvHXN
1OH0daG1Q22hapc6B7aRfWtkpi6zf1b1w6/L/EFYi/2ykgV2TVqIKNiEhyvHLgBR
sVOTYtYVZe4j3afB49nMcf7S3oSBPob7K+l59vmCXS1uNNhPbV4wlI3r7J6Rkw1Z
37DKkPH3JvRLA07FjqlyM7D8NkRcQxchwQDmshVRaJ4RoMZ5QsonzZXTk1LWSDn/
nZul0iV0G2PvgvU+GBTWdwLLBnq4b2W2S8ITtr52msthPuAt0AkotbCOc0EF2dLV
zR/wbjpo6EwN9ImcyboL5/ybWW3swHmCxXLsqLw05lvSfYlIRg1kkrYOwMRvD/59
KS9YbJeD5z8BDfVYXwGFCoDIIs44RrK9npBFmyn/aV2nI1TBXRtQbYxdyuHsEdKL
GwBtjVityTWZYMIeT9RLQ8+4p6UvSx1Tsi9SgBojgpD2NER4Jcr5jFTJ4bBjgor5
IV01oH4uaRhMk3sxeVtreNuZEHFxK2o/XU0YyUb78ov3sNA2L7APDYFkOjysVV8P
ITFv6eniEogVQ+nuWJtcc5LFOOqloxSQXsQiZNodIYSHtOXmZHoCTWi3wEIEoBek
DnZyF2MF4VSbxwAGCvQe40GFgNKBLcH8vj6x6gVYbR+g6RT3wp0=
=hJl/
-----END PGP SIGNATURE-----

--VbJkn9YxBvnuCH5J--
