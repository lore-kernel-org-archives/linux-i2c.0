From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PULL REQUEST] i2c for 4.14
Date: Fri, 15 Sep 2017 14:48:17 +0200
Message-ID: <20170915124813.7l526w2s36qmiqzn@ninjato>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="liqcpqvjfxsupkw6"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:49303 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751323AbdIOMsU (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 15 Sep 2017 08:48:20 -0400
Content-Disposition: inline
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Rosin <peda@axentia.se>


--liqcpqvjfxsupkw6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

I2C has two more, new drivers: Altera FPGA and STM32F7.

Please pull.

Thanks,

   Wolfram


The following changes since commit 46c1e79fee417f151547aa46fae04ab06cb666f4:

  Merge branch 'perf-urgent-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip (2017-09-13 12:24:20 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-next

for you to fetch changes up to aeb068c57214858b638d5ee627bb4a831f98771e:

  i2c: i2c-stm32f7: add driver (2017-09-14 17:34:43 +0200)

----------------------------------------------------------------
Pierre-Yves MORDRET (3):
      dt-bindings: i2c-stm32: Document the STM32F7 I2C bindings
      i2c: i2c-stm32f4: use generic definition of speed enum
      i2c: i2c-stm32f7: add driver

Thor Thayer (2):
      dt-bindings: i2c: Add Altera I2C Controller
      i2c: altera: Add Altera I2C Controller driver


with much appreciated quality assurance from
----------------------------------------------------------------
Andy Shevchenko (1):
      (Rev.) i2c: altera: Add Altera I2C Controller driver

Ludovic BARRE (1):
      (Rev.) i2c: i2c-stm32f4: use generic definition of speed enum

 .../devicetree/bindings/i2c/i2c-altera.txt         |  39 +
 .../devicetree/bindings/i2c/i2c-stm32.txt          |  29 +-
 MAINTAINERS                                        |   5 +
 drivers/i2c/busses/Kconfig                         |  20 +
 drivers/i2c/busses/Makefile                        |   2 +
 drivers/i2c/busses/i2c-altera.c                    | 511 +++++++++++
 drivers/i2c/busses/i2c-stm32.h                     |  20 +
 drivers/i2c/busses/i2c-stm32f4.c                   |  18 +-
 drivers/i2c/busses/i2c-stm32f7.c                   | 972 +++++++++++++++++++++
 9 files changed, 1602 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-altera.txt
 create mode 100644 drivers/i2c/busses/i2c-altera.c
 create mode 100644 drivers/i2c/busses/i2c-stm32.h
 create mode 100644 drivers/i2c/busses/i2c-stm32f7.c

--liqcpqvjfxsupkw6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlm7zAkACgkQFA3kzBSg
KbY+Ug//dxsmdn+kq6F89L7DmWddZ7+s0j2ykHv4ZUvTUbU6WMhc96OeduKMJN4O
wdtndcyAiGdMaGnoTs1L816wqakmLGrJu/X1ssCIYDfndtXrnjiKKXghww4eGlYD
cWbFHFq57BcV3pZbO8otAgF0ltSXPsFrd84X4pvpG3ZeQoGxGh4bXjzHvTphT0B4
vLQaTFTD2sb/VzClloKOXlVv7314U1DIK7Xlvu6DYVVs4hEEh/C7i3+kg/bH5mMY
WetnftCAWK+moYnCsUJjbpuDKQJYcy50RUgdGj2lLjdK8kR1wtJOCb9eu4fnPxaz
QXylqMsyKalJo+UxQK8jEZUzKh0fo9iHVzUj52J0eC1fSPNJw/x79UNXjZLEY7PH
mJlbUhrInwc3xm9Hr12Oz6d5Uq1HhuRR5Mdcwe7bYcea7dbhxcuFTDytrRKiy56I
qv+JJNGswF1tqPtAtE1e8n7Vmx2BjbZi8E7KJXP2LguvevUvJq5FfPBdrxy3YP5o
BT1rrMtyVJxd6RLOrYbj0/eCUScuqnHOxx7mpCgCZhQ45VdU40/un/lB+j+XzoRO
5RLc2YTHxy/j8P3J/pevnD3kldKFM3QVH/fqCSHHH+F3Gc1DAL8L0j1rsXoEhwQX
ajtDEzjBOoOgejy6d+e30tiBJ6AXmoifda1+FlcijqygvqYR8EY=
=C6Ei
-----END PGP SIGNATURE-----

--liqcpqvjfxsupkw6--
