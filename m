From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH -next] tree-wide: add missing clk_disable_unprepare() on
 error in wmt_i2c_reset_hardware()
Date: Thu, 14 Nov 2013 18:40:58 +0100
Message-ID: <20131114174058.GH11022@katana>
References: <CAPgLHd-j19gkcuBEVUm5EkUkqXbqZBZ9i74p1WXth89rEaDpJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2oox5VnwalALFvA7"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAPgLHd-j19gkcuBEVUm5EkUkqXbqZBZ9i74p1WXth89rEaDpJw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wei Yongjun <weiyj.lk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-ci5G2KO2hbZ+pU9mqzGVBQ@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--2oox5VnwalALFvA7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2013 at 10:23:50PM +0800, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org>
>=20
> Add the missing clk_disable_unprepare() before return
> from wmt_i2c_reset_hardware() in the error handling case.
>=20
> Signed-off-by: Wei Yongjun <yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org>

Applied to for-next, thanks! Yet, the subject line is really
non-standard (i.e. broken). Should be "i2c: wmt: ..."


--2oox5VnwalALFvA7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJShQsqAAoJEBQN5MwUoCm2lYAQAJvIOF/ngRmuHhfOTKkRnKia
67V0tQe/fjnh5vC3va9dp1qyCjQC3NGLFtiKl+D4to/T0wS8nckM28PfspYBWxgL
skym52ht757oret7ncN89WUVXTb0li4WmBCnmHHSORgQR7hCHAz7PZQDQr7vhQhh
m6MrwctN6RjV0fHQJDvaKl+cE7yM1XZY+iRX3qJnoRX6by5d7eJaavYJD/ocN5O2
fS6yVI3H5KQAe7t5WaRTeVEdrBSd/+DKb29knU7Y07HCBVN9TzJxcwVW0KSz4th0
2IlhhMfFgxZedFZPlpz/gLmmVkhVnUAYl1dp12JPCzJtBKYGcDuNcUhjFKYsv9zR
yxe4VHVDPFCnYzzhiQm17p5duQjhXxfqriH6h4VPKgZSfXpqVpK9Tre7ugjRM3Fh
h+ja4OMXKEIOY8uPyXNepwRwg9J/3MopbxtnrUi0GrVXa2ZGfx9SyMzfrPWV649E
d3of69RggPG2W9iYNUJ57OcnQn1b8XCsQL2S8FKfxk7xRs3PG8W4yc/cYANyYgM+
XPTUHOPcGhXhBYXIOm2xoiWKgQBACOCn5OnN+c2+IsC456rHvYcuH1IvwoF0jlTj
HGOxtHeP7ikyn2NBKjFd87Pbh97dGtvdnOjoO0RFmOjm+ugMSHRUFz1yCS8qiGz/
rXNzIOc8ng/KpBM+WjKd
=IyzH
-----END PGP SIGNATURE-----

--2oox5VnwalALFvA7--
