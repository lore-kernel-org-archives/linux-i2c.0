From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [Patch V10] i2c: imx: add runtime pm support to improve the
 performance
Date: Sun, 3 Jan 2016 19:10:10 +0100
Message-ID: <20160103181009.GA1522@katana>
References: <1449800649-32763-1-git-send-email-b54642@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:55760 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751221AbcACSKR (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sun, 3 Jan 2016 13:10:17 -0500
Content-Disposition: inline
In-Reply-To: <1449800649-32763-1-git-send-email-b54642@freescale.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Gao Pan <b54642@freescale.com>
Cc: u.kleine-koenig@pengutronix.de, linux-i2c@vger.kernel.org, B20596@freescale.com, b38611@freescale.com, kernel@pengutronix.de, Heiner Kallweit <hkallweit1@gmail.com>


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 11, 2015 at 10:24:09AM +0800, Gao Pan wrote:
> In our former i2c driver, i2c clk is enabled and disabled in
> xfer function, which contributes to power saving. However,
> the clk enable process brings a busy wait delay until the core
> is stable. As a result, the performance is sacrificed.
>=20
> To weigh the power consumption and i2c bus performance, runtime
> pm is the good solution for it. The clk is enabled when a i2c
> transfer starts, and disabled after a specifically defined delay.
>=20
> If CONFIG_PM is disabled the net result of this patch is that the
> clock is never disabled.
>=20
> Without the patch the test case (many eeprom reads) executes with approx:
> real 1m7.735s
> user 0m0.488s
> sys 0m20.040s
>=20
> With the patch the same test case (many eeprom reads) executes with appro=
x:
> real 0m54.241s
> user 0m0.440s
> sys 0m5.920s
>=20
> Signed-off-by: Fugang Duan <B38611@freescale.com>
> Signed-off-by: Gao Pan <b54642@freescale.com>
> Acked-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Applied to for-next, thanks! Also much thanks to Uwe and Heiner for the
reviews of all these versions!


--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWiWQBAAoJEBQN5MwUoCm2B9sP/0smOXR5RH9/T0ZcgVb/PPvI
69du33GEnDdXvCfDlNO/MTaEmuwiqhrtTNO+IuDNPmpXVTymFb1uIwdarMAS+tA9
Zz4flC5ZhC/svUQkMOXbLDdKwPTMKtwe0r6/rjnRsVRpD+0/0vSPp/nbemvFVqEy
zBiz09XP1wXlSboN2BimCUSM4OD1Pjpt+PoaeBuHD/FL++657HAKDlM2OU/Lie2r
iW+lWSaYk5bsqOiWlTZRQ9rOjYilmSGGjx9rivvlG5ivyWSx8u4IzmZnMNtBWei6
Rj26BI6jnSmxruLL2iDq1wRFfC7m3or58amuFsHv+VKRdfzYI1MKbAUo30dsQkrI
s2zY3WCYc5kEyCB8JphjLJse0Wc3BCOKaDxqz4In1oePCGLOrdJSQfd52hH/0qOz
l2rgS8CWVKkZfkOrpqQkq5T3BjLXDh3Jhpc+Y4pMjoiTnOfNTpEDlBd6Wx0TDKT3
7oMQeBuOBRn6c1/JOGcxuE3Qp+4lbA6tDMiTlslyBOR893DAFEdNyYMIAahxWIJ7
PiYwcVdYYlOkQAqs2g4npg1KKlgtrOrOU3fnaUy2MSoU/DBm8PYwIocEBTz1W8JW
JwPtMGooeVgrrCATv3kItgc1AsmlesSwzb3rb1psfWixFzLYWPWgF0+4i788jLsv
teLkfVV6syB1RcO7rMUl
=Uy8+
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--
