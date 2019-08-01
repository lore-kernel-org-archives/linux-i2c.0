From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 2/2] i2c: imx-lpi2c: use devm_platform_ioremap_resource()
 to simplify code
Date: Thu, 1 Aug 2019 14:50:29 +0200
Message-ID: <20190801125028.GI1659@ninjato>
References: <20190717084017.30987-1-Anson.Huang@nxp.com>
 <20190717084017.30987-2-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mXDO3udm/xYWQeMQ"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190717084017.30987-2-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anson.Huang@nxp.com
Cc: aisheng.dong@nxp.com, shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, wsa+renesas@sang-engineering.com, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Linux-imx@nxp.com
List-Id: linux-i2c@vger.kernel.org


--mXDO3udm/xYWQeMQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2019 at 04:40:17PM +0800, Anson.Huang@nxp.com wrote:
> From: Anson Huang <Anson.Huang@nxp.com>
>=20
> Use the new helper devm_platform_ioremap_resource() which wraps the
> platform_get_resource() and devm_ioremap_resource() together, to
> simplify the code.
>=20
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied to for-next, thanks!


--mXDO3udm/xYWQeMQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl1C4BQACgkQFA3kzBSg
Kbar1hAAquWHe0O3sEuqpFSEu1yKoyDSLzPeFYmaYzdz+Snz7NxsssYKw9wudKh4
9+j0FsIKOQFzlDfXviOwYBsl94ixNziBtVPPFoWEtCSXKlAMCRfIVXT8SsIrY3SE
/lIZY7jBKi9oRvBxWMImxP0iLS2HC6uIg/3fs5sAy4Hy1VKcn2mvMy7WZES8gFTR
/Bc2v4Y2Y4cdTjzjy8MpRUthrYbYU06XHXp5RF3/UkEg2I7NU6bYDt+5OUTpv36c
B/9vR/zk2kg9lhzrWRZqu3n91VY9KJB5ykfGBRHez+qJ3uFqnMGJn1zW9C73S6q/
KKpkXcSJ14otSb3iq7KGlCjuQ7l18mEjFlYmemRtUTivOSmVIuCg57aGvhgduNfu
kENj8whpMZo7M01121HGCtjo8r8aFKEQBoQ2mRqnakxyvzjmTu4Ljr0E4yZab52p
RNOHUjbtZL/R0Dp/aWugfsiwqZiD0c4/rsubRSnJN5gHlk9ze1vD+zauF+DeIFqb
oMRGa8mFtmPdaeNb9nSmbEBNzngBbiatr+DCMYogeRM6+AOjycAn86TOdxOvEPiB
Xy7XllFoUuQvTXXeI79M7fZE2zH/NCcvqAtPYu2/Adt0bz+AW5InsRhG7pgdusAN
u6rb/QzX13xSs5s/NsYDDGUll1KGrOoIcTDpmSghgsTpIwLzW7I=
=S2Wq
-----END PGP SIGNATURE-----

--mXDO3udm/xYWQeMQ--
