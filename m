From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PULL REQUEST] i2c for 4.9
Date: Thu, 27 Oct 2016 15:08:42 +0200
Message-ID: <20161027130838.GA2462@tetsubishi>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ibTvN161/egqYuK8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:32831 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965141AbcJ0OCC (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 27 Oct 2016 10:02:02 -0400
Content-Disposition: inline
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

I2C has some driver bugfixes, module autoload fixes, and driver
enablement on some architectures for you.

Please pull.

Thanks,

   Wolfram


The following changes since commit 07d9a380680d1c0eb51ef87ff2eab5c994949e69:

  Linux 4.9-rc2 (2016-10-23 17:10:14 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current

for you to fetch changes up to 533169d164c6b4c8571d0d48779f6ff6be593d72:

  i2c: imx: defer probe if bus recovery GPIOs are not ready (2016-10-25 12:15:00 +0200)

----------------------------------------------------------------
David Wu (1):
      i2c: rk3x: Give the tuning value 0 during rk3x_i2c_v0_calc_timings

Greg Ungerer (1):
      i2c: allow configuration of imx driver for ColdFire architecture

Hoan Tran (1):
      i2c: xgene: Avoid dma_buffer overrun

Jarkko Nikula (1):
      i2c: designware: Avoid aborted transfers with fast reacting I2C slaves

Javier Martinez Canillas (4):
      i2c: jz4780: Fix module autoload
      i2c: xlp9xx: Fix module autoload
      i2c: xlr: Fix module autoload for OF registration
      i2c: digicolor: Fix module autoload

Jean Delvare (1):
      i2c: i801: Fix I2C Block Read on 8-Series/C220 and later

Ralf Ramsauer (1):
      i2c: mark device nodes only in case of successful instantiation

Ruqiang Ju (1):
      i2c: hix5hd2: allow build with ARCH_HISI

Stefan Agner (1):
      i2c: imx: defer probe if bus recovery GPIOs are not ready

 drivers/i2c/busses/Kconfig               | 12 ++++++------
 drivers/i2c/busses/i2c-designware-core.c | 17 ++++++++++++++---
 drivers/i2c/busses/i2c-digicolor.c       |  1 +
 drivers/i2c/busses/i2c-i801.c            | 16 +++++++++++++---
 drivers/i2c/busses/i2c-imx.c             | 11 +++++++----
 drivers/i2c/busses/i2c-jz4780.c          |  1 +
 drivers/i2c/busses/i2c-rk3x.c            |  2 ++
 drivers/i2c/busses/i2c-xgene-slimpro.c   |  2 +-
 drivers/i2c/busses/i2c-xlp9xx.c          |  1 +
 drivers/i2c/busses/i2c-xlr.c             |  1 +
 drivers/i2c/i2c-core.c                   | 11 ++++++++++-
 11 files changed, 57 insertions(+), 18 deletions(-)

--ibTvN161/egqYuK8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYEfxVAAoJEBQN5MwUoCm22aUQAKBfcrEqS+RvbK1vNsO5YbNW
TuUxuUILxYM+ev0J+9I+k5vB9b6xD9Y3RVQ4KzwRr/UXI7m08R96ATqUnYSMbOP8
KJ8D9yH8Ch2Zdq1Qudz4ln53bbHPY8ZEyE55sDfRrLgLPCFIBwXUmeWc4nGr9oiy
1NjB9W5C2zFRLsHZbM4Pwl1EEQThYXGLj35f4mzGkwsv2cGDYAxmT9C8zCDiNU3l
ZXVvPahpffgRHaU6khmYyY2wtaUOiciUOsDhK9bk6JSadpzgNDXr4DOp5U/Ehqut
6r07veEktnWAIlDnibz8nPLT2A00XMR5DKdtB1HTCbOA4KbsQI3d2B4ADr3OUone
tXIyBtHigIUjv518wPFwxl5HON8uhCE/WAArjCwWPlZIzJ+unbg0qxyDzv9vyTSz
P/BJEg2Z4QnSr07ZFEnEtvseg4mbaA+X2Cj/epUB0Gm0Z+Q3DZzMHFD/t8H9ee5h
5kssWq2J07bAoe5Qwy1g9c/ZTrQ4PasP56QU8EOYLeddFNxAZ7/iN8eQHhXAE49H
FBrW+obYhNupSP0Y9adhzE7MsoJ22zjqnCn28LRt6a7UmYgiqULAQI9rJ0+l7vxf
HC0rLOPXiuuzDtggzQKL+eR4l4Xtd0kOQk35lb3bFuq1HyQIYnip6J52SdlKyE1H
BHLG55NSG2WuyarHOw2P
=i7Au
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--
