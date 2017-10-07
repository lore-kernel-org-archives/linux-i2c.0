From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PULL REQUEST] i2c for 4.14
Date: Sat, 7 Oct 2017 10:27:14 +0200
Message-ID: <20171007082710.or56cv7lqy5ixhc3@ninjato>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mlmljnhvxkvsgqqb"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:46272 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750798AbdJGI1P (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sat, 7 Oct 2017 04:27:15 -0400
Content-Disposition: inline
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Rosin <peda@axentia.se>


--mlmljnhvxkvsgqqb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

I2C has three driver fixes for the newly introduced drivers and one ID
addition for the i801 driver.

Please pull.

Thanks,

   Wolfram


The following changes since commit 9e66317d3c92ddaab330c125dfe9d06eee268aff:

  Linux 4.14-rc3 (2017-10-01 14:54:54 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current-4.14

for you to fetch changes up to 25f2f440989c7079fdd8fccd54592cc077b63ae5:

  i2c: i2c-stm32f7: make structure stm32f7_setup static const (2017-10-05 14:44:57 +0200)

----------------------------------------------------------------
Colin Ian King (1):
      i2c: i2c-stm32f7: make structure stm32f7_setup static const

Jarkko Nikula (1):
      i2c: i801: Add support for Intel Cedar Fork

Pierre-Yves MORDRET (1):
      i2c: stm32f7: fix setup structure

Thomas Meyer (1):
      i2c: ensure termination of *_device_id tables


with much appreciated quality assurance from
----------------------------------------------------------------
Jean Delvare (1):
      (Rev.) i2c: i801: Add support for Intel Cedar Fork

 Documentation/i2c/busses/i2c-i801 |  1 +
 drivers/i2c/busses/Kconfig        |  1 +
 drivers/i2c/busses/i2c-i801.c     |  4 ++++
 drivers/i2c/busses/i2c-sprd.c     |  1 +
 drivers/i2c/busses/i2c-stm32f7.c  | 17 +++++++----------
 5 files changed, 14 insertions(+), 10 deletions(-)

--mlmljnhvxkvsgqqb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlnYj94ACgkQFA3kzBSg
KbauoA/+PC9tBr0VqO1pBkY09QKAAEltq3DCsVGl2RTptU6Plkf3I+3IsLrlEHxk
WZuwILBFmKQG6p+oCd2T3fgOEouuDebHJ420hZorCOX9C4LKCdHUmGKle77wk9RK
mKeGbLQPSpBfSjYTKn495GFjRvRkG5i+yS89BFq4jX+1g+ACQ2CKGsyuJRDpipe0
0GgGSDNOozPDs4g870ktOWhJUzr7H4KIntijkUQoCOiGU/4tTsxzBBwaDkWFgRw2
nzFK0bdxn4CMT7ZFKvTqr5Ys3dstAasQBpUmPxD857NE0IhcOLv7vCJECbgLFJuV
K2y7zFIbBfMirc3TU/E29kYVC2tOb7U1CgGccnRRxx2XHF1cS9bhtcdTqAyw91Tn
CdIwjMqJh/Bmo3Hb/k2YV1zMjRG/JGTClZv0lWLPHIsxIMczISm7g5PHxr7Sl3m+
pH9WTDQHFW7kqu0lU5OwuAMtEYVCjqlVl2ARI6+ziITqxQ4DfE0jevCHGUyLQrEj
nIflIlD993EbjufH9KEe0oMI4PP5uONK/VCjmynAah402U4Aa5KGSeUEA23twyGm
zSrWgcNG2M+RndL9hJtNc/c5MVrGLk2qZoqxpKRfSgtiQ6PnTCTuLA6otLQRHGBq
9AqVc1FDYdsQ5ydbEYwuW3T1u5pD6ejFhlqf0WloI4NOdy9Wptw=
=bB3Q
-----END PGP SIGNATURE-----

--mlmljnhvxkvsgqqb--
