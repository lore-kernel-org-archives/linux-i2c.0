From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 2/2] i2c: designware: Let slave adapter support be
 optional
Date: Tue, 4 Jul 2017 16:14:10 +0200
Message-ID: <20170704141409.7nozrt6m57f37rjb@ninjato>
References: <20170628142329.14818-1-jarkko.nikula@linux.intel.com>
 <20170628142329.14818-3-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="73svywazh75kteot"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:49238 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751972AbdGDOOM (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 4 Jul 2017 10:14:12 -0400
Content-Disposition: inline
In-Reply-To: <20170628142329.14818-3-jarkko.nikula@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, Luis Oliveira <lolivei@synopsys.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>


--73svywazh75kteot
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 28, 2017 at 05:23:29PM +0300, Jarkko Nikula wrote:
> Only certain system configurations may use the I2C slave mode so let the
> support be optional. This allow reducing module size if needed:
>=20
>    text    data     bss     dec     hex filename
>   10328    1336      16   11680    2da0 drivers/i2c/busses/i2c-designware=
-core.ko
>    7222    1136       8    8366    20ae drivers/i2c/busses/i2c-designware=
-core.ko
>=20
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

Applied to for-next (for this merge window), so we have slave support
immediately as proper as possible, thanks!


--73svywazh75kteot
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAllborEACgkQFA3kzBSg
KbaRzQ//Td6fAn1OB5ubHVofrNJO893I4Vze6TIrQwjU623VQDUrD5Vvz1s45zGg
e2Zqj72iCoEJoiW446h8o4gz5RrFzGVoHU/KkaeZ4jTFK0Q/D9X5aPBrGoo3l0j6
EHcxmPSSkb2L0Xq2gbowgblz7dqiQc406p5AnH2J6qAVwiFoH4X14bQ52JmqsuiY
ncefyOm6g4UNygIWbXAkc2hkkI2Ti0iwGqGDMC19sgmMbffuGmLMoc0FyFjn47uf
mKkfF2dc19l3aPiGWwb4nlyxR8wsWnMkSNKvZ085uRJmuGWDj858x3igDLXntnuD
+1wt/H70eMAemF2OlWJVRLU6CFrccz7w62Eerf+04MTY6NTcaW4UF4gsk7+6a7Sl
TccYEiMHLb1xXfclt+GGkP12wSlyolmYAFw3DQP/TpsLXLAfe7NWo+SlZq+gT/15
GtHjm3aef9FxZAR91sxps4dauLR7F01o8jzKToYbKjROyAhtuh+eXhi71jnv9KEL
ReM37vK7vf+4arwEV0ArxMlyH6elZbRtNfc6OY1a0qHvDRgyer9Pn9MsPARnsIrp
zjITqVwDI+Kl6VhLG4hempKI5phabN+f84lAqRbm7+t2tZ3YUtqablJTV1sV5YTb
i/xPbZsABhRy+fXFl+kOHaDh+OWqeaHqABHz957VMF2qgxYpN7U=
=z8Km
-----END PGP SIGNATURE-----

--73svywazh75kteot--
