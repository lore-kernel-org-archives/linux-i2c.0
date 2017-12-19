From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v5 2/3] i2c: core: add device-managed version of
 i2c_new_dummy
Date: Tue, 19 Dec 2017 09:28:27 +0100
Message-ID: <20171219082827.wl4q46lpgv5zvivq@ninjato>
References: <ee904c64-e1b3-7fa0-7df4-7e77530a974a@gmail.com>
 <ca47ea36-9b0a-c247-29f5-1c512f52e835@gmail.com>
 <CAMRc=MfWv0yZsLuF8wfqBK6cNoPkMoG6oNwa3ov9nRceJ1ykHw@mail.gmail.com>
 <20171218203042.y6u7uvlhdlvozbkv@ninjato>
 <CAMRc=MfFXKnQUiJS0j+RodXzXRDreAnWZqvOUK945fe8pkVHsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="k57jgr432krrxr52"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:42745 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758335AbdLSI2a (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 19 Dec 2017 03:28:30 -0500
Content-Disposition: inline
In-Reply-To: <CAMRc=MfFXKnQUiJS0j+RodXzXRDreAnWZqvOUK945fe8pkVHsA@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, Peter Rosin <peda@axentia.se>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>


--k57jgr432krrxr52
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Indeed, but in this case, if you pick up the whole series, you'll run
> into a conflict with patch 3/3 since at24 in my tree diverged so much
> from mainline.

I suggest then: if I apply the core patches, I'll send you a pull
request with an immutable branch to pull in. D'accord?


--k57jgr432krrxr52
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlo4zacACgkQFA3kzBSg
KbZEfxAAns6IxWB5s0SOQsMyAY5IbDbc3cGHt/DNG/2p+7Q3HtQn8wJFyMqDLfCl
Wu3vuwPvEg19XjczH/DBr/17g656NAuJinyXLwpD5R22zZcogwVk1NNdNec6G2P0
qO6aGjFcG0XqnlW40xAtpHwF0GInV5Req4GmkvmWUjGdCGXs6lzyPJkLJ7tRLqQz
hEs6uENhln0rfrNYHH85JdO41oRwLA5+0fcBEJvN3HSoDGQ02WSCm9SCMagBE8W5
jElvbOTbPAuVS2PPioOn6j6Oe47zsH1slvvsFuXeBQY5QWdsfJx15irpFq0wLCjZ
jaXAwvfqULLAGQKz6avK/f/jJa2GtfHnxufC1XzSfqPWIDS+dU+ybs8tfNSJQ6oh
DE70REmeFMA4e5nUN3lQHWS/CDZ8juAGoAzkPxfM6l02bVifdwWuRldg604ayYxG
hvtGyiyK87iSqJa8VtOINN55XonpUn11dUn+5/drmksIhpZZq2kfNAibJDWc+caJ
moe9bP7jWVIeX/oTYDgawVjUBuwDEkK1+ElPol2CLf9ul9Ov4j9oD67Ho9hwuy7+
ktKvA/dRxj8O1oyOCUIJVJCsy+onmJcPneG9/3Wcbu9UK5cBRkbtdZ92rHVHNFqr
Qr6vUpFatYsqJ/VKttrYN3SXDitTCjKibPjAdWec60HPu7o5JU4=
=4Qyc
-----END PGP SIGNATURE-----

--k57jgr432krrxr52--
