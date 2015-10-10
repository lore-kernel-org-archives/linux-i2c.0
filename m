From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [Patch V8] i2c: imx: add runtime pm support to improve the
 performance
Date: Sat, 10 Oct 2015 08:30:21 +0100
Message-ID: <20151010073020.GB1619@katana>
References: <1442569869-10584-1-git-send-email-b54642@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aVD9QWMuhilNxW9f"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:57209 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751260AbbJJHaf (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sat, 10 Oct 2015 03:30:35 -0400
Content-Disposition: inline
In-Reply-To: <1442569869-10584-1-git-send-email-b54642@freescale.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Gao Pan <b54642@freescale.com>
Cc: linux-i2c@vger.kernel.org, B20596@freescale.com, b38611@freescale.com, u.kleine-koenig@pengutronix.de, kernel@pengutronix.de, hkallweit1@gmail.com, s.hauer@pengutronix.de


--aVD9QWMuhilNxW9f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2015 at 05:51:09PM +0800, Gao Pan wrote:
> In our former i2c driver, i2c clk is enabled and disabled in
> xfer function, which contributes to power saving. However,
> the clk enable process brings a busy wait delay until the core
> is stable. As a result, the performance is sacrificed.
>=20
> To weigh the power consumption and i2c bus performance, runtime
> pm is the good solution for it. The clk is enabled when a i2c
> transfer starts, and disabled after a specifically defined delay.
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

Uwe? Sascha?


--aVD9QWMuhilNxW9f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWGL6MAAoJEBQN5MwUoCm2GyoP/RVOzpr58zMeS13tTHozORSi
iJ9CRTPuSUa1hNvJ1HYakttd/mkxuGakHkVWvOMB1CKSDxH1c0+maRUngHLFCknk
W+11N+5r+NHeHrD0UGhb40cMZ5knEeIENpvNl1uD91VxjMr5jP5sQVXuMfxgmyRz
fZgRoA8WL55go2A5KYE6DW6dZDOzXR0fDPGHmWi4qw8b/tzIMrl07MMAZKH5E2sC
HIPu+lESFWfM2y7/80OX9I8kLWlKbBhb9eo79WqHi7d0k6c+MC7rD6J0ZzRNTl20
OLe4eqRubU81N2gDcfBzYuHg4klmOSrzXkVPVYWPd0kdsaT9sLl2/+RknOqg/hcQ
MY2widpOcbUxlp6Te22LkW3BWXgwR5G/wKL79OBgnSVO/jefYmujyxabcHkYW1Yk
jIUWj5334I2sai5UcARzLYKg65ne4KrwRqUqtP7rE1bKzt/Jf0/r1fFuZrOhVsK0
LEQLERbQOqiSJvvd9fLeKyRLsUSII0uTadUPdnpD+KiOiue1lAlXvpSf1ZckauNz
YR8gBYyTRxZRoQcD5jkObTJ9pO5qEwIy2Zkmjo91eq1X2U1HweBVu4f7W41f2Uoa
wxgHydZQlqihZDKuy0+sIU4FF72U9yfcvl298ItowaoUkIzxuSZdAlZ87plMtTu9
IqtUPTLQ2sGxaZmu4oub
=cJID
-----END PGP SIGNATURE-----

--aVD9QWMuhilNxW9f--
