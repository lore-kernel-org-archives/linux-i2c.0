From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 1/1] i2c: at91: fix code checker warnings
Date: Thu, 11 Jun 2015 22:18:38 +0900
Message-ID: <20150611131837.GB1510@katana>
References: <cover.1434013494.git.cyrille.pitchen@atmel.com>
 <7419376c5a4e60f1b23d36e66a102c7c40db1089.1434013494.git.cyrille.pitchen@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="O5XBE6gyVG5Rl6Rj"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <7419376c5a4e60f1b23d36e66a102c7c40db1089.1434013494.git.cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Cc: ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--O5XBE6gyVG5Rl6Rj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2015 at 11:16:32AM +0200, Cyrille Pitchen wrote:
> buf_len is a size_t, so unsigned but was tested with '<=3D 0'.
>=20
> Signed-off-by: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>

Applied to for-next, thanks!


--O5XBE6gyVG5Rl6Rj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVeYqtAAoJEBQN5MwUoCm2mhUP/2Q+xeu5mCnblIPe41QwEwcV
ScWamYx3Hid9AltKRuLpJNm4SesZgbCb71Xpc8JKOBZpKg6Ce+UGl+lcOXNM5eRF
tggmxNBbFAdKixSUI57u/dhsAgSIrWCIMBzJ3LB+lwVvymyf6ureNnTqAo2LQiin
9PH2gvT1I07fDDUfkLWOygr0XXZI+izbhQlBBCoCjjl4uGWiBcSgUxKNgmrQ92WJ
oX9NSQ2QgrCjyzaQmmuYiA7XSuHKAsh1pCzSXU9RRoS1UvmuDhhN0wq4KdL9Ugst
Z81TNoKber12+02Bpz6CZuREKRpJJ2DPbWuXXmgyYlEXgt1Ko0pYx61gPWFvMjwO
rXqvqPa3CfJ2n1OsoKF38qjhOcr4z1djvf16lsRVJuK+HKN+MyeSMLwaXDhVLmjD
sn490wMggnJhtKoYAictyghoBVl94AGEsI6j5xhNpbNGy9jSJUrYmZJ/YvM5VVXw
iGB+weTzNnJ4j5ZIb/6kYZpG5ASC4aHKgZr5Zp8R9EIeA74qUSxyEA1OLSoNUfAq
Cpg6Au5CRo2YX6uJDZlYs9gL0tv0pF8VqSwtu5h0qsohFTUC0YiY2yZM04SncePA
nnpN/P+04YQ9gI4SD8IYF5wSJMXGC4XAfPhe4Mpz31f5pN8QKKxkH8YzzIV9S/nB
Gwmx3pc41pFoJ3lZ+jeI
=v8Kk
-----END PGP SIGNATURE-----

--O5XBE6gyVG5Rl6Rj--
