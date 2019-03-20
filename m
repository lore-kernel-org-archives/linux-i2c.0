From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v5 2/2] i2c: designware: Add support for an interface
 clock
Date: Wed, 20 Mar 2019 17:58:20 +0100
Message-ID: <20190320165820.pjydd5ophxoulwza@ninjato>
References: <1551361930-24434-1-git-send-email-gareth.williams.jx@renesas.com>
 <1551361930-24434-3-git-send-email-gareth.williams.jx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xfr6vjbdofsxw5tr"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1551361930-24434-3-git-send-email-gareth.williams.jx@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Gareth Williams <gareth.williams.jx@renesas.com>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, Phil Edworthy <phil.edworthy@renesas.com>, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--xfr6vjbdofsxw5tr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 28, 2019 at 01:52:10PM +0000, Gareth Williams wrote:
> From: Phil Edworthy <phil.edworthy@renesas.com>
>=20
> The Synopsys I2C Controller has an interface clock, but most SoCs hide
> this away. However, on some SoCs you need to explicitly enable the
> interface clock in order to access the registers. Therefore, add=20
> support for an optional interface clock.
>=20
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> Signed-off-by: Gareth Williams <gareth.williams.jx@renesas.com>
> Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied to for-next, thanks!


--xfr6vjbdofsxw5tr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlyScSsACgkQFA3kzBSg
Kba/Fw//ZY5silg+MDSe2w4nAQY0r1OsdEGU1eHK7QCZlVV8NtBAkThhCsXNDFFK
SI05H3PSl1VhMzWlD+hAwX4REJ27xqeoFtgKwSrN/BoxYmxK8/3p3TPRBOgbYdaB
3H8kFD0TChviM+tIDPnUGWK/AiQ+FYl0QG/VUgJN1xkhf3AVj2fIruoU7pwyAI1a
HOTvJf1yDp0yAKK/WCerDd5NaUfVI/XqKUf4sx+p8BTBt7KWnHrDrQOj5GrEMg6g
he/BwENfDMaGbSBhMPWJEWxvwG/8G3e49C1w66xxwhBGSEH/MEyR+pVA1p+uDjfL
OMrdtxrlOTntamR0wGbKBV7dY9Bgz0zrbpd8dhV9Qc9WWrqHaaYeP36LgKIyAcib
SmWKEumv0b7uRhlM/kvH7yP7lwFdzLUXTzVvyGbQonbywimHs20DPtymxDaixsHv
bqybg99UXSB4I+MRhm3KChsurNv05jVZQavPQOeqihqNFG6yysZWYQd/HW5Z8/cl
LKUhtvRbMtcSk/jUf16ioiq1qymUTAwLnAcYIs5kVINXdVsWUyJDAtis6QOI+bDP
R6dwjontf8gpQSp2tP/ISOFfIiR/IRK8/Iw6S4ma3UqrIU5MfOHUtfGgVrpVPOlR
/q9Fj6R03Z97GbqQaLbfoDs7S0VVO06ZggqZb4PikONM17dp4uw=
=tTfE
-----END PGP SIGNATURE-----

--xfr6vjbdofsxw5tr--
