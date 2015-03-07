From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: pca954x: improve usage of gpiod API
Date: Sat, 7 Mar 2015 01:18:26 +0100
Message-ID: <20150307001826.GD993@katana>
References: <1424164328-28534-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DrWhICOqskFTAXiy"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1424164328-28534-1-git-send-email-u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--DrWhICOqskFTAXiy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 17, 2015 at 10:12:08AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Since 39b2bbe3d715 (gpio: add flags argument to gpiod_get*() functions)
> which appeared in v3.17-rc1, the gpiod_get* functions take an additional
> parameter that allows to specify direction and initial value for
> outputs.
>=20
> Also there is an *_optional variant that serves well here.  The sematics
> is slightly changed here by using it. Now if a reset gpio is specified
> and getting hold on it fails, pca954x_probe fails, too.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

Applied to for-next, thanks!


--DrWhICOqskFTAXiy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU+kPSAAoJEBQN5MwUoCm2Zx0P/2ncrI4JjD0ZcJ86cbQvaK3i
HoxG3xKcMcaLFzpqbkpRUZQT3onekcBqE6UXHxdHS5wQ3d22Fq8B7oyEL+NLvjqg
VuwXfz1OzU+qLZlatsAuHx6fNQzF1TVYRYXKdG/8llq7q+LgCzSuwPBlq46nRaHT
ralxE11svCrb7Qp3HPrPnjcUVi+jfGqifqQ1dWsPEaMmU6dEzvdcSpr5Aj2ARgxw
Zkxu5zOUl6W49IXdBzU/Ftbeimxnt5IWfUlEvy67tjnJq7JUL5gk9YwFSTWMDZt4
V62L+T5v9z0IDIP9WX5vjiGqvjNoGlwSe5unq1A6Gfx7BexO0V5U9iW4hzyl9WIT
kjFQ7x9n9RUTl3O3BHtt7oIXU9Oh+JlAcSTwNRUBu2oUKGHAGpJWFhlqRxIsUpR6
9sGCdSoPMCzt7ssZLAhaZTn8H3GYCh8Er4g8BhfeN4b1/5x+u35B13fs8p6lTu42
4blLwjxj1CMCYxDN3enFB81slCGRjFzO4MyLzoGPAllbZ3ZS+damMkSzAWwvSTWf
MbrZphWWD/p2L7N2xlgAe4jOuQkro3o3VRFSAKJy50TmyevgooOlSSs9ebd33V09
BVEzrxruEi5a1D0z/SYNeKgTq24UHAv9Lfvkr2xS0086taV5ScTgPmT9y/s0o2Th
vywZQuVezjXOoSSY3sAW
=lsLM
-----END PGP SIGNATURE-----

--DrWhICOqskFTAXiy--
