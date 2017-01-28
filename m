From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PULL REQUEST] i2c for 4.10
Date: Sat, 28 Jan 2017 22:55:56 +0100
Message-ID: <20170128215552.b2rufdbmi6bnuzxj@ninjato>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="23l32zkf7zfoss3j"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:60419 "EHLO pokefinder.org"
        rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1752114AbdA1Vz6 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sat, 28 Jan 2017 16:55:58 -0500
Content-Disposition: inline
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org


--23l32zkf7zfoss3j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

here are two I2C driver bugfixes. The "VLLS mode support" patch should
have been entitled "reconfigure pinctrl after suspend" to make the
bugfix more clear. Sorry, I missed that, yet didn't want to rebase.

Please pull,

   Wolfram


The following changes since commit 7a308bb3016f57e5be11a677d15b821536419d36:

  Linux 4.10-rc5 (2017-01-22 12:54:15 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current

for you to fetch changes up to e13fe92bb58cf9b8f709ec18267ffc9e6ffeb016:

  i2c: imx-lpi2c: add VLLS mode support (2017-01-26 00:24:23 +0100)

----------------------------------------------------------------
Gao Pan (1):
      i2c: imx-lpi2c: add VLLS mode support

Mike Looijmans (1):
      i2c: i2c-cadence: Initialize configuration before probing devices


with much appreciated quality assurance from
----------------------------------------------------------------
Vladimir Zapolskiy (1):
      (Rev.) i2c: imx-lpi2c: add VLLS mode support

 drivers/i2c/busses/i2c-cadence.c   |  8 ++++----
 drivers/i2c/busses/i2c-imx-lpi2c.c | 20 ++++++++++++++++++++
 2 files changed, 24 insertions(+), 4 deletions(-)

--23l32zkf7zfoss3j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAliNE2MACgkQFA3kzBSg
KbaZmA//XRb1rfqgDv4AnQh5d9H8JyvxdtnqikN7n5zauxhbUqGs+nSW5w9JVRVm
9LsADCYx1d9CSbyrM81Q9TS7x7BhUShT4gJKeFo3eHhj5WHkOgmZ3gBwC7Lw4lG2
L8JzwenRiDaS8X49bto8RAxiUiYJM4DDBUMivtlpVbINmUaxsvurpmxM2oUnVF+h
Ecs4j1AaA5A6jbFmeaLb8ACuazJjEEw2XaLU0rRWTd3J6XWmeUFejkpQNYFluxsR
QcPwqJ4FjDMSk4dWe1PGinl0J08eBG+Nbjvg97hAc/4JMv+9m0StedqnmSToMI1/
P0c2+rh26GF0lYGHivfpHfFYPbf2E8hUnLKKWGKYEallEbJNpuzzoDGzrvEQm/lu
tx5wtXMzxtPx8DzdXReoiV5oWeGsRi5fjIO2oyvZxu4zkpXX9zt4qZM5CIOhk8nC
WKWPbQa/KZ6ifwC19sDB8rjMZGsH3xLXRlpDoYCaXYrNa56/jqsgi4TnKvTce2Xj
PX4YH+AYGfV8nFdSWaCJKI6bw5gdqbBBntsyigk6FfCMseY65/WM9IdxVTCndAoa
Nxv02k+vkxEIkIxyTP4xsTV3IUd+s1UbwdCgjSzfl/kA6fevfqU7TTQcxtdldQQz
pTFRur1pcKRenEhuV4xSD1PAQIYUtEa1jpOLOlatoInumJYSLnk=
=GqKh
-----END PGP SIGNATURE-----

--23l32zkf7zfoss3j--
