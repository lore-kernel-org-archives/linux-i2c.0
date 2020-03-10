From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 2/3] watchdog: iTCO_wdt: Make ICH_RES_IO_SMI optional
Date: Tue, 10 Mar 2020 10:30:37 +0100
Message-ID: <20200310093037.GD1987@ninjato>
References: <20200226132122.62805-1-mika.westerberg@linux.intel.com>
 <20200226132122.62805-3-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XvKFcGCOAo53UbWW"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200226132122.62805-3-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.com>, Wim Van Sebroeck <wim@linux-watchdog.org>, Martin Volf <martin.volf.42@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-i2c@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--XvKFcGCOAo53UbWW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2020 at 04:21:21PM +0300, Mika Westerberg wrote:
> The iTCO_wdt driver only needs ICH_RES_IO_SMI I/O resource when either
> turn_SMI_watchdog_clear_off module parameter is set to match ->iTCO_versi=
on
> (or higher), and when legacy iTCO_vendorsupport is set. Modify the driver
> so that ICH_RES_IO_SMI is optional if the two conditions are not met.
>=20
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Applied to for-current, thanks!


--XvKFcGCOAo53UbWW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl5nXj0ACgkQFA3kzBSg
KbYofQ/+KqP/3Y4TZm59APCIx4WgGTFDTGRETE/siFiYssjb44yYTOQ4AR+mxb7w
bv6USsR7aMWc/Mhsuged5Bh6YCcwdQ+35R2dVKLZ8zQro219ppGnd9BtT0/weXYH
20dD9AV5dFGsLypbEYM+cujUJrp9F97lav0Vc8Junpf75ynkL7FPS1bYYcr11xnI
D3rYvsp7TghVeFZ10LnudmlBM7bAxxTX9gi6lDGDzTCvxPhX7kJoK/DvjXfWZN0k
8jiABFtiOLTjfh9gtsjF6BWCQppI8piwSkGRSO0jXEhQDqy1lWj3HXslNr8qP436
oZoL7eu0GWXbGqrry3Wo6U9rdbhf68iZOU16XFJB5oF1xTR7HDuT3+AprYZCewVo
h5IHg5CFb9LFlwVIDXi1LiUZ06O7ORoMH4ZNLSeXQ3eosMdl16WRU/8GFWIPZkhV
1YhtD/7pL/uAZ9jbL1vb+0uv9BPz/OUlI4Qqt+JkN6dgONnc3cM2GHKjVHMCz6rM
Kq8JAMQnRoaCJy2nTUUxwtU71pKfIkBdMVqJSY2o7saLR6w3jxBeLHOO9UpTkvR1
YnakISwbiFkxt1Jk3TKr7KJcaouHg6dnDmgTuyrWdQ/AD7nCNpS/mK5KaDSIulVS
UO18qQT3TYEykTjtggI/UPFtExhPXWxSbcu6b0N7oRnePMxG0pk=
=4+yL
-----END PGP SIGNATURE-----

--XvKFcGCOAo53UbWW--
