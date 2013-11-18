From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH -next] i2c: bcm-kona: fix error return code in
 bcm_kona_i2c_probe()
Date: Mon, 18 Nov 2013 20:26:44 +0100
Message-ID: <20131118192644.GA13266@katana>
References: <CAPgLHd8vdQL5Uyypjj_L9qg=abQEXoGc6ZBKwrF-5D9x2YNm-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAPgLHd8vdQL5Uyypjj_L9qg=abQEXoGc6ZBKwrF-5D9x2YNm-Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wei Yongjun <weiyj.lk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, tim.kryger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, matt.porter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, markus.mayer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 18, 2013 at 09:03:08PM +0800, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org>
>=20
> Fix to return a negative error code from the bus speed parse
> error handling case instead of 0.
>=20
> Signed-off-by: Wei Yongjun <yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org>

Applied to for-next, thanks!


--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJSimn0AAoJEBQN5MwUoCm2+8YP/0wyjAN/cDdFlbOcXrWz6mgn
wYtihyFNI21+AO2PGGMnEf+GpJncjfAlVrRCPUrP1jr0LTvcy9cVGeKb6BqZOE9M
d4hRVAqrGTAln9cbBMFp9BV57ZxYmrOAFMumPk0nco/icdDsXxFynSKTcefqIUPg
5XlIdPcmoNOVuQXtOw/YOdo+vYB1/siHk7oukfd88vL64M7kNRO4L6EEmiroWMr7
EUyOqaJsbNaZYGn0amusurIUf0/+9leqIqwfxbcgHNX/XqN6jCEKLwJpdCI8ZSmQ
oEsrNQUKdcXlpEBfU18wa+kxlbFnM6tIU95iPgoAReU6dufnaKr9+IeN1GunFdDQ
Z/7yIJRwrattS/9vXDG4yHVY6i7/FGeI/nfVhTuvdLeAucHSOOVagruW32ipmhQ5
z/dI6EZY4X9TNjp8VfzMgcEa6EC6RMR6pAJdKNKlsJHcHuDAtDFqtecp1Cmk+gA7
yxLQ9WrlUeDWqv1hKhqyWztm2Vw/4s3quwEUYm85ziv2avxsWXp421J04OrMTNiK
Wmsr4lq+g5TlXZy2qmw/RkaUOTW+xeYzvSXuefqGNkh4qPk8sokHMKBtu6nLY+8t
SZZBkVZrENfjqhN6UNP3LupCHWqxGD5W4HXY+uf4fV+6LKYNHMtdwj0ZRgfVQb7p
xfztIbyYKfMLIVh1EDqW
=qDkD
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--
