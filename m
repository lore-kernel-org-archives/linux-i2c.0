From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PULL REQUEST] i2c for 4.9
Date: Sat, 5 Nov 2016 23:16:49 +0100
Message-ID: <20161105221646.GA22098@katana>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:43107 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750823AbcKEWQ6 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sat, 5 Nov 2016 18:16:58 -0400
Content-Disposition: inline
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

here is a bugfix for the I2C core fixing a (rare) race condition.

Please pull.

Thanks,

   Wolfram


The following changes since commit a909d3e636995ba7c349e2ca5dbb528154d4ac30:

  Linux 4.9-rc3 (2016-10-29 13:52:02 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current

for you to fetch changes up to 147b36d5b70c083cc76770c47d60b347e8eaf231:

  i2c: core: fix NULL pointer dereference under race condition (2016-11-04 20:36:58 +0100)

----------------------------------------------------------------
Vladimir Zapolskiy (1):
      i2c: core: fix NULL pointer dereference under race condition

 drivers/i2c/i2c-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYHlpOAAoJEBQN5MwUoCm2HOkP/3t8VZE6WboZ1MngGI0KiqAL
QzaOGzYsImBCsqscfLO+TosDtabkpw0wI79Xw+EOVSme0wDCjRVjmSBgdh0jDW6p
DFxEY1oK44R5hMCXeUvqFQQBMm5QQPfZcTpu8o4cuxY9cZNqiE0m/0pq/v1JOOPg
Ykm1XBzwWqNN82XI83YVL+vr1/pjjSaC+xerD0X7mcMyi5amESTbuwf3Zea94V7I
XQx2RLSOE8OeKRyiyQGT78ZWcYEkqfBtd4Tvr3SB8IqNTbJs1BeWnOFQIVGUZRz9
CnFWjOBh0ZBTIelSFR/bdwBdMzanSDM3YwAtvRMiVZZFCNrfn70siwlxzSS6D7Ri
xAaJ1G7ZJH0acaawZRYMhzPEGLQHJzO4A3iw/18oWAL0nUpvWFNOa8Ga65NiTqB1
EryrwFgWeZrsdbXJ8pLpenfzoU2f5EczhzN36OP7Fo4x8JFBe5rufD9U1XEZd9p/
wac0boI99y96Q/nR4avi20kmHVfBl1+g57OnwfS77hnKiHlWPwY0G9er0gfZ5isP
NX7sYCK7zrcXnhWFiD9PvqAKw2415I+PFl6kjiKgfUTS+Qz43DkK2hqiGJyego/i
XlN5RT6mrA3xWIIFSJtasZjMzCojwg3rPEMPTmEpnFB9SsKhwgxyIk4y4heblJwm
kY68OX5n0CPr+/KUc8mA
=Q4nd
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
