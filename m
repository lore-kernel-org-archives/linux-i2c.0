From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 2/2] i2c: pmcmsp: fix error return from master_xfer
Date: Tue, 15 May 2018 09:28:13 +0200
Message-ID: <20180515072813.wrihve2xjjteg4rj@ninjato>
References: <20180509194630.29047-1-peda@axentia.se>
 <20180509194630.29047-2-peda@axentia.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kru5cayobwcmhhvm"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180509194630.29047-2-peda@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Gustavo A. R. Silva" <garsilva@embeddedor.com>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--kru5cayobwcmhhvm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 09, 2018 at 09:46:30PM +0200, Peter Rosin wrote:
> Returning -1 (-EPERM) is not appropriate here, go with -EIO.
>=20
> Signed-off-by: Peter Rosin <peda@axentia.se>

Applied to for-current, thanks!


--kru5cayobwcmhhvm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlr6jA0ACgkQFA3kzBSg
Kba0GQ/7BoQtr5W5VHHxWx7OOgT1b1RvMw4ato89dtth3yAzcZ81rbW2OKWtRdx6
ANCyuiNIxmBMMYx+LIaWLXaWgCt1ET07DVTSEsWIRNrqBRPulc4MC2KpWUYO5VQm
/egIs4nGXHPWwbgVD7Ndmxe7wAyDeBh5Y6SlZMslZeS0/gHSw3KP/os6P03RqIV/
ImHs3pY84XqW/K+yJdAnPPnHAd1TbZqmgT6srCJsROharkCGhvKLAakGjWH7MSq+
zBJFAqQsadoAYHrRyzhhwIK2buNqJDE9xa0WzgKrJ7Tt716gJIh6JV7OcB3/aMol
7TtjfIHnqcy+BSrJ3pUsmQY2jztYJXRWs/ST3kUI9niViaD9O1OkVj/jWDVz3SeX
6QWmdBUQPJ5OiSJpinZzeUQXqKNr1q7jWphIF3K4rCm5tMqIMiEH2KKxU4rZ7w0/
/h/sW6FBWLrSNm4/GhNX8q3UqfQ60a7CxDjNNrqsnlWSurL44JpboWHc+aZjMcRQ
eZfm0X2QXcYyCsbIMucX+em7dJrAE2Gd1l9jfCkvKWvzvccekhW6TQQAHYB0AsBs
9uG45BhF9jOzTW+RvjEh9qoO+ud0epdTJJhWhFR6jB/gUfeqxaA8f2QnKpcpoWGq
sSk3QdN0kqlBkyO/bAfDVg2BHImd2C9ZktPvul5JgypL6Nj/naE=
=Nbhf
-----END PGP SIGNATURE-----

--kru5cayobwcmhhvm--
