From: wsa@the-dreams.de
Subject: Re: [PATCH 06/27] i2c: Allow compile test of GPIO consumers if
 !GPIOLIB
Date: Tue, 12 May 2015 15:23:16 +0200
Message-ID: <20150512132316.GH4447@schokonusskuchen.bad>
References: <1430836404-15513-1-git-send-email-geert@linux-m68k.org>
 <1430843563-18615-1-git-send-email-geert@linux-m68k.org>
 <1430843563-18615-6-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yQbNiKLmgenwUfTN"
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1430843563-18615-6-git-send-email-geert@linux-m68k.org>
Sender: linux-gpio-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Arnd Bergmann <arnd@arndb.de>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--yQbNiKLmgenwUfTN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 05, 2015 at 06:32:22PM +0200, Geert Uytterhoeven wrote:
> The GPIO subsystem provides dummy GPIO consumer functions if GPIOLIB is
> not enabled. Hence drivers that depend on GPIOLIB, but use GPIO consumer
> functionality only, can still be compiled if GPIOLIB is not enabled.
>=20
> Relax the dependency on GPIOLIB if COMPILE_TEST is enabled, where
> appropriate.
>=20
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: linux-i2c@vger.kernel.org

Applied to for-next, thanks!


--yQbNiKLmgenwUfTN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJVUf7DAAoJEBQN5MwUoCm2DCgQAJ/H2Oo0zW3tLM4UzGuhwfmZ
vonIY1udHsiYrjXdjQYQ7nlP4KtYXzrDjLh0ZXbisQT/yXDmNle/ZwNO9SnrOIzp
Q2j/gZIPI9kgSWb0uG+UfAHoUtmP9FxXH4/u842RkN+25I0rs3iAZCCivFZpPgOq
v2ElNeD2NLUTIMRW39kHSII3Aum+2rYKhJwHY3DPbth8KiyOe++V2hh4g76gZRII
DFvjZJsDA0oxk6K+PKtrT9Wp5L/x23ar3tlKkamKbkjy0XqW5Rh1beJSenz4QLjK
5gXy/mtwQTWY5tjoW8eJn1UccgtKcGA708Pl5sLSgW6QospUBXsREjOJhSSytqg+
mGo+JykSWbGmwJ1OUI0WLLjZC5/yNAFdRJPu90pCjootrVqCniJitMgzpMJsMiI6
3xFTlmN0OeZYWl/qTXQWk5CYlsFUNcrT2nVewYeSvgbAUt8rfiHmVvi7vsFHk7Wz
VK3V/u/8NSAG3gMeoYUPrU9p0qwsYu0kKFz08IDt1aN2+tCzbzm8VDQ6JG87Nn+b
u9AP9tW3GeC0G27dyZ8pNE1w8kGERRXBbSxePHAYl6GLNnHnVTEKOhp0L4uQsWPY
IM6sndin2h5ESF1wnEbNwlTsOpn3pSfjza8k8SkdbuAcW/20MuIl3+DpA+CgqH0T
LfE9tUnHvmiU1ehe5DJZ
=yZpT
-----END PGP SIGNATURE-----

--yQbNiKLmgenwUfTN--
