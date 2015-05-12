From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: scx200_acb: avoid I2C bus overclocking.
Date: Tue, 12 May 2015 22:19:20 +0200
Message-ID: <20150512201919.GL4449@schokonusskuchen.bad>
References: <553955C6.3030000@secomea.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9JSHP372f+2dzJ8X"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <553955C6.3030000-sijd2F9aCfdBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Svenning =?utf-8?B?U8O4cmVuc2Vu?= <sss-sijd2F9aCfdBDgjK7y7TUQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--9JSHP372f+2dzJ8X
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 23, 2015 at 10:27:50PM +0200, Svenning S=C3=B8rensen wrote:
> According to I2C spec, max SCL rate is 100 kHz, but SCx200/CS5536
> controller is currently driving it at 214 kHz according to my math.
>=20
> SCL is derived from an input clock of 48 MHz, which must be divided
> by 480 (240 cycles for each SCL high/low state) to be within spec.
>=20
> Signed-off-by: Svenning Soerensen <sss-sijd2F9aCfdBDgjK7y7TUQ@public.gmane.org>

So, did you test/measure the actual frequency? Or is this patch based on
specs only? Thanks for caring about this old driver, though!


--9JSHP372f+2dzJ8X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJVUmBHAAoJEBQN5MwUoCm2svMP/R3PItIXu1VvGWmgx+4qnrZ8
euYxQ3LgNDwBZX/Z6m4LSxEuBbhw854/VJlHKhIShU+RcJ2TEXwzPhbYk3Si/V+l
4d0tyGgvjI2kft0KqRQKwEhmNvydu9FHKzT26c0pNU6CxORcGG4Fhr8HuwrrsiCp
tMBOhvOXT6REZDKHwCjJGUUM16ugEHa7BpSM7v0YQ5nuAUbsSTRyzXoPSyOo8y4I
nXrsJJdDBG9VQcVTKYVoQVuMT+dXycQicracLiNc4XNe3P3dRzdxYPvkYLwo4FS5
epLM5QyD31hgpAgEojrgK6LZTWDA1p5bwj9I1bYRNq9XitVhB1pdCGpFi+6XH4tN
zgU4OHGsUKNk8J5kYTO1yH5PJM7ZrSolx7Glu8VpKC0qNlReuMY9IzYx1eUpfZuR
NAOK82hIKXxN2gTnSoEi/IYkQGmiDqjtVIe/5SMRyPe+bweerTf6wV21HRJHWSEL
HWWMEdgxBkFFt9+sUc1LjdBlmRae0uVMT/f/RzJpqvzQsIauiNBkd4dzBMfZ/JCT
CqfsW+srtuB7fU5iAmMxDWhxAGyDP4rRnMQulskWOL0982nMQYNKt9AflarD3WGG
D9qs6Nto/hqpGOwQOYmPEg4DwcTg63SKM7nkbt9TOwMwDKSZ02m35icIW0sCx4cu
eIFFpfemZndPMiIO6UiH
=q3YY
-----END PGP SIGNATURE-----

--9JSHP372f+2dzJ8X--
