From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: efm32: fix a failure path in efm32_i2c_probe()
Date: Tue, 19 Jul 2016 06:23:27 +0200
Message-ID: <20160719042327.GD1640@katana>
References: <1468625798-6767-1-git-send-email-khoroshilov@ispras.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mSxgbZZZvrAyzONB"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:56346 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750769AbcGSEXe (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 19 Jul 2016 00:23:34 -0400
Content-Disposition: inline
In-Reply-To: <1468625798-6767-1-git-send-email-khoroshilov@ispras.ru>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <kernel@pengutronix.de>, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org


--mSxgbZZZvrAyzONB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 16, 2016 at 02:36:38AM +0300, Alexey Khoroshilov wrote:
> There is the only failure path in efm32_i2c_probe(),
> where clk_disable_unprepare() is missed.
>=20
> Found by Linux Driver Verification project (linuxtesting.org).
>=20
> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>

Applied to for-next, thanks!


--mSxgbZZZvrAyzONB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXjas/AAoJEBQN5MwUoCm2fkcP/RTvAzlEmZYc8kac/79q0nca
UfLAdzIK3PmLrqYdpBkKcOdQF2lNkBf/xSD7cYZVsZ1zqzlLvviSpOU1PGTAQb8/
mQZUV1YYL/fTul+YdG2pqsMHOrM+HENFN1iZ0ZpplSqOIXnxiCRkHicTiQ8LVWsT
N9awj7vKej9hxiI3z7Jdgq7HTFL1mCpWIiHSguNo8advm384nkTvRBysXzNB/U60
zv5cdOKx3/TDx3m6JoKq/5rSMP9ope0fd2JLgWbTjGKvz93zOaWM1Wu8RzOcXBKK
T4ra6ThqpJekx0KmPwKZoeI7UgQcgdCLSr4Uv+t7LwLmZiO2qWt+E6eclALNmOhH
H9HIJPuy0qg0KTIs+8LzBxuIm2wP0P/Y7ZzPmyLi6vUcHm+6ZWw9Yv8tXRtoKgpr
0Fv3UqA2jEyDso1Zy9Qc+bZTWfG0yIN5a5MW9ixUTYfKNl4XnPbniKTpZaEff1c6
ToogQ5LNKIkS2VfhKQo0MlzZsQ2IrUzfYieSvIRPcqaHBmc3WwVuuugJhbMnMSrO
EwOKbz2B4BVeqFzcsWExxBtlzhlwpwZzpdguGfE3I/MM0wexuSmRGqBKlLz3ZigN
flBbUhTQfDIgUmcQNYH9yOKt0h8C299hHFpCu1L8vT0QN+YZW6IulG9VIvHjT26Y
4VfrFQsPMyb0YIjfZ0EQ
=kfZo
-----END PGP SIGNATURE-----

--mSxgbZZZvrAyzONB--
