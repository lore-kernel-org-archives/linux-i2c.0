From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PULL REQUEST] i2c for v4.7
Date: Thu, 14 Jul 2016 21:17:36 +0900
Message-ID: <20160714121729.GA4426@tetsubishi>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:60863 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751001AbcGNMRs (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 14 Jul 2016 08:17:48 -0400
Content-Disposition: inline
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

I thought I sent you this pull request last week already, but it seems
this travelling to Japan made me mix things up sadly.

Please pull these 4 driver bugfixes for the I2C subsystem.

Thanks,

   Wolfram


The following changes since commit 5edb56491d4812c42175980759da53388e5d86f5:

  Linux 4.7-rc3 (2016-06-12 07:20:35 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current

for you to fetch changes up to 22ebf00eb56fe77922de8138aa9af9996582c2b3:

  i2c: mux: reg: wrong condition checked for of_address_to_resource return value (2016-07-06 00:33:49 +0900)

----------------------------------------------------------------
Jon Hunter (1):
      i2c: tegra: Correct error path in probe

Luis R. Rodriguez (1):
      i2c: remove __init from i2c_register_board_info()

Lukasz Gemborowski (1):
      i2c: mux: reg: wrong condition checked for of_address_to_resource return value

Sricharan R (1):
      i2c: qup: Fix wrong value of index variable

 drivers/i2c/busses/i2c-qup.c    | 2 ++
 drivers/i2c/busses/i2c-tegra.c  | 2 +-
 drivers/i2c/i2c-boardinfo.c     | 4 +---
 drivers/i2c/muxes/i2c-mux-reg.c | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXh4LYAAoJEBQN5MwUoCm2LCAP/RDPhhGEogdcoLFvu8qlpxLl
awcUXRj3mKu6xuF7l5o5F5L0nn2GUSYA9w4nGhGTs4G9PcVOaaM0HpXYDPtp2f3D
QOSqR9XWq6ALZfPk28XDNPGWCGN0QHZgb/n2RZZ/REgXD2Z/IA234+76lU54UEzN
0W9IRxbfwFtXI/urfD2hgTr9kPsg7uZ48Y/5hq6RFEde83lG3lvswcMeOY8uBAFz
J6WZq9ase4IGa3WAeyK5200BVHXSN0gwqqelmZuTbtdB3BHkWr5GYR3C3A7SqKCJ
e9/nDO2ztQXAw9g0CmRiySf64dF5Y5UQ8zUFKQhWsg5gY/DhPWgooyTd5df4KBsV
VZVyKbDZLzH0JQqlY69OhDSAsL7hsTtpFDZVhpdoM43+EB2+a21wn12OydMi4ttY
gpWFw08kdvHPk5na4fxNMiIBY4/3w4sLBVf3x0EadhnsO7SxewWcUYMoVzzr2qeB
/hVthmr5IV5gEEJ3AENDRh7SBkNwykAcpAgBmMm6B1VqjgZh0WqjmtZ9HpUcw++y
bZzzkGmBFvIfuMO78D42UgjhKKx/UyMkItzc3awH5VikDrZ+4j5nVBjuFMLAOjhh
qSBiL8rTW5Y2Xbp4bOVcOupvNdQstOKhVVyNsXadgxi7g8GCRtUJCRlBcsSR66+7
Pd5NvM18DyMH+nPp+QWQ
=UczD
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
