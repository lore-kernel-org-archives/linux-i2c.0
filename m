From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: designware: Fix standard mode speed when
 configuring the slave mode
Date: Mon, 14 Aug 2017 21:13:42 +0200
Message-ID: <20170814191342.uveeloc3e7xnfjvy@ninjato>
References: <20170809122444.13461-1-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ghijhp5awydy5au3"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:50478 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752293AbdHNTNn (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 14 Aug 2017 15:13:43 -0400
Content-Disposition: inline
In-Reply-To: <20170809122444.13461-1-jarkko.nikula@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Luis Oliveira <Luis.Oliveira@synopsys.com>


--ghijhp5awydy5au3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 09, 2017 at 03:24:44PM +0300, Jarkko Nikula wrote:
> Code sets bit DW_IC_CON_SPEED_FAST (0x4) always when configuring the slave
> mode. This results incorrect register value DW_IC_CON_SPEED_HIGH (0x6)
> when OR'ed together with DW_IC_CON_SPEED_STD (0x2).
>=20
> Remove this and let the code set the speed mode bits according to clock
> frequency or default to fast mode.
>=20
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

Applied to for-current, thanks!


--ghijhp5awydy5au3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlmR9mYACgkQFA3kzBSg
KbZvzg//SREL3zB5R6xJHttToT7QqcOxhcQdTlP1hqu8Q2uEiIi+2EhP+hkWDbO2
bCFydBmEZBIPJzuZVEpM9Ij8seb3w11srRaPaGKKlszdNi3xHmsWUyTbuW5s4+YJ
GjzX0aThmkL+UFKgXd+vC7VCl0YTvKtrgCjzz6ngs+EI4XA5ng3ev0FT+gAc7328
9dEiSGHOZx09pVN60Bc3kNRJQ4ZDOzleV50AYPdNadyl3IgbvGdQfxdxEh1pVCwS
mlZjVDnmepeSZktf8QNACqegZrbsDCMfMjytM5VE1dSP17WJBmyXTjPm5vwYphLZ
TkEXTub/+PHpqjdNBVzfpGD/VO6hQ38TOUpzNDZvlU9PuIekEbkSIL0KKsbxYC6E
Ti2ApA7PvWBPrPFcnzqCqkwXrasabnYnRDG7p1PPDJpF65jHqWPgLMukS/imkZux
Bn1FKAF/RxRRHiLMiV+QOZWDl7AG/6EHpSdKXbFSxf3vcg6+4exMGdzmB0NisqIU
H8EtezOn/WvgauvhxU86N/iIxfuU/LKM0dcdsMimM8epwefUddAuAQfAVWWXgL55
zrPUbOXL8fNf/yYsQg9CLG1g7n5oSWVztsFdttP95c0Lmsdwm1WJwpR3GdgEtvPI
7fv5fkWU+E04NiFZio/TywtsL86VjFeE006rfwuj/yhr8QKoRsY=
=5CRb
-----END PGP SIGNATURE-----

--ghijhp5awydy5au3--
