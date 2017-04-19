From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH i2c-tools-3.1] i2c-tools: add new tool 'i2ctransfer'
Date: Wed, 19 Apr 2017 20:12:57 +0200
Message-ID: <20170419181257.bgzi2o4ygwdpquvs@ninjato>
References: <20170407124403.1880-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="s7v73zfqj4ibczma"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170407124403.1880-1-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Jean Delvare <jdelvare@suse.de>
List-Id: linux-i2c@vger.kernel.org


--s7v73zfqj4ibczma
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 07, 2017 at 02:44:03PM +0200, Wolfram Sang wrote:
> This tool allows to construct and concat multiple I2C messages into one
> single transfer. Its aim is to test I2C master controllers, and so there
> is no SMBus fallback.
>=20
> I've been missing such a tool a number of times now, so I finally got
> around to writing it myself. As with all I2C tools, it can be dangerous,
> but it can also be very useful when developing.
>=20
> It has been tested with various Renesas I2C IP cores as well as Tegra,
> i.MX and AT91.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---

Pushed to i2c-tools-3.1.


--s7v73zfqj4ibczma
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlj3qKUACgkQFA3kzBSg
Kbb9ZA//cNroG+NxB/ldJiEYDEdPLaU9hBjeCvyqyt0vxYiqLDudZi4EtWzF+GHI
WFXMYPwCBmhD7Bsn6HZDGUzsIK3ea3YfWWYpUbGaBjDXhC4LIMrlnAfn9BNiP6yJ
BsIamyUiQO186G2ySPx3gy6FMGws13I4H4kB8uWfrH0GJeQ4TsJrgxJTxGuIfgj1
CM++XG3AyvcJQBLV1HrVyI2SsZs268JhhMDF65bYHq5HT4/Y4kgbtk4x7iggX1nG
+F4+m1lL36H8e+5Suvnrhcxcuh9bDPsPTtRKzQK+6Dq+hcf+AJ58SgBEIG8PpOCK
6R+8hoHdgTC2ZhUcb76NRnty+QTITKlHlchBC2pU2ftwV3qmvTadG+e9+8I+l1sy
p24IcFUVng2rvGrMoD8mSsithfOqtXtVW+LWkQBmJfQI3O/Q15D00N0Wdv7iPnWT
hSGwgUaAYIg2aGmRRWoDs9cReVovu4vnz2mi6Hj7CmVu3MZ27XTGQeRj9q5ETUxd
5cLBqp9vbsYXDKqWd71Ll4HUrz0+y2S2XqAgTcrzX9113mAiXONMNnKu0+cOOnLq
5aGi0AjnzRTzBDJn25pcnZ6aV5cAZhxWR+6a9fdCoi1waVmSoxeyn2T+mdR/xEd0
mrDQ9mf1AC5mxbfLKIjw+luiSaYVUsGsO7g9eszKx9E38pOt5+U=
=ypZ1
-----END PGP SIGNATURE-----

--s7v73zfqj4ibczma--
