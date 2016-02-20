From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PULL REQUEST] i2c for 4.5
Date: Sat, 20 Feb 2016 23:12:36 +0100
Message-ID: <20160220221232.GA1808@katana>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:54299 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759529AbcBTWMm (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sat, 20 Feb 2016 17:12:42 -0500
Content-Disposition: inline
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

some bugfixes from I2C for you:

A fix for a RuntimePM regression with OMAP, a fix to enable TCO for
Lewisburg platforms, and a typo fix while we are here.

Please pull. Thanks,

   Wolfram


The following changes since commit 388f7b1d6e8ca06762e2454d28d6c3c55ad0fe95:

  Linux 4.5-rc3 (2016-02-07 15:38:30 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current

for you to fetch changes up to 1a1503c5396eb7f2edf4b8ef6067853014478c0c:

  i2c: i801: Adding Intel Lewisburg support for iTCO (2016-02-18 13:18:48 +0100)

----------------------------------------------------------------
Alexandra Yates (1):
      i2c: i801: Adding Intel Lewisburg support for iTCO

Masahiro Yamada (1):
      i2c: uniphier: fix typos in error messages

Tony Lindgren (1):
      i2c: omap: Fix PM regression with deferred probe for pm_runtime_reinit

 drivers/i2c/busses/i2c-i801.c       | 2 ++
 drivers/i2c/busses/i2c-omap.c       | 4 +++-
 drivers/i2c/busses/i2c-uniphier-f.c | 2 +-
 drivers/i2c/busses/i2c-uniphier.c   | 2 +-
 4 files changed, 7 insertions(+), 3 deletions(-)

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWyOTQAAoJEBQN5MwUoCm2mC4P/07aTKffUa9pMt3FGyIuyxHm
5By/rPpDrZ7qnB/HWvS10CFqnL7U7ut/HsxIUTrFtQtipvVoIPtcBM4M7bw++cEW
B8qf771rLLdGEkdnJm8GSm6Sd/D+pputig3I0pUyOApW3n/LA8cwxR7RP0FIlwzH
87TP7+pAYSl3kOA9YCcOwqFPF2dsaT0bK4IYdbxmcAgJaWYHUJSRjNr0oQxSqnEU
NY+vIKgX3YY1O8EvCNcQchOefSjtTnxV4sYE2jCIeJQnIJ/vgbWcAhUs+XKn7ONC
9pzBSvh+0MbFiE5bXO/Nbz9TCMl2PZeR0/G3o5nr7Sus53JyVs+3hX2PHZhbqxMm
L9KSQyXeRoFjV5bpYLWZljVzM6oMzSK3XxH5jZPULZqSyBGhnvfaHe7RxVbmNArY
Zkyznyhvq0JeLdwChNduicaoQYmnfnaln07/2viCjhHDnWDnFn1R559nE63erFib
f8Rrys+On5sVeQwxWo9BLdEV6G6BRntbnWIbKHExwMIpCANkrWK7F8fcgJnsoTPu
Z8X5AIHIB6nPf/qNSZlbQTRqO9agDCgxDl+Y/AncTBmo60/gLU7dqoL+z0yxjazx
73sY0P/Y/a1IkdQuWQytMMefCa0e55vgy6A1c4YJsLDsob10uxJFZsq5/QeFhNr6
HYNIk0Zj/2Vc71VPgRq3
=DGfc
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
