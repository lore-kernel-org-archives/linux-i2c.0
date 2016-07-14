From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 3/3] i2c: designware: Find bus speed from ACPI
Date: Thu, 14 Jul 2016 22:36:46 +0900
Message-ID: <20160714133645.GH4149@tetsubishi>
References: <1465212383-24639-1-git-send-email-jarkko.nikula@linux.intel.com>
 <1465212383-24639-4-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0OWHXb1mYLuhj1Ox"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:32920 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750897AbcGNNgy (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 14 Jul 2016 09:36:54 -0400
Content-Disposition: inline
In-Reply-To: <1465212383-24639-4-git-send-email-jarkko.nikula@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Weifeng Voon <weifeng.voon@intel.com>


--0OWHXb1mYLuhj1Ox
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 06, 2016 at 02:26:23PM +0300, Jarkko Nikula wrote:
> Fast mode is the default speed of i2c-designware which can be overridden
> by platform data or by "clock-frequency" device property. Even though
> the ACPI 5.1 can pass device properties via _DSD method, shipping systems
> define the connection speed between I2C host and each slave in their
> I2cSerialBus resources. Which means speed is not defined per bus but per
> slave.
>=20
> As there is now support in i2c-core to find the bus speed from ACPI use
> that to set up the bus speed prior registering the I2C adapter.
>=20
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

I can't apply this one? Neither on v4.6, v4.7-rc1 or on i2c/for-next?


--0OWHXb1mYLuhj1Ox
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXh5VtAAoJEBQN5MwUoCm2/KgP/3oPxGtKl1Ija03p1vs3xMEM
4KCIGJZk66YGS6Mm3OYJqNjW0wyQwGEAJKpl0Rlf75+gL7ugAqdZTWKsEr9Kfe7p
vTUMGhOnz1qRUDaxj3h9E2SzNHZj4hAto1X7V+TIyvv8P85x+nSSUwk77ZXJnSpO
XloNkyq72ysp57dSjBLtBA/HcpeGS70Ms8fkSVkD/8yO1S/GPJwrtGC0OrNX3mMZ
NVEEdLpi6VK7JbcdoZ1pv39PEkhQBwXq/jrXKmJrmnCgWzz/2B+2ydDz12MkAAnu
mBFwQ3X3QD2WWA7g78kTpWf0LucJjhFuLIfZhcKsu+nhfdCNJ99ZV3JJ+h+QKLCW
8sbtke9ahtRYN9bueGdE9ITEbrT8gNgiyuwLyX/3vH4nvyvPYRAqAivo1w0FoCYQ
W5O4P1Jg7sl8JeYqoBwEsCKIxiTp3AmYLxSpWoYpO+un65DizYQT3kC246F86AzG
h6+IqywyLiSTYkRrVQFCLo3mpyrxWyU1/n6kiVaR4slwaVJvSnUEMYb4USfaEdTz
BHa096p7FM8xIE3IzOCvPqSFJ7ymJt99MmZjM1JOLV3iCtNhdtZ7UILL71yeB5yI
Ay4Tdk3scVvYydWrDUKCS/9K5yXaY/vqxZwJs2ZHnivDVslSeQQlX8Cs9RCplvwY
wGFKIca6o7kdPpeV17E9
=/4qV
-----END PGP SIGNATURE-----

--0OWHXb1mYLuhj1Ox--
