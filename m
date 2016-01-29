From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c-piix4: Better bus names
Date: Fri, 29 Jan 2016 11:17:49 +0100
Message-ID: <20160129101749.GB2053@tetsubishi>
References: <20160127144033.749e3652@endymion.delvare>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="O5XBE6gyVG5Rl6Rj"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:41707 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752507AbcA2KRy (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 29 Jan 2016 05:17:54 -0500
Content-Disposition: inline
In-Reply-To: <20160127144033.749e3652@endymion.delvare>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Christian Fetzer <fetzer.ch@gmail.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>


--O5XBE6gyVG5Rl6Rj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 27, 2016 at 02:40:33PM +0100, Jean Delvare wrote:
> The I2C bus names are supposed to be stable as they can be used by
> userspace to uniquely identify a specific I2C bus. So restore the
> original names for all legacy (pre-SB800) devices.
>=20
> For SB800 devices and later, improve the names. "SDA" refers to the
> serial data pin of each SMBus port, it's an implementation detail the
> user doesn't need to know. Use "port" instead, which is easier to
> understand.
>=20
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: Christian Fetzer <fetzer.ch@gmail.com>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Wolfram Sang <wsa@the-dreams.de>

Changed the subject to "don't regress on bus names" and applied to
for-current, thanks!

Jean, could you use the "i2c: <driver>: <subject>" (check git log for
examples) pattern for your future patches? Thanks!


--O5XBE6gyVG5Rl6Rj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWqzxNAAoJEBQN5MwUoCm2Z7MP/2IZbdbr4dWr7UnZyz3uxq7p
MEWTCavGq3MsX/cEN2EHHcXX7Xn32bG35tAhBiP1yOQDLXh/aGJRsc/5W2WhlFCw
NRyDp5aqXS/IzINA29TSl8rK0/Qf0ngxm+2QJj9m/o/qzzJGgzRuRLMxcwk/jlci
xi1LZIZkIPJTBGTy9an0G1McOpN+nPfynXZ0zlXrLkezynzfhrmFm95ysbB6BBbl
Ht/dE9wvdz+Sb4PKzQTWE29OizrKnPfAEJ3nL8ruW25iyXvfXb6VSbmsjxaX49e/
s3+Q+1a6fn0RvjBUbP0LlJXJsYAeMfOOJiynvgoH8j0iox/b6+ETBBOJJBvK78Tg
O00Z6m/wYyEO9kwgi2viCehwDuxP5tQkG9KVn1Z/2cxVzr5/z3p1jEXbwgo1uJbv
Lq5+Qj12hpDbsvbi2S943PpXlUPh1U8yRWRBWRyT+FDaE9/Vxc8iLOWjieu7tbYw
L6KpE4l4gz67zNzjZ7ivazq7jjV71nBjj7VI8P5SHRCpAc9Pkr3qeZ8Obnoj3eRa
EG6E7C9qjcGRGPk/h8c0V16Um1PgmkQd4s3o2bLepYK8QUpIYPqlUlYgI0KfyRgh
GW2EBKq48I5vBn8Pj+SbI/fEe8IrT6a+qP0Jqn9p6zo3vGxlG+bKbEiEZiJnGPio
lH5Ecz9nJ0A9AjpZTEot
=Jvaj
-----END PGP SIGNATURE-----

--O5XBE6gyVG5Rl6Rj--
