From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 02/13] i2c: gpio: Use devm_gpio_request()
Date: Wed, 21 May 2014 12:59:19 +0200
Message-ID: <20140521105919.GR2708@katana>
References: <001601cefaf3$940d0040$bc2700c0$%han@samsung.com>
 <001e01cefaf3$f8b520e0$ea1f62a0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="soWJpSPh+l8Y6Fy7"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <001e01cefaf3$f8b520e0$ea1f62a0$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Haavard Skinnemoen' <hskinnemoen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, 'Bo Shen' <voice.shen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--soWJpSPh+l8Y6Fy7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2013 at 03:48:19PM +0900, Jingoo Han wrote:
> Use devm_gpio_request() to make cleanup paths simpler.
>=20
> Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

Applied to for-next, thanks!


--soWJpSPh+l8Y6Fy7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTfIcHAAoJEBQN5MwUoCm2yK4P/2Y+2bYjs2WZeEUv6IYDMWBR
3heWCDB0lxlb3b6mX7AKN4LmQR1iJf3sXhBqFrh0m0KKTxhtpKQbv4QQ0KO+8ehO
LmaaTaHsjPp7UHHFutWg7bQZYFosqbg/QLRsZ72VgGBX6J/W17FSWy9t54BRKmW+
Ck6qWx+eqnIlmWySScQ4BoVDjbQr1uOdtcom8fMtqSIeIzwZ35g/XJ3C9BgjEcw0
o8ff2CgEo6OlbUzuGnMg5BnpBKWwNlG1XcPHKfU5UB956g7Ava24WWYW83QKWmPS
HbsHN6/G8k3cuQJBLqVoXujUr8XL5x6O01ouKkd7a7vYpR7myPttRj8J+oGHvqWN
0ZFm4Piyz9b2ZVLWB8xEy9F81woRvBpCLPhGuqMFyj7LKPOKk5ieFWQhHqZjV4rp
wINM0mdGHUVIAzo0KZ9GkivijqXGQdZFMU8F84gEAs3VKfngMUgMNA0P3kdMLrb1
Qik0oA7HNhaWaV+Qjz6PKgWlvwK4M/dL+/2kqAbHRurL6DLg7SJ8kxhLh+CGnouJ
7Ouq3KmiBNOdloNQrgtw+abIU9jZ+nkNHoFfjjHc3cV05CvMtesrVmyWSfvzp7b6
mvdmOk/ms1GAzd82s+vD6hZsXRofvxZiJ/4zAx8BNKxJGxLJn2puqKoLG7eS/l0K
UHIgzfhYlPXBRetKUjW2
=//VF
-----END PGP SIGNATURE-----

--soWJpSPh+l8Y6Fy7--
