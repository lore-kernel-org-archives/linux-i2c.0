From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 3/3] i2c: mux: mlxcpld: simplify code to reach the
 adapter
Date: Fri, 5 Oct 2018 13:43:47 +0200
Message-ID: <20181005114347.GD5433@kunai>
References: <20181003155024.16024-1-lucaceresoli77@gmail.com>
 <20181003155024.16024-3-lucaceresoli77@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="M38YqGLZlgb6RLPS"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181003155024.16024-3-lucaceresoli77@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Luca Ceresoli <lucaceresoli77@gmail.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Luca Ceresoli <luca@lucaceresoli.net>, Peter Rosin <peda@axentia.se>, Vadim Pasternak <vadimp@mellanox.com>, Michael Shych <michaelsh@mellanox.com>, Michael Hennerich <michael.hennerich@analog.com>
List-Id: linux-i2c@vger.kernel.org


--M38YqGLZlgb6RLPS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 03, 2018 at 05:50:24PM +0200, Luca Ceresoli wrote:
> From: Luca Ceresoli <luca@lucaceresoli.net>
>=20
> struct i2c_client has a direct pointer to the adapter, no need to dig
> it out of the struct device tree.
>=20
> Suggested-by: Peter Rosin <peda@axentia.se>
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>

Acked-by: Wolfram Sang <wsa@the-dreams.de>


--M38YqGLZlgb6RLPS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlu3TnMACgkQFA3kzBSg
Kba+vw/8CTJlV9gd7nykfq/kB8eIED292pPk4oEmwa5WNy7URJngtKoxTYRcxUYC
omHDLeNscTF2LZ+Dpoqm1W7aI9dG12JSl5YEPxBJNXTKUWfvYFt0daaVU9L2SyZ+
JULXcuZCBLOTmvzvArJOvJO09tc4MJwExVlN5+FAyn+UpbhAOHxdW6rNbmkxUg4Q
aZznZ1KYC61liY6VJF05EODu5Hz9gRmZ26b8EMcc7v7bIdifT1pY/R1QMy5kqGJy
qS8SRlO1tbuaVc3HIL/I7XIOo6kI3OSqrZuRzBn9rCdo58K8adsB/1pj9BFbTam5
NMm1+IC7ib0oJWSWDr6owmJPk9vgLz5JsxVM/n0KRJ7WI+scP5MGDw9U53ksvWE3
9sihWdzJI2IOkafu05nfzBchTLzWeNcGk4j1DyWUZQTD1MWq7KYPQZDAOUaEBeYW
3B0mA67g+1iCErdZpTgMxCV9QPp2T2X1Ssd6sL3n0UHUfvZ26czKN6byFh64LsNC
mjhEjzWUHh3dLX8n8iwFhLZhBo6u9o/uavREaqqJLZYGnYfBrkPCp3NSDJHO/PPt
v93IdzJEyIn1Bm2jD2YSntmUrqUE27OVhHouErKIrfpQddHsFF3A8Wo6WeAv9o25
nRlGT9qRmBzyaYDTCNWxvnCoJuG5GRrMZ8/biy/lsWj6BpbV3lY=
=XVRz
-----END PGP SIGNATURE-----

--M38YqGLZlgb6RLPS--
