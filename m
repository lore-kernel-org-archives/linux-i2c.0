From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v1 02/15] i2c: taos-evm: Remove duplicate NULL check
Date: Thu, 2 Nov 2017 00:04:43 +0100
Message-ID: <20171101230443.czioqwwtxks67j5v@ninjato>
References: <20171031142149.32512-1-andriy.shevchenko@linux.intel.com>
 <20171031142149.32512-2-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qconrqibsmekcpdt"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:59339 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933336AbdKAXEo (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 1 Nov 2017 19:04:44 -0400
Content-Disposition: inline
In-Reply-To: <20171031142149.32512-2-andriy.shevchenko@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, Jean Delvare <jdelvare@suse.com>


--qconrqibsmekcpdt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 31, 2017 at 04:21:36PM +0200, Andy Shevchenko wrote:
> Since i2c_unregister_device() became NULL-aware we may remove duplicate
> NULL check.
>=20
> Cc: Jean Delvare <jdelvare@suse.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied to for-next, thanks!


--qconrqibsmekcpdt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAln6UwsACgkQFA3kzBSg
Kba5ig/9FFQPzgpwYnvH40ILe202TKGbwFiqKV6LfRESOWBtPTzp7cBUFxjRipwA
1lT0s6WUuPmDYmxVAv8t/28ieEjxa6M/FVEKxNWdlQ5rpMkRz67iLtyHp+ggwgrb
qM0KV46FHNmIfJBbfnfWgdRc6Fol4GyJLZmhq8UDevrxFbfaT7sJsWKpMlyD3Eb+
2yWa59ZKAa27ZYuio/Vt0GBp/G3W69kV5NJ6KOHO780z5Ftvmi5cxOxtzx6aLmD2
Q/VuVjbIXcmZVXVjjEwKDzFVtrEv+n1YjKPMNolmVjL6MurVtdW4/SJ1elwna2Pu
xivCLG6OaAHpObyRXM/iJaCvwBtk06HVwlIGsc9pjv0ZnMpo+niEmo2bHshKc/OJ
bf+K+gniloYMyVUOOLFnN1YE/LEewidVmSQp/XfsAY1/s1cXO8xlkRkrgNrB6F3Q
VjHq/8cAM0PI72VdbkwRFpqEYlA5oroIrqOcPCYzFmLONVW4p+bifsuznW8UQjuu
70qo7NVmLy+LsC/YZ+CpWXjXNuP6mcbufpwSdIW+H08r/3lTZcLg3OFWZUOo+XFB
z5BcYWFjj7Nch6zwjEYm5Kx++YSpcRI1m9pxTd6DjJLC/JKj9XiAxP5Gt9YiR+LV
WXA4Y7vnlJOnU7t7wmtu5BdhMe1LH9KFhx1jC8L6doLe0hLvLWI=
=um6x
-----END PGP SIGNATURE-----

--qconrqibsmekcpdt--
