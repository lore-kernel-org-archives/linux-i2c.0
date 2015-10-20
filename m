From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 1/6] i2c / ACPI: Rework I2C device scanning
Date: Tue, 20 Oct 2015 16:26:32 +0200
Message-ID: <20151020142631.GA5379@katana>
References: <1444213129-29793-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1444213129-29793-2-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MGYHOYXEY6WxJCY8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1444213129-29793-2-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@intel.com>, "Puustinen, Ismo" <ismo.puustinen@intel.com>, "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>, linux-kernel@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 07, 2015 at 01:18:44PM +0300, Andy Shevchenko wrote:
> From: Mika Westerberg <mika.westerberg@linux.intel.com>
>=20
> The way we currently scan I2C devices behind an I2C host controller does =
not
> work in cases where the I2C device in question is not declared directly b=
elow
> the host controller ACPI node.
>=20
> This is perfectly legal according the ACPI 6.0 specification and some exi=
sting
> systems are doing this.
>=20
> To be able to enumerate all devices which are connected to a certain I2C =
host
> controller we need to rework the current I2C scanning routine a bit. Inst=
ead of
> scanning directly below the host controller we scan the whole ACPI namesp=
ace
> for present devices with valid I2cSerialBus() connection pointing to the =
host
> controller in question.
>=20
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied to for-next, thanks!

I am going to pick up patch 5 as well. I hope the others can go via mfd
and there is no build dependency on them?


--MGYHOYXEY6WxJCY8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWJk8XAAoJEBQN5MwUoCm2VdsP/2OCBz0JyaVBjgLSk0z8PrhO
H5D3bHPw/keLONC6JPkQCqIHre6h6twp5KJwu7JDvttyukP/SDepZm4K3scgNj7K
URDAZupc8AtqE2jVU5UHg28Q3hEu8lMe7t6JE9gmRQ8FsxfHHh4+9OIQ+UfKYwa+
wiiTeMX07YxuvmYdxTwgLiBjAyGABTbrdMr1nIu0tPP76cOws7OzBg5Gj91/iO1m
67sUJA67f3TVH5LIpTuu7f2lOpLeXA4DsmnCNeUr5EeOpBqcbp9Fgh1aOPZPBlIJ
dBTRdjxsXEk5Jqw9vRziy5h71qysppyEQHT2gt6VCsmm0XoCoNR4N2P4mUZJcFSS
OgEGNvjCZEFoIgeLmz385OepcHeGv+Fn7dozvpZhuW69WXvW0h2NW/EJamNU6v+j
iEEv3qG1qm/hZ3uh242MuZ/zY6G9q9uc6Fyg9PFjOVRZmQBuPYGlQU9m5n3q/B1c
NAUqFdlylum0B22cnCSfsbEO8VEP2PUgN+mSITmspeIJlr+ksRRwKER6p39Kox8p
8zX4oH5NY0X2yc7h9OiCLCnjcReKY+KyuG8hBJytlVk4U178yf7EsQyW30Qg5Qx+
PZhMVJC4RdkBnvozVcl1fQhkq3vao9JAw4CBTAXivrcesM+MvvFXx8LAV0NY5uKn
tB1VTAl8gCMI4hfiehRx
=piWK
-----END PGP SIGNATURE-----

--MGYHOYXEY6WxJCY8--
