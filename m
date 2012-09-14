From: Wolfram Sang <w.sang@pengutronix.de>
Subject: [PULL REQUEST] i2c-embedded for 3.6
Date: Fri, 14 Sep 2012 15:31:13 +0200
Message-ID: <20120914133113.GA14733@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Jean Delvare <khali@linux-fr.org>, Ben Dooks <ben-linux@fluff.org>
List-Id: linux-i2c@vger.kernel.org


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Linus,

please pull the last bunch of (typical) i2c-embedded driver fixes for 3.6.
Also update the MAINTAINERS file to point to my tree since people keep
asking where to find their patches.

Thanks,

   Wolfram

The following changes since commit 55d512e245bc7699a8800e23df1a24195dd08217:

  Linux 3.6-rc5 (2012-09-08 16:43:45 -0700)

are available in the git repository at:

  git://git.pengutronix.de/git/wsa/linux.git i2c-embedded/for-current

for you to fetch changes up to 5f71a3ef3753ac2068009637eee619e163f44b30:

  i2c: algo: pca: Fix mode selection for PCA9665 (2012-09-14 15:25:22 +0200)

----------------------------------------------------------------
Roland Stigge (2):
      i2c: pnx: Fix bit definitions
      i2c: pnx: Fix read transactions of >=3D 2 bytes

Thomas Kavanagh (1):
      i2c: algo: pca: Fix mode selection for PCA9665

Wolfram Sang (2):
      i2c: mxs: correctly setup speed for non devicetree
      MAINTAINERS: fix tree for current i2c-embedded development

 MAINTAINERS                      |    2 +-
 drivers/i2c/algos/i2c-algo-pca.c |    6 ++---
 drivers/i2c/busses/i2c-mxs.c     |   13 +++++-----
 drivers/i2c/busses/i2c-pnx.c     |   53 ++++++++++++++++++++++------------=
----
 include/linux/i2c-pnx.h          |    1 +
 5 files changed, 42 insertions(+), 33 deletions(-)

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlBTMaEACgkQD27XaX1/VRtR5ACgxBC+/ASA1LraCvH5nL6suXWN
ekMAn1j0lVe1ccYpxZCEjABd5H8zCGMc
=p6VP
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--
