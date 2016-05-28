From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PULL REQUEST] i2c for 4.7
Date: Sat, 28 May 2016 21:06:53 +0200
Message-ID: <20160528190650.GA1869@katana>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:54049 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750742AbcE1THD (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sat, 28 May 2016 15:07:03 -0400
Content-Disposition: inline
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

here is the pull request from I2C with the fix for a regression
introduced yesterday. The regression didn't show up here locally because
I did not have PAGE_POISONING enabled. And buildbots discovered this
only after it hit your tree. Thanks to Dan for the quick response.
Really sorry about the noise!

Thanks,

   Wolfram


The following changes since commit ed2608faa0f701b1dbc65277a9e5c7ff7118bfd4:

  Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input (2016-05-27 19:14:35 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-next

for you to fetch changes up to e6be18f6d62c1d3b331ae020b76a29c2ccf6b0bf:

  i2c: dev: use after free in detach (2016-05-28 17:37:42 +0200)

----------------------------------------------------------------
Dan Carpenter (1):
      i2c: dev: use after free in detach

 drivers/i2c/i2c-dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXSexKAAoJEBQN5MwUoCm2+t4P/3TTnhFDIrJGK3UnHPfaPhuH
QF4aVTIgYndGtRhhh45Wir3HjwJlk4eYuOKwYOXhbqhFsypcKjUtwNsU1gQMhrl0
chGLvtaoiWx8vAQTjDKjU3RWwcK1hN8Vy/0hd2+3+2j6gSzzDfYc7P3fRJvbZ4kF
xnGhgN78HsseO5BtK7WwYlRp0bP79VJw1BuhR10P5FE/MRsG4NTEUu4r/F797WLZ
YeIsjQ0jSDanp7zGy9PqAgDgnrA29xvKAgneigtHMkx20o3qO7WjbDpblMogguYM
vs/FlVm+Xpft3w/sjWXTHM1U/ts9MW+ixDHEW14NoEXVEshCdtGEWRKiTUF49xzY
b/HNinDtPrr+ex6h76cdX5qpKcYjk3/qlkjeUJUaT38vtN+QQOtOuls+5YxG87Id
rJsgG+FkCzt/LMUlaw48kJCNUdJwKvjMhSaHyv+J/sSE6q5+6Nl3qFtaQHV480TK
YMTqFngoIqmYj5t8V4qdSmbx5YmrANzgknRi976coQTfAcbA6f3vkIoHOQBtRGD1
o/BSX+53PuGrTiXuB9eyhIXH6Bbtoeh3n4auBILLv4U50OznTLPFrImxQiIoq1nL
iy9AFgG+J4pmgBmewn1xxHt0SjsQkkht1igxsa6MHc0JJ6dAUcb8TIFltjRXW1rQ
A16oKKJVia86yV2/+yLi
=L17+
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--
