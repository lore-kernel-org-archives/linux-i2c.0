From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 5/6] at24: enable ACPI device found on Galileo Gen2
Date: Tue, 20 Oct 2015 16:28:51 +0200
Message-ID: <20151020142851.GB5379@katana>
References: <1444213129-29793-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1444213129-29793-6-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hHWLQfXTYDoKhP50"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:43103 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752150AbbJTO2z (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 20 Oct 2015 10:28:55 -0400
Content-Disposition: inline
In-Reply-To: <1444213129-29793-6-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@intel.com>, "Puustinen, Ismo" <ismo.puustinen@intel.com>, "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>, linux-kernel@vger.kernel.org


--hHWLQfXTYDoKhP50
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 07, 2015 at 01:18:48PM +0300, Andy Shevchenko wrote:
> There is a 24c08 chip connected to i2c bus on Intel Galileo Gen2 board. E=
nable
> it via ACPI ID INT3499.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Sparse rightfully says:

drivers/misc/eeprom/at24.c:491:53: warning: symbol 'id' shadows an earlier =
one
drivers/misc/eeprom/at24.c:474:50: originally declared here


--hHWLQfXTYDoKhP50
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWJk+jAAoJEBQN5MwUoCm2FBwP+QGNIKvp9rhU8y+7Z8D+zqpe
/oQ8/1/UD+DLUzWA+5gLixdD1rsBwpldKzjiIJ5S7I1ScXsGE3BiRLI5T54S7xvv
BgRRNkPnWo3e4wSKFIKY+MWYlSIiZW9Bikvki6wFaP+yRk7Lg846dJSydxEc3XOg
/VFGmroTyStxxLkNZmgafF3x26hHmQlGnKLa8IONee/XICxcjIDZ4QRZYB+COAzA
iKSbUOkRR3Z6Jfu4Qgo0NzbM2rggLcRKkmHyiGEwy+ShR6NKur2sAxO3KKbmJY6h
BQmDtVl6KAsr0i4p0zmKC2IZ28qhtBrxFdjSZg7P6rkzljAbZR+YxwDWGOR+mDGv
omEBYSjxVOHHoB92H9kkdGhnCjzcaenWtRutml7GiEnR3aEt8ZrIp6isDeBHa2dU
/kWZ0aWFzbZoUBV39Wdczog2X5LwQ5VR6+LTiZBse3Ydo3ANsM7gkx8UunOBZzVu
ivklHIb0B7T1DP8fJ4onhBESyXxJQ2XH4E1bR4QOJJziHO767l6uNESroAgOOpER
yvCuHfVeoU1lwUe5qt1xBDtVHpJ+GTq/OG3bGYRDvXyPjCejFUC5+tieuCb6Wb6q
MwPM/010kEVXEbKWcJeB7zBN8/JsmDLr8E4KqgZ1SgQNsBcLvtM7O82YK1jZAH8N
PklIg3GoxebdlTF14Pnf
=vVZ7
-----END PGP SIGNATURE-----

--hHWLQfXTYDoKhP50--
