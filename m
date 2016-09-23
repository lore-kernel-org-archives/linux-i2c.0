From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PULL REQUEST] i2c for 4.8
Date: Sat, 24 Sep 2016 01:36:31 +0200
Message-ID: <20160923233627.GA6259@katana>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:56117 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751021AbcIWXgh (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 23 Sep 2016 19:36:37 -0400
Content-Disposition: inline
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

I2C has 3 driver bugfixes for you, fixing uninitialized memory pointers
(eg20t), pm/clock imbalance (qup), and a wrongly set cached variable
(pc954x). Please pull.

Thanks,

   Wolfram


The following changes since commit 3be7988674ab33565700a37b210f502563d932e6:

  Linux 4.8-rc7 (2016-09-18 17:27:41 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current

for you to fetch changes up to 331dcf421c34d227784d07943eb01e4023a42b0a:

  i2c: qup: skip qup_i2c_suspend if the device is already runtime suspended (2016-09-22 20:11:14 +0200)

----------------------------------------------------------------
Peter Rosin (1):
      i2c: mux: pca954x: retry updating the mux selection on failure

Sudeep Holla (1):
      i2c: qup: skip qup_i2c_suspend if the device is already runtime suspended

Yadi.hu (1):
      i2c-eg20t: fix race between i2c init and interrupt enable

 drivers/i2c/busses/i2c-eg20t.c      | 18 +++++++++++-------
 drivers/i2c/busses/i2c-qup.c        |  3 ++-
 drivers/i2c/muxes/i2c-mux-pca954x.c |  2 +-
 3 files changed, 14 insertions(+), 9 deletions(-)

--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX5bx7AAoJEBQN5MwUoCm2itMP/Rbut19AQbgcFM/4sDDtO835
tQZ0ByEY+bw9L0U18RoM+nPKLNlhO+f4rCv+bdRmDoZ/4CXSnxRpvx8bU3BDJKA5
9E4Unq1T9xV0N/gcSEdeRmwRKgcwMUQHNTYVwKRe5SOGS/yFxF05uCDmulkwOjWi
Ye7KAfmtVC6TuNwkuEJixFzCIKhRaVXuA42KyApnnBp1UFXtnMUdQ1fbFN3uPuq3
Dkpjgqd/G/eM9H0iAl/5UT69S/LYow3Q2QZFtAES+QgtRHFToJp8+4vxo2VTfSfE
lsiDt1uo0f+wnwhaD4ZLw3yPoQDg89Ep38CNXp4QWI8yi/v+oz/Pt/rfwLB8Ymxs
ebY1k07bLr86GvIENvsHMYxxsReppOmqU/zCQF2Y8ZB0FuN0zqY1Ug9HGtrumwNQ
JJljeyoemsifvxwZwk4AGdvP/+WTw5caGYDkxHSuiLIbYYjLrT3MmzabBjx4rGmT
mlEDRfqylCs6q24sOeFMDmGKIAxwhm4JBzJooDErx37sH+5aNOkfH3Sbfey1cvzR
BHTsoNpYr7+PjsedChM4UJkpOBFlZRAAasa9OvpJayvOuTSUPxANpRTT1BwwZlnT
o5m7lLftxJSn6FNYg6vQ2dLubNEVfq06pBiC2UQ2LoAT4q8BmjeOf2y+E0SWW3ba
VrAtyN4sg/RABoZZ30oL
=a78V
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--
