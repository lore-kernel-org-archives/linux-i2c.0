From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: designware-baytrail: fix potential null pointer
 dereference on dev
Date: Wed, 19 Apr 2017 21:01:22 +0200
Message-ID: <20170419190122.qoudvukbgioxoy3l@ninjato>
References: <20170320115123.31536-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xczzx5lpioxvfs35"
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170320115123.31536-1-colin.king@canonical.com>
Sender: kernel-janitors-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--xczzx5lpioxvfs35
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 20, 2017 at 11:51:23AM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>=20
> The assignment to addr requires a call to get_sem_addr that dereferences
> dev, however, this dereference occurs before a null pointer check on dev.
> Move this assignment after the null check on dev to avoid a potential null
> pointer dereference.
>=20
> Detected by CoverityScan, CID#1419700 ("Dereference before null check")
>=20
> Fixes: fd476fa22a1f432 ("i2c: designware-baytrail: Add support for cherry=
trail")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied to for-next, thanks!


--xczzx5lpioxvfs35
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlj3tAIACgkQFA3kzBSg
KbbBnA//dmRxxbvYcLgi3+Wfvb/MRmrvZKnT1w81f0gjnIbWZWcCWab2z/1vJX9Z
s2i8OVHJpHOYuzY6fqhpwd11GGscUM6lRI7Sh6gFb/vDaEwXMIijoI1bf4pNhLvF
S/jLEuMToEwEZBxrtOO4HHnqouYwZDnYlPZf6bYGVIFE7V6A6j0Gv6lTqty89Olv
EOKF5obOZ1SVyN7eNKHJbcW/5CidUcYSxEpnyzxNPb1g7tzbACjO4s5vYPRhVh9T
XSUyDOu4xll0nD0p3dYCLQolHEsXslZdCq2NBG8juMWA2LZpAAYeqfI9gAGLDhKL
y1wF2UlJASHAzSA8ivWL99IMk+G29/+FQ3jCkD86JErhspFfVl8tDowDptFaEtGZ
uvM6ss1YnkGiz5EcSiyDv0QS+9ovgp8/KERVRKTgk7pHCZedHGxseOJaa3ewNTM5
1ah66SImJt/Bz2o4ReMkY3SYItqZmvYQf2GAC+Z3lwOzYtcCJ0fuA6ngOzk+4ytf
Xp77N/ua8/amju4ze6/2z2+0dso/T4ZNANtibazGxnr/dcFbV9HzvOl52u8i1uZ9
LPc5RnPxmcVO8z9C6nx+S392sDx74k8ocp12aBqATVmNVXgz5y0M6ycemVWFu1ZY
r7mjSGTb0YL2QLBwNATks2aaOcORLtM3H82RMO3dYTpcXAsrVik=
=OWFp
-----END PGP SIGNATURE-----

--xczzx5lpioxvfs35--
