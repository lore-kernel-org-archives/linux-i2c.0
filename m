From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v3 3/5] i2c: recovery: change input parameter to
 i2c_adapter for prepare/unprepare_recovery
Date: Thu, 4 Dec 2014 19:29:11 +0100
Message-ID: <20141204182910.GH7944@katana>
References: <1417448047-15236-1-git-send-email-grygorii.strashko@ti.com>
 <1417448047-15236-4-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wayzTnRSUXKNfBqd"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1417448047-15236-4-git-send-email-grygorii.strashko-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Cc: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--wayzTnRSUXKNfBqd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 01, 2014 at 05:34:05PM +0200, Grygorii Strashko wrote:
> This patch changes type of input parameter for .prepare/unprepare_recover=
y()
> callbacks from struct i2c_bus_recovery_info * to struct i2c_adapter *.
> This allows to simplify implementation of these callbacks and avoid
> type conversations from i2c_bus_recovery_info to i2c_adapter.
> The i2c_bus_recovery_info can be simply retrieved from struct i2c_adapter
> which contains pointer on it.
>=20
> CC: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
> CC: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
> CC: Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> CC: Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
> Acked-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Signed-off-by: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>

Ah, bus recovery, I need to have a closer look on this one. Scheduled
for 3.20.


--wayzTnRSUXKNfBqd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUgKf2AAoJEBQN5MwUoCm2tPsP/0ydflzbnHvHC01h4WW8TkCZ
zLfZk+qRBntM2CJ8eh7eqLgvEurzSg4shzksDkYMo8djFmZavTmaYpWM1PQmc1Zq
BsHqAkGlSt/T3A6DRXD25zgWuI0V+g7TY035cqHEgeTbFN485+B+W/I3eItvpjcu
9w1ZXNE8+8qpVFXJO7shAK0IcV/O8o5yqzOck6loHRGl9dKz0CNGTT8iDUFCVqTO
PaZ7cG7MKxt24fxmn5A57pd4e7aKzV9HD/tbgXek096Cz7HA+Q1nUp9YBwzavxHi
NVqBisgD5/r19M/Ub2XZXqzj7qKCBm4W4KI96xoyjtDEnVsIZzoJYWG4hHTu0JxJ
eXhEEytYOWV36tuHSFPTTJbXVN9yUW0GBjOrXkww76dHMj58LmfBnlgEN5m/KNO0
UbW9coT0kkW4S8Kzmne1iYh4oMGBFaQ8u9luNrnSibiveF1eGyONyzchfbrirCvA
KhWgR849vjxs59RdoatHfvXXF/ZqkM1wTq/xHkBTicuuc1/6HAV5WZDcHGfYOfFG
5TkBKk3sU0fpf0Tqmrjh6CNFS/VtsbgdxPgVM16fsjgDjkhzTBU0HaGwTtKphr7X
JcGpm159/WlBd9E5xHgQ2oEU6hGJwr+1BmipSIQ5mjqqvjBSeC7dV6ny721qfoVC
3SmOdkYksFGD8LmP+Uwu
=45gn
-----END PGP SIGNATURE-----

--wayzTnRSUXKNfBqd--
