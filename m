From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: imx: defer probe if bus recovery GPIOs are not ready
Date: Tue, 25 Oct 2016 12:16:37 +0200
Message-ID: <20161025101637.GJ1597@katana>
References: <20160927001858.11601-1-stefan@agner.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="MzdA25v054BPvyZa"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160927001858.11601-1-stefan@agner.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Agner <stefan@agner.ch>
Cc: leoyang.li@nxp.com, linux-i2c@vger.kernel.org, u.kleine-koenig@pengutronix.de, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--MzdA25v054BPvyZa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 26, 2016 at 05:18:58PM -0700, Stefan Agner wrote:
> Some SoC might load the GPIO driver after the I2C driver and
> using the I2C bus recovery mechanism via GPIOs. In this case
> it is crucial to defer probing if the GPIO request functions
> do so, otherwise the I2C driver gets loaded without recovery
> mechanisms enabled.
>=20
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Added stable and applied to for-current, thanks! Please consider adding
a "Fixes: <sha-id>" next time. This would be helpful.


--MzdA25v054BPvyZa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYDzEFAAoJEBQN5MwUoCm2E+8P+wV2//fxx/727TD0U90oLJSY
21TvuS3MkWQEJ7L6EUkd2WJ7oTejNVCly3aYunugQOHcBJgah3y/r0Qk3Iticttm
KqnFzjN1mQk6TD6UYbfkmPEqc3kA6trHRfW3WUYyoAnl6DSVh9cjW9xRSK5NU22K
2EPx2IxbUjBPv+THFoPFhiX+FJyU5bTcPQo/8otWlG3DLcfB3wmZ3WASkO/naVny
IzAHzqMvR9Y8S3qSJ5l7Xl1CQeWA4OM7bnvCMy8pXrlF6L+M6sdj9cFUqu1MkMca
gfSSN0SyZVhHvfwEtSPQEGJdGTydr+I3lb2UGXV2wceKfvhtqnvZAmFs9Ntxhd1n
+PmAKAULz8xtejHFhUVL2vQ0mjQG2YeYq5oe/lIKgCzLxg9vhPbhJrJ/2CwPRtlU
Jdv0YU+5EKvnV+p9VOZLJDE7LrJD76Vcs9W3E9k+RUPdpBABAATDJ9f/kYpep8vs
2Sl9ntUiFRp6aGNhHatauiW8w8/0FVQ9gPQe4vGzeaZ9XO91C/wy7y1ybPRGp7D6
7Bj2kA+rRLsH1Q2dhlm5z5mxVVe4RFRVtmDMzeEqgTZVWVoiYSU31hKW3Ub5EhGy
ifO6oZD2WFyznXQEYP8a9Cc3vLx9Kldkoz4gV3Fqs3TS5u8BcnrlO10RHW1IbjS+
0q7GFQ9NKziS5gluCFdT
=dhZ5
-----END PGP SIGNATURE-----

--MzdA25v054BPvyZa--
