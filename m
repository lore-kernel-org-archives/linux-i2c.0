From: Wolfram Sang <wsa-dev@sang-engineering.com>
Subject: Re: [PATCH] Revert "i2c: designware: do not disable adapter after
 transfer"
Date: Fri, 25 Nov 2016 23:24:19 +0100
Message-ID: <20161125222419.GC1456@katana>
References: <20161125152227.24396-1-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Pk6IbRAofICFmK5e"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:40020 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750859AbcKYWYX (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 25 Nov 2016 17:24:23 -0500
Content-Disposition: inline
In-Reply-To: <20161125152227.24396-1-jarkko.nikula@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Lucas De Marchi <lucas.demarchi@intel.com>


--Pk6IbRAofICFmK5e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 25, 2016 at 05:22:27PM +0200, Jarkko Nikula wrote:
> This reverts commit 0317e6c0f1dc1ba86b8d9dccc010c5e77b8355fa.
>=20
> Srinivas reported recently touchscreen and touchpad stopped working in
> Haswell based machine in Linux 4.9-rc series with timeout errors from
> i2c_designware:
>=20
> [   16.508013] i2c_designware INT33C3:00: controller timed out
> [   16.508302] i2c_hid i2c-MSFT0001:02: failed to change power setting.
> [   17.532016] i2c_designware INT33C3:00: controller timed out
> [   18.556022] i2c_designware INT33C3:00: controller timed out
> [   18.556315] i2c_hid i2c-ATML1000:00: failed to retrieve report from de=
vice.
>=20
> I managed to reproduce similar errors on another Haswell based machine
> where touchscreen initialization fails maybe in every 1/5 - 1/2 boots.
> Since root cause for these errors is not clear yet and debugging is
> ongoing it's better to revert this commit as we are near to release.
>=20
> Reported-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: Lucas De Marchi <lucas.demarchi@intel.com>
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

Applied to for-current, thanks!


--Pk6IbRAofICFmK5e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYOLoTAAoJEBQN5MwUoCm2zPAQAIzjsbiX5hQh0xSwXCEOxPpA
pmmBbsZCGLSFB1R6cno9hJ5nS0njYG2j+QO/wnEBjvRdJhhxhCg8QPqpOYBPmpSh
tAbBQYb/Fr26x8T06nZitWbg4d85qq1eFOR6F4MYoBcAVOGQVv6X8z2jk/JNBIvm
FNl50ZRZqKxBAyGTYkG0rtefO39WjVoTPA2gG/8wHk1gUyhqovDA1hFinStcliH5
WJE636/vrYaZqjBig+rPPd2uSAs88oOt44wzS8RagLGBAMYst6WkitiefTu9DteM
vOuX02iK3LcZlJ4aS7CSbt7FXDceZZ6sUCgFUAY17KNz7tE/wYAZtOfS6GK0ri/r
qKUHreHW4NKy5fdlADxjWpYCbUtKQAYQEBvGXQEBBTVZTnO/zThz+8iLb30J93Um
KmtvGSdMtmIYMP5G/BVv55y2Xheg/WHEygpsSpU8XabVsQgDm09++Y7n/r6YghgF
h0pUA6VvXFXigoQZjXZu+ptrdfdokaYywwajPvHZzW8eQzwmKY8QgJwMu7IkGlpL
HTAXd/fOfbMBkme3GZgYsg1OpE7RcbH9KRnx8/RxGsKCh/4snIkTcepmwLlaCGaK
NqpJ4MU040Y1n2vJQPBp4WFliFs+6e1rGl5AnGtL7UVkJV5MPFgs5LEFEkP/NH9i
iEcBw0Y1tt6NljyuKhhi
=P4Po
-----END PGP SIGNATURE-----

--Pk6IbRAofICFmK5e--
