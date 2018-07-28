From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PULL REQUEST] i2c for 4.18
Date: Sat, 28 Jul 2018 08:55:23 +0200
Message-ID: <20180728065519.7fbb6omuknfko5ko@ninjato>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6vkeymc4ahygjzoo"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Rosin <peda@axentia.se>, Bartosz Golaszewski <brgl@bgdev.pl>
List-Id: linux-i2c@vger.kernel.org


--6vkeymc4ahygjzoo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Linus,

I2C has some driver bugfixes for you.

Please pull.

Thanks,

   Wolfram


The following changes since commit d72e90f33aa4709ebecc5005562f52335e106a60:

  Linux 4.18-rc6 (2018-07-22 14:12:20 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-curre=
nt

for you to fetch changes up to d2d0ad2aec4a8f3fd15e000ed903d6beddf39644:

  i2c: imx: use open drain for recovery GPIO (2018-07-24 14:59:12 +0200)

----------------------------------------------------------------
Alexander Sverdlin (1):
      i2c: davinci: Avoid zero value of CLKH

Esben Haabendal (1):
      i2c: imx: Fix reinit_completion() use

Wolfram Sang (2):
      i2c: rcar: handle RXDMA HW behaviour on Gen3
      i2c: imx: use open drain for recovery GPIO


with much appreciated quality assurance from
----------------------------------------------------------------
Geert Uytterhoeven (1):
      (Rev.) i2c: rcar: handle RXDMA HW behaviour on Gen3

Lucas Stach (1):
      (Rev.) i2c: imx: use open drain for recovery GPIO

Uwe Kleine-K=C3=B6nig (1):
      (Rev.) i2c: imx: Fix reinit_completion() use

 drivers/i2c/busses/i2c-davinci.c |  8 ++++--
 drivers/i2c/busses/i2c-imx.c     |  5 ++--
 drivers/i2c/busses/i2c-rcar.c    | 54 ++++++++++++++++++++++++++++++++++++=
+---
 3 files changed, 59 insertions(+), 8 deletions(-)

--6vkeymc4ahygjzoo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAltcE1IACgkQFA3kzBSg
KbbsYxAAlria6ZA4HFyFI7FS2hTjjFl8iiN9BIo67wF21b7pPp36iDXgIueQf5lO
ApCn5TcY0ocjU8F+2+dKOQfNs7MaBSVdNEpjFUY+cuiq4DyPwSQMfpEq72to5kg0
pwED6qqf35Cb1pSB7EoNc2IAVlmLa8Dy4xjKnBVyU9clnpKChrlJ/xrQfUCC1kjV
cX/3t/l28Vbpx+PT7nlHJ6u3JBUJwKPBxkW3Bv0B/8BSUZRJ0IyQjMIjjRVY8cOj
+f29mkcg34y5MPiRXhaL1SmgMh1AkMCCdXHQMxcpiiZRk9nHBxsRvYSFlFtNadDZ
ygm1/4+ZhzD7u6KI/JhsJ2pJtsEJ/pjGB8mhs2oWFzPJNikpu2oopZ0h3XFgkkZz
5bCBqvY+hQjLLyIDron4se3B8OIxkaM9t8RV+l7SUKGGTxmITBYdl4RTntE36R+V
umVyHj5eAN2NLTLhIGFswurT2VmqZNz8LvxH8sH6m352MVU+W1FS5GrleDNI7tZn
ZDFHFiIlcF7VmUrXejC6Ip/MBdgHSO8KWeRIOaxXIkvvztEY5qRze2O6XzDM10X1
Mtc6WCnIKbwFrZWMO7eNdiyTsm5jqusdVwZtHRWO3Romfz2i/eQ7bszckbQtb4/H
megNdIhcGCRnDi3EOcEk/AASvQTy2pWWujXV1OIaF47i8LzUe8A=
=6Nx6
-----END PGP SIGNATURE-----

--6vkeymc4ahygjzoo--
