From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PULL REQUEST] i2c for 4.3
Date: Sun, 25 Oct 2015 08:40:47 +0100
Message-ID: <20151025074043.GA2129@katana>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:44515 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751241AbbJYHkx (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sun, 25 Oct 2015 03:40:53 -0400
Content-Disposition: inline
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

here are two driver bugfixes for the I2C subsystem. Please pull.

Thanks,

   Wolfram


The following changes since commit 7379047d5585187d1288486d4627873170d0005a:

  Linux 4.3-rc6 (2015-10-18 16:08:42 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current

for you to fetch changes up to 5dd32eae604ee503e5a84a4f18d1381e4cc356cb:

  i2c: pnx: fix runtime warnings caused by enabling unprepared clock (2015-10-23 22:26:28 +0200)

----------------------------------------------------------------
Hezi Shahmoon (1):
      i2c: mv64xxx: really allow I2C offloading

Vladimir Zapolskiy (1):
      i2c: pnx: fix runtime warnings caused by enabling unprepared clock

 drivers/i2c/busses/i2c-mv64xxx.c |  2 --
 drivers/i2c/busses/i2c-pnx.c     | 10 +++++-----
 2 files changed, 5 insertions(+), 7 deletions(-)

--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWLId6AAoJEBQN5MwUoCm2r/AP/2pQK3PnFVcol1N4fzdX7Sd0
4ytAXPEnlFUUPNmYe0IKzN/1eU14giHqhNLJkEorrIvvGpHlQ841efr17dTU7P43
vXILpqM6e5wECL6TiXxuq/LXlSybkzTnWAvZLxZVLnPJWb2Hwv1Vscigt1pyYTYd
EAOTSXvkrRRrHCLC98NSf6fEfndSgZIcFEdUTnmiTBteibWHfAJ53OB7ZiDZuloD
DiYBAYxbWNG9c/c1UzcN0QG+qLGY/8UqOcGLnMGiQpfINI8K3ct2etwcEDN6HbVU
DHMEM6rozBt1tMUHgMoCVIIb6JED4JPZ8W0M0ziFxVSQLSnFg30sUyTW8WYmSYxc
ZbvAkOd3odsKHtoEEWhgYS9EjvQelgy33g4+ssMgboklo4uXH2xNPBziea2os7pI
omLNbI/dgxd6UjCUdB+WRMZ/b7OmvxfDQ4PM6DAJE5LzwmzahM7Hf5LvTpmxn8f0
KKf/619xqzReh/QP2nKywgVTsxtBrhz7GNyA/KqoMrwfDRaxuPO2GjHHB2dudsAd
DMrYOweW9MnF3UgBQ7DEJHeJN4X6WzpkhAvwEUtfctrVRPIt3oc6dWQS9DwfZU3y
toffX+EYViu5mTLkeTBtVjqhmimILZaFTigdY9D2Ua/7uzmEClnCzxCoPU/H/waq
3A8lPN67eQJqlNLRAvR5
=bqul
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--
