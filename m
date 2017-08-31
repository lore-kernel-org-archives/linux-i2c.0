From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: designware: Round down ACPI provided clk to nearest
 supported clk
Date: Thu, 31 Aug 2017 20:29:45 +0200
Message-ID: <20170831182945.ttdwpjjar6rcmlfd@ninjato>
References: <20170829120835.17276-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mhzxb6tdsodjxl3r"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:54002 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750996AbdHaS3s (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 31 Aug 2017 14:29:48 -0400
Content-Disposition: inline
In-Reply-To: <20170829120835.17276-1-hdegoede@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-i2c@vger.kernel.org


--mhzxb6tdsodjxl3r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 29, 2017 at 02:08:35PM +0200, Hans de Goede wrote:
> The Lenovo Miix2 8 DSDT contains an i2c clk / bus speed of 1700000 Hz
> for one if its devices, which is not supported.
>=20
> This is the second DSDT to show up with an unsupported clk in a short
> time, remove the hardcoded fix for DSDTs with a 1 MiHz clock and simply
> always round down the clk to the nearest supported value.
>=20
> Reported-by: russianneuromancer@ya.ru
> Fixes: 682c6c2188 ("i2c: designware: Some broken DSTDs use 1MiHz ...")
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied to for-current, thanks!


--mhzxb6tdsodjxl3r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlmoVZUACgkQFA3kzBSg
KbbZTw/9HOWCQ1BMvYZFD+TZedVUPGHS6nq7yUsaIhj+3cKzBhNQdWhE90cRcDDN
8DJQvXZ9hy3t9KuzmOskZ3T2NEdLd/bZJdK0KbviAjYiYlq8oHG7cwgeYtHS2GWX
AWMlNNUOLUkN1gq3c9VSjyAr1Xk2GUXc/uLaRvnuhqTUXCFa/N8rH1y45r2vABic
btbmpkpPhUJUNJWfPGk4W816pj2ZZM2Z4eXnkyGNABBI83TvXasTfAGg8dXYm457
y3qik5T43ikAx7SzvCyJufxGj8iTw/nv7wdaMy1qrTTOQ04nfuOH2sxKz26ilOhC
6rkPVyRFACpFABkO3A678yak2KjDvgI8AR8k+UfxWRCJROWdrjmCRqMBVu++6As8
+tj4rnb237VOGQ6jeXcVQATBMpeHjdo2iHZuJDHgmRc7LplFGriYJUbKft4doSv3
q3bTvmZ/cVfaoD2ZKk0XqlyYJREHzx2FJEz+LTPuxtmmXYmWCOMZ8eV7cwiua8Ij
B1ZktV6JBUglKOTOrUfaFV4V/l25fYBnLzwE9NSLzDJyAFzr76B8CIh2Hzg/iG5R
4KZCI1rGQbiIa5AI1+/yQlYd41TqC+WHl1hqjqd8oPahKnMsCxaL2GV7b1BwCnhZ
t261ri65kSo4HKLtuhOojTTIJFN6OwIqCspN+Di8G2/KmnSk8Pg=
=ipq1
-----END PGP SIGNATURE-----

--mhzxb6tdsodjxl3r--
