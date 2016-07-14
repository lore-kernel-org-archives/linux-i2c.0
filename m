From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 1/3] i2c: core: Cleanup I2C ACPI namespace
Date: Thu, 14 Jul 2016 22:35:25 +0900
Message-ID: <20160714133524.GF4149@tetsubishi>
References: <1465212383-24639-1-git-send-email-jarkko.nikula@linux.intel.com>
 <1465212383-24639-2-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yH1ZJFh+qWm+VodA"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:32909 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750983AbcGNNff (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 14 Jul 2016 09:35:35 -0400
Content-Disposition: inline
In-Reply-To: <1465212383-24639-2-git-send-email-jarkko.nikula@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Weifeng Voon <weifeng.voon@intel.com>


--yH1ZJFh+qWm+VodA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 06, 2016 at 02:26:21PM +0300, Jarkko Nikula wrote:
> I2C ACPI enumeration was originally implemented in another module under
> drivers/acpi/ but was later moved into i2c-core with added support for
> I2C ACPI operation region.
>=20
> Rename these acpi_i2c_ prefixed functions, structures and defines in
> i2c-core to i2c_acpi_ in order to have more consistent name space.
>=20
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

Applied to for-next, thanks!


--yH1ZJFh+qWm+VodA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXh5UbAAoJEBQN5MwUoCm2GqwP/1IChojKbcXco/DHXznFiaOG
8Q501jugg7KB2QNjckDVjiq4YkNth3wDuuvUIb+k2ghpMy2SbaCxzI2mNLNm4ObX
I+uk2wxW5TUdiNOXDMGO2OirXEdK67dEHm1OdNLsxUpJyD9ThB449mYQS6+9tsMm
4Z5x5Q2nRqi3SBtDAnLFwpjZthUXHctXkK6YRwtX9b1yVK7D0i12Ty2XunT9+Cem
Om9LhQvWIy7fmslFlYffa4vj4L0b5YDq4jIYtuh6RG3qyuhmreHRibHkgPQ76ujG
Bxom5eFZoxbqT6hngdpFudn5LLW0zT88MyLQx5D2b5FjR4qK2WItkD4UiDWTrSMO
pHWCSK+e4AGkityJerb0WDIbnOsJ1G8hghijoAHbOpwX6hMlRZYZvskKtpwBzHzg
FbrqADG7rvwGOwiMIPt9HmZgnQdgCyblLNLeQLhKdqXlJqAVQknZX1qsIRXbdDor
U740DQF0mGGysjWo+1Zvj47EydLL+UKce+ChoNvXfU1Ca8RExsgc+lcIME/fBfyj
S69ulm0lMltaoXN3wcPfIgCxh1ZY0jWtbH4ehoMxNDuCI4wOzY2M4j5QfUIBGrVq
rqFMldwriNa84ZZD75EbvM0ylKhkpWSg6EAzKJhWaWrx/utN8u/nIeoPblWs6qBH
1LPxT1nkd8u/9Vgna1Bp
=suvx
-----END PGP SIGNATURE-----

--yH1ZJFh+qWm+VodA--
