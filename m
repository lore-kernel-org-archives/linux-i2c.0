From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [Patch V1] i2c: imx: improve code readability
Date: Sun, 3 Jan 2016 19:17:53 +0100
Message-ID: <20160103181753.GB1522@katana>
References: <1446455130-4704-1-git-send-email-b54642@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zx4FCpZtqtKETZ7O"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:55821 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751522AbcACSR5 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sun, 3 Jan 2016 13:17:57 -0500
Content-Disposition: inline
In-Reply-To: <1446455130-4704-1-git-send-email-b54642@freescale.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Gao Pan <b54642@freescale.com>
Cc: u.kleine-koenig@pengutronix.de, linux-i2c@vger.kernel.org, B20596@freescale.com, b38611@freescale.com


--zx4FCpZtqtKETZ7O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 02, 2015 at 05:05:30PM +0800, Gao Pan wrote:
> Replace of_get_named_gpio_flags with of_get_named_gpio because
> the latter has less parameters, which improves code readability.
>=20
> Signed-off-by: Fugang Duan <B38611@freescale.com>
> Signed-off-by: Gao Pan <b54642@freescale.com>

Applied to for-next, thanks!


--zx4FCpZtqtKETZ7O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWiWXRAAoJEBQN5MwUoCm2uY8P/A0Tu0PKDXqmYejBUYWRPrvP
f0KeTBt6BJMj+vxGf7juAmd99WabI5QP136tBp4q8VCePayzhSQiTpjkZMTlSNyF
B71MYtex6C4xKGSFFdld1XDl2sP0Xcxni2m3CxM3VVO4fU1Q7VV4w6aAmj4wTwwO
zbuZTs8aRltwNRYdFT4k4DA01HHfVERVLKkhqtAfx+wMNePTerBgYocSa+BL0csp
wyHNRU/yeHaRqvAMJBvtVyLqJZYCyfjPWP/zt7ADlWRJt3XT4PoNA9ij3MUGnxSF
yhImVawLfDYQ3SO20Qn1axCuyCCAtY8acXF2+fNhsirpb2+/jXbPgK5whDfYf/de
azny+z0oGMFQNtF7ZEioTuMZ6RgEJXHH2QkXzDld3g9e2Ccp0dDWRF6G/TIHr5r6
MzIEukQyyW3Smj6J4+5AadJeDBTHZVLj8raCUhF7D56V2kOPVmZMweUoDkdxQheh
PrA6wgU78Wf/KNHbHf20tyayqf7L5vdJQmvRc/TPafGCmZndwim1pwLtdZKjJ0PH
SnThPOH7J2UmmkvsvTCB0TL6JxMObnl0X78Sy65H0qLG4JCBDSqTFTu52fxMmFBV
AdvniRMyirxv20K2HrZgzq4BohABjebr21ygMi6CE71MK0xAWXpvX/xx2jJ9r+Fc
XusL+4RaVrA4+WHuUAmr
=OQMn
-----END PGP SIGNATURE-----

--zx4FCpZtqtKETZ7O--
