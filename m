From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PULL REQUEST] i2c for 4.13
Date: Wed, 12 Jul 2017 17:54:35 +0200
Message-ID: <20170712155435.7bnwhf6apsr5tqhk@ninjato>
References: <20170712154901.yrrhtwfpnokkmswe@ninjato>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="75z443qnoi6vp2j6"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:46205 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753209AbdGLPyi (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 12 Jul 2017 11:54:38 -0400
Content-Disposition: inline
In-Reply-To: <20170712154901.yrrhtwfpnokkmswe@ninjato>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org


--75z443qnoi6vp2j6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> with much appreciated quality assurance from
> ----------------------------------------------------------------
> Andy Shevchenko (17):
>       (Rev.) i2c: designware: Let slave adapter support be optional
>       (Rev.) i2c: designware: Make HW init functions static
>       (Rev.) i2c: pca-platform: propagate error from i2c_pca_add_numbered_bus
>       (Rev.) i2c: pca-platform: correctly set algo_data.reset_chip
>       (Rev.) i2c: acpi: Do not create i2c-clients for LNXVIDEO ACPI devices
>       (Rev.) i2c: designware: enable SLAVE in platform module
>       (Rev.) i2c: designware: add SLAVE mode functions
>       (Rev.) i2c: zx2967: add i2c controller driver for ZTE's zx2967 family
>       (Rev.) i2c: designware: introducing I2C_SLAVE definitions
>       (Rev.) i2c: designware: Cleaning and comment style fixes.
>       (Rev.) i2c: remove unneeded includes from core
>       (Rev.) docs: i2c: dev-interface: adapt to new filenames of the i2c core
>       (Rev.) i2c: break out ACPI support into separate file
>       (Rev.) i2c: break out OF support into separate file
>       (Rev.) i2c: break out smbus support into separate file
>       (Rev.) i2c: break out slave support into separate file
>       (Rev.) i2c: rename core source file to allow refactorization

^ This ^   Worth pointing out. Thanks a ton, Andy!


--75z443qnoi6vp2j6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAllmRjsACgkQFA3kzBSg
KbYyGg//QA+Zjf8aXsODEfktRVOfffZWfTq91nMdtoISkRolWUGt3VzWzLuibDyf
vmhcIV2Qgw5fDKFdnZjoriViZtBGg8dhKy8LNrAo2NOulH3zhCFwjL1zp/PTCOoN
NW4ddh41Wf8e8cVZnjX1HDUyx8JXArvaBCYbX7GAG2wgmsh7WtUPhhSAl33x6ISO
rHxe5wlL4TqKgv2kbGKsHhiovGs+HLaHMemFEBsJNVwJ8ylI5/mnIJorT9ne324E
QnqCupNssCHz13dCkxKzd7qLkrFnx7QGax3+k1H6KgySmPD4ySsVv7lCkaNp6+Ww
keKGxsJjK5a6jtb92n+CKKqUnCV7XCbqfxWFUPZJCIVPRVTFnGnjP8Xhy3PQHPyb
6jSDunUZbJ49A0qrIotOqGWImuFA9udmPI2Gr8X/gByFtRBX9S7jW3SYO/uD+zdu
NwxWrZSGpn8JjpTinq+gsgewesN+kPKDWiePhW506Pn2rVhxuHrVj/2JRZyXsEje
OzOQskw2gIAkHuUw4c+bGFKq6AYhbj7AmGfRzFspRA9zMQ08nljL1BWEoc17l5Bs
Vj9Kh+8Ex81g2MURqKU+gFqOyxIzGQ4Uj8D0Q1loYVOeC46PXzV9Pe3Bhu5DqKuw
jGQ4dPDNlkOcnu/NbFO0XN80DA8AfSDE3/apt8pnr9b0mLtp9S8=
=fNDa
-----END PGP SIGNATURE-----

--75z443qnoi6vp2j6--
