From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PULL REQUEST] i2c for mfd for 4.4
Date: Mon, 26 Oct 2015 15:38:06 +0100
Message-ID: <20151026143802.GA6946@katana>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:51821 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753640AbbJZOiQ (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 26 Oct 2015 10:38:16 -0400
Content-Disposition: inline
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Lee,

these are the MFD patches I picked up via I2C. Tagged as
quark-for-mfd-151026.

Thanks,

   Wolfram


The following changes since commit 049e6dde7e57f0054fdc49102e7ef4830c698b46:

  Linux 4.3-rc4 (2015-10-04 16:57:17 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/quark-for-mfd

for you to fetch changes up to 40d8edc9bf056ea83e50152a4ccd33048d26ccde:

  at24: enable ACPI device found on Galileo Gen2 (2015-10-26 15:25:56 +0100)

----------------------------------------------------------------
Andy Shevchenko (4):
      mfd: core: redo ACPI matching of the children devices
      mfd: intel_quark_i2c_gpio: load gpio driver first
      mfd: intel_quark_i2c_gpio: support devices behind i2c bus
      at24: enable ACPI device found on Galileo Gen2

 Documentation/acpi/enumeration.txt | 11 +++++---
 drivers/mfd/intel_quark_i2c_gpio.c | 33 ++++++++++++++++--------
 drivers/mfd/mfd-core.c             | 52 ++++++++++++++++++++++++++------------
 drivers/misc/eeprom/at24.c         | 22 +++++++++++++---
 include/linux/mfd/core.h           | 10 ++++++--
 5 files changed, 94 insertions(+), 34 deletions(-)

--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWLjrKAAoJEBQN5MwUoCm2s08QAKNmxr3+MdxkJedRGqP4f8q2
zqZ2Xnsc6QmrpwfUqF+xqlIp6jVyLWEeMohtxolm06uQhXEANdXq2ZqVzYKhR+VG
niulFKn8JP0nQPy54MX0pNUdVXIfPQx7zULHUxF+uUveigavNmzAM2ZlN8XZM0DC
pVxK1Xfrc18kDUzHxjNXArWHfDCHKVaJBUBrX3e5y5DYKpSI7ziK5EAp5zV8pSGU
gm+wH44Px5Yb/4DlrjJc/i81UOIFSeTE03gLqlgcT1Wbt7QtDmDoqZUp2VFs+A9u
RsWYokCWEDoqvwnGHNikMLUOWBOfuyGVW9IZt8hiOl97HiJFSrWNxNUBMi58+WT+
6LintSVhkdqjkGOoAZ0gXUsj3mzC5UL3wON0AORSSN5tAkklf8Ol3SQptzhx1iGm
/IQhpMvD/Xn1NIqS7RMBT88/ZMq5Fmcdr3TQ1A6OSpB/WuDQqeSydFhmnKculd2Z
dVY8zYD8nhAGDciu+KwPddFJuFnkT3/RRQLSNw1EybT2z/CNiseEJFrCt/6b8B1W
6GLwX6sFGvDr6t10+E/7t333ybLwLTJDS072ayFRT4BAhrOunMpFz+uhwGvMLp8W
HgCLT8qnng12bo0WHiIhXQ2rOaWkJOUjLq0sIpxs7nMFt1xg8BnXsO62NUHCu6H7
71pL9kX8rqRhBj0pbYaa
=9yPt
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
