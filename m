From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PULL REQUEST] i2c for 4.6
Date: Wed, 27 Apr 2016 19:17:39 +0200
Message-ID: <20160427171736.GA24920@katana>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dDRMvlgZJXvWKvBx"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:57200 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752626AbcD0RRp (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 27 Apr 2016 13:17:45 -0400
Content-Disposition: inline
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

I2C has one buildfix, one ABBA deadlock fix and three simple 'add ID'
patches for you. Please pull.

Thanks,

   Wolfram


The following changes since commit bf16200689118d19de1b8d2a3c314fc21f5dc7bb:

  Linux 4.6-rc3 (2016-04-10 17:58:30 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current

for you to fetch changes up to 10ff4c5239a137abfc896ec73ef3d15a0f86a16a:

  i2c: exynos5: Fix possible ABBA deadlock by keeping I2C clock prepared (2016-04-22 15:31:54 +0200)

----------------------------------------------------------------
Javier Martinez Canillas (1):
      i2c: exynos5: Fix possible ABBA deadlock by keeping I2C clock prepared

Michael Ellerman (1):
      i2c: cpm: Fix build break due to incompatible pointer types

Mika Westerberg (1):
      i2c: ismt: Add Intel DNV PCI ID

Tanmay Jagdale (1):
      i2c: xlp9xx: add support for Broadcom Vulcan

Yakir Yang (1):
      i2c: rk3x: add support for rk3228

 Documentation/devicetree/bindings/i2c/i2c-rk3x.txt |  4 ++--
 drivers/i2c/busses/Kconfig                         |  4 ++--
 drivers/i2c/busses/i2c-cpm.c                       |  4 ++--
 drivers/i2c/busses/i2c-exynos5.c                   | 24 +++++++++++++++++-----
 drivers/i2c/busses/i2c-ismt.c                      |  2 ++
 drivers/i2c/busses/i2c-rk3x.c                      |  1 +
 6 files changed, 28 insertions(+), 11 deletions(-)

--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXIPQvAAoJEBQN5MwUoCm2fOMQAKPNP8ReF/q3lyS6iiskRAPc
h4eDQhUzyL4bkbtFP4ABcpgTFWqTwwBz4qrAgCYZjEDLoiNK2lg8wB+S5QWEfEHa
3bj55bKiHg/JIz5YuyyyD+KC4v5Dee+tq6FmYCvR77VfeLZclzMAZ2u57yfNTFGD
E9k5PvwVvzRw6jjhYGnfiFQVpUEvn2XRixkJvLcSAZOMpiujYah6+J0GvoxikjDV
SMX+4b7sq2baWgZoNnZN15F+rD5XO/87hk/fz6LicudoyKBawnMaDN+JcTvUsoEK
E2aDMAG8II13ZPrwWqS44mldqiGViPkyssvqPvCoesYEZiZMQUhIkGPdsPVlZKJM
ullhbxlEZQgpVnqhZciCn1UfVbEUQURaorlVYHzdViRYWBiYjOP4spQZinf/xdmf
3cLmnT7d7aMrR6667CVT0Vao8+zSZQoMx+0Dn6J3zcCXuTXa5+KXcmDzG6zHt51I
VF34njfBIfuy/WT2sVyeW87wpJNaBymvmWERXG/FI9d77NBMZ8kwURS/XjSoPvPw
JnI7XouUgzkmfZoQWWYIcOOoNvw1bOc6Agk93W4Q9oKnx4xfjcmDQhyu3I2L1cJX
OXPMediZmznS/MSDl19iIarUVMrMQ1BEcplEhnL0ruMv2FZy/xXWqX8G2RdDekh8
c3Yvd0El4xfDSA+dO/l4
=I396
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--
