From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PULL REQUEST] i2c for 4.12
Date: Sun, 18 Jun 2017 14:58:35 +0200
Message-ID: <20170618125831.2fjzqgk4r6lqqm32@ninjato>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="q4aio54krzaz5uvt"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:48963 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751965AbdFRM6h (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sun, 18 Jun 2017 08:58:37 -0400
Content-Disposition: inline
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org


--q4aio54krzaz5uvt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

here is a pull request from I2C containing two driver bugfixes. Sorry
for the Sunday pull request. I forgot to send it out on Friday.

Thanks,

   Wolfram


The following changes since commit 32c1431eea4881a6b17bd7c639315010aeefa452:

  Linux 4.12-rc5 (2017-06-11 16:48:20 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current-fixed

for you to fetch changes up to 17e83549e199d89aace7788a9f11c108671eecf5:

  i2c: ismt: fix wrong device address when unmap the data buffer (2017-06-15 16:07:03 +0200)

----------------------------------------------------------------
Liwei Song (1):
      i2c: ismt: fix wrong device address when unmap the data buffer

Wolfram Sang (1):
      i2c: rcar: use correct length when unmapping DMA

 drivers/i2c/busses/i2c-ismt.c | 2 +-
 drivers/i2c/busses/i2c-rcar.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--q4aio54krzaz5uvt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAllGePEACgkQFA3kzBSg
KbaqqhAAjanLHLA0xcT/5Lx+z/PBiX/LpujiIQBtSJRKTRpZbPBFFHEGtVI4VLqO
SUk3dpXK0MCTvoS7nOmm7aut8HOC5e5GX8WFb1FlVJLLugo79iK5FMqmoWuSCHMW
XvUQ1A5XwmqV9NIZsyo45VLtlxsx181DyogqlvmPwdk1jcxPuQ4GokJYCQjUXQy5
L305pmF/uhPupU9KITfZsowSVffDmV6uH7kWExDJj+CsCNlp+lc5pusxya1xa61Z
3LQ2dKiYpM1leSxAAYpk5bRUZJEvnjEcAhoVcea1qhRSSzjnc4zqSNWc6lPCPtpB
fPNJBxO48BCzF49DFWM3n6uLWXBbesPR6sh/0zY0OLTrKnlQu/zoSF2MXNF9dwsy
nFi6VR+wYg5P/+GwhBPInY1DqzgdTQ9igfqFVUyKLU1lShqF73F98rJFIe2wDa4i
Y9GvpP3SFyWpBpQMm0B5wHDaaBTMi4UZppPShPZQFHsP+vdlQlFSB/sPe0xaUFdf
AZij7MdIs+fFqavQBO85YjIz48SSVSqQIO2SE+h5l6tTRMQez0bVflG0nqFDIUWE
ceLs/2Yroyc+U+BTMlz8ijuj47C/UHyDk7lizc+lC7WbokY8uDfP82PvUg4uF/ln
BZSq806eBSl/DO6d3ZpTKp+A8EIFxMe2IZA0HAqc70vntCoEOII=
=tYzk
-----END PGP SIGNATURE-----

--q4aio54krzaz5uvt--
