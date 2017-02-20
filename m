From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2] i2c: at91: ensure state is restored after suspending
Date: Mon, 20 Feb 2017 19:24:32 +0100
Message-ID: <20170220182432.4md345efgej236hc@ninjato>
References: <20170216172759.27837-1-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hmsqefarm3kv2qid"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:44800 "EHLO pokefinder.org"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751426AbdBTSYf (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 20 Feb 2017 13:24:35 -0500
Content-Disposition: inline
In-Reply-To: <20170216172759.27837-1-alexandre.belloni@free-electrons.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Ludovic Desroches <ludovic.desroches@atmel.com>, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org


--hmsqefarm3kv2qid
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 16, 2017 at 06:27:59PM +0100, Alexandre Belloni wrote:
> When going to suspend, the I2C registers may be lost because the power to
> VDDcore is cut. Restore them when resuming.
>=20
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Applied to for-next, thanks (will be in 4.11)!


--hmsqefarm3kv2qid
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlirNGAACgkQFA3kzBSg
KbZ/iQ//aD4RsLNVNAdL5dbuVBAoMQmmfhoR2nJbFo4sJx6+bViaXd9+ek1P8+9M
eYHoM8hHuXtRy+P1YqyyaTkCzLSeYNcsNcRMSdVOuYXbhgk7LCr+Wcvps/6h7D18
s+R2Dl2m3m2skFL68Ri6bTylShlIs7s4N2xBusFzCCnW6O/8ikpb6O62QlD9Grgz
uoTbyuIrJEQLVF1CU+U4MFe4GcdpAZWaJZJQpm6F/KLndhceF9ah+QvJ0KSrXik6
gQOJf9AjKmXSxauVMeUpMGi0xrhsIgW0NjEtPoqcj0ntpsvQnLHmjx4JrCv7ocih
o5bYxDqofan0h1XSEkCfSh2pxwMAqqfDlJZQ6PoOBVQPp7Gec4clRof6Fb9uEZtf
AJ4Y4rdhjIOHDMFpH8lkxgsgn25aOk6x7werj8Y6INo5GvvUTfYgSUGN96OArf2b
BR65xs35zyBpzCVVYJZ3WZFnuBToMgNs7O8wR3VUkJX5hsnGD/alU0RoXkjXgQAo
NAgJfXjl71C0aWBo4/EAyB60wLIanoPACKdsar9A2HtqT2cPnizjLTl+vadcvdpT
sOLKP6fwdrJ5va8TPl0TZaIWHNFPjrhsrfKcfHmC2eKX0MlghcyAnLcOOWAmhh6b
AJTY5PgxxUvFwpGc9c302bGq/axb/t0a8eWRQiCfTblCsU+NHec=
=j0We
-----END PGP SIGNATURE-----

--hmsqefarm3kv2qid--
