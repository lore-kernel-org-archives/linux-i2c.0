From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v4 5/5] pwm-pca9685: enable ACPI device found on Galileo
 Gen2
Date: Mon, 9 Nov 2015 18:10:55 +0100
Message-ID: <20151109171055.GA5713@ulmo.nvidia.com>
References: <1445591805-28886-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1445591805-28886-6-git-send-email-andriy.shevchenko@linux.intel.com>
 <1447077216.31665.73.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1447077216.31665.73.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@intel.com>, "Puustinen, Ismo" <ismo.puustinen@intel.com>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 09, 2015 at 03:53:36PM +0200, Andy Shevchenko wrote:
> On Fri, 2015-10-23 at 12:16 +0300, Andy Shevchenko wrote:
> > There is a chip connected to i2c bus on Intel Galileo Gen2 board.
> > Enable it via
> > ACPI ID INT3492.
>=20
> Thierry, ping?

This should've been in linux-next for a couple of days now. I see that I
didn't confirm via email, though, so:

Applied, thanks.
Thierry

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWQNOdAAoJEN0jrNd/PrOhyB4P/01B535dOhV596Vjj3MSX0BX
+gI5i8Ppk6HMKwpJTzozX0irQ4FoIesjyoV+xzkbD8EQvsCtAsrcKG5MgN6NJRhm
HCpQ5sfhBlBEy11JxwXjcJb8rPnab2w0d0Ty6XZNXegCA6ZbVnCWeDsY0dJ6R6Nz
2WReRKXaTI0RMPFRfwQpHqmzKaT9TXW1eJeT8+mM2OA+C7vcbgOc/AFy4VqPiGXR
O93BfIAr9vuB+kw3KZD0rtEXwveupR8xyPVmcSHgu4l88D/T3ieg5rnqoFRpWp8/
32JhlpznHijrqYC1CeOhJn0exzey2I2HkRt3gSij7q51awyc7Y+0gFhr1mzIsqZQ
xva66S96YPstX7U1EmEJsuWe09D+BDqE+hRkBONNB9xrNPXio3dgPybMkp6VgRvg
5R3mz5V8TkTpKicbwxRo256ehVZgVXXg/+9cvCi+5ASXL4tCx9o9I2LTMljSTt5B
a95eI5wykgFqz86k+hJUt8EdrC1qTrkQ2yNbvRH2YHOpHC4/YoXbyJ2rzbZNxWHO
cfVKpVDPVLhO92WZv17LPD5QU/k4gclaZkdJbxcziXVoxj0wSDvH69Vl+rqr+MaA
+sPaa2UFkTt1JsYfWx3SeXCYgviyZWi7mH6jzRYGRY+x2XkjGpgm53cZUs4GDexL
2LG12JtYGTaTJSpi9uC6
=STDH
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--
