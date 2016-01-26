From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c-piix4: Fix SB800 locking
Date: Tue, 26 Jan 2016 06:42:18 +0100
Message-ID: <20160126054212.GB1533@katana>
References: <20160122141202.09c94802@endymion.delvare>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7ZAtKRhVyVSsbBD2"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:50822 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750794AbcAZFpA (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 26 Jan 2016 00:45:00 -0500
Content-Disposition: inline
In-Reply-To: <20160122141202.09c94802@endymion.delvare>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Christian Fetzer <fetzer.ch@gmail.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>


--7ZAtKRhVyVSsbBD2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 22, 2016 at 02:12:02PM +0100, Jean Delvare wrote:
> We need a single mutex for all 4 shared SMBus ports on the SB800. A
> per-port mutex doesn't protect us from concurrent access.
>=20
> In theory the mutex should be per PCI device, however in practice we
> know that there's only ever a single instance of the device in a given
> system so we can use a global.
>=20
> Also take the mutex during initialization, as first port may be already
> in use when second port is initialized.
>=20
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: Christian Fetzer <fetzer.ch@gmail.com>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Wolfram Sang <wsa@the-dreams.de>

Fixed a sparse warning by making the mutex static, took the freedom to
read Christian's mail as Tested-by and applied to for-current, thanks!


--7ZAtKRhVyVSsbBD2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWpwc0AAoJEBQN5MwUoCm2uBsP/2lPve3wiONfzApfSVikDVUl
q9ck0Ho3GFQbsSCOtv3jrxfYFatGzNhNiiQLvAwip2AI4UkdXtX2OoE00NR9f7D2
2710eg4sIED5ZnbXpCrlO4tL4qVqsZeBeTyBZxu6U0m69GfL2FY4bYuQCec922S+
3BqYNx/+43aZ1OkuXzupPhUD8LeUBFMD2t19yL9zL0K3vayvwR3tDbbBgRwue7pQ
aDdIWsdD9LaYYfYhxv/GIWTILKgK9gQfeCoToBbZTAqd9aI6+AQpY71NOZwRQ0q9
6ha0W8rHv8DdnFQMrqQwiYwwShafM1CB4wqJ562MRjJGtIaDS4iSCHap3ykQ2nwm
OHqaoVMCnOsr1soJHPbW1ICAdz2ML6C8gzT6awk7QlTUdBcVEULftDf2X4D5EaJC
tg6qz4oKm2Pdn4/agRhkkmoTWJ99LynaPFppVoFO4QbYMHIQEBIXBss17OdQITIV
+sD4j/45LzUj6Bupz/ndX6u2Ub4xbQoZ+hufF8WHT9E20I2uvghszBxqQXdMWQkq
7R5UZC2Pp9O++z7HzoiaUZ9Ou8dyUxx18e28Pj6RMgTCbRsMZ70ljQ+RiML0Mk8k
aUyACX2glSwYKJQEXA+ZkNReraEnKBCqCCJyzkQHS8PdHIvtpWeZoK0dUBHI47cY
YDmimUgzhZfvM+a9Jjuj
=FOS1
-----END PGP SIGNATURE-----

--7ZAtKRhVyVSsbBD2--
