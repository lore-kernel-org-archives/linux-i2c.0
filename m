From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH V2] i2c: mxs: Use devm_ioremap_resource()
Date: Mon, 10 Mar 2014 08:30:36 +0100
Message-ID: <20140310073036.GC2571@katana>
References: <001101cf2729$890d5b10$9b281130$%han@samsung.com>
 <001a01cf2729$dc23cd70$946b6850$%han@samsung.com>
 <20140309204714.GE2835@katana>
 <006501cf3bf0$12411a40$36c34ec0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KN5l+BnMqAQyZLvT"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <006501cf3bf0$12411a40$36c34ec0$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Marek Vasut' <marex-ynQEQJNshbs@public.gmane.org>, 'Shawn Guo' <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, 'Sascha Hauer' <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--KN5l+BnMqAQyZLvT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2014 at 08:34:10AM +0900, Jingoo Han wrote:
> Use devm_ioremap_resource() in order to make the code simpler,
> and remove redundant return value check of platform_get_resource()
> because the value is checked by devm_ioremap_resource().
>=20
> Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> Acked-by: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Acked-by: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>

Applied to for-next, thanks!


--KN5l+BnMqAQyZLvT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTHWocAAoJEBQN5MwUoCm26qIP/jdfUUuSs0bTHJaQseX2+pZM
qSpjdgZDb+T7oG823CDF+IJRmE5KIi1Z1BdOiOZVbiUwvY/lz5vZE15TeBOqzdyP
stWUXM3CLxdxwvtbZjAk+KRZMryI7LbZS1EFk0A531rAdLgvYjcNSXL6kUkhgsIo
/RCEeZhufQLuf/c5JiHR4zH8vkCpbBNEvrJYkT45X1UzUfgHB27YbAKO8jlwmRYq
kp/QK9rlvt46cT5MXCYCwQPpAQoFmoMpGVDcP8V8/kqoJQ+thvq3q/ibCWXOZlxy
mL1S6q6IfQv/ead1f7Gf9CO2atOPGxyAQ/4YjzvAjzc2SssZOEu4s107BnAU7M+o
qS8m1wMma37eN8bkX3C0Qt5mC/n/mU9XalQxd/RQ9nDBUQxYK+0Nh+i2KRu3evNM
1b4/LYJ+8RnBgyGnATde9bbooXKlIbwHhwTkTql7OGczOPWErafj/IZegFq10Krd
BKDYc721zS7fcwqYihhDXfYx1A2x/S9SoMwYNrtZ9Nt0mvMR2s9/97ifyfSAU8Jx
alNQkJBWJ1ogY4GtzW9jXQ+YVEq3b6cEgoiR/4U12gWfQ2OOfe44f1lgah/XoAlC
+AogvLlUIKlxBOBB3qmnW2XSBZd+y9biN94gF9B8CquNB/qNP0dAggKYGsUAZypU
1EL66hbzeM0ShhH0B31K
=DqS/
-----END PGP SIGNATURE-----

--KN5l+BnMqAQyZLvT--
