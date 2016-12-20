From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PULL REQUEST] i2c for 4.10
Date: Tue, 20 Dec 2016 09:11:54 +0100
Message-ID: <20161220081151.GA2170@katana>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

seond pull request from I2C with a set of bugfixes.

Please pull.

Thanks,

   Wolfram


The following changes since commit 59331c215daf600a650e281b6e8ef3e1ed1174c2:

  Merge tag 'ceph-for-4.10-rc1' of git://github.com/ceph/ceph-client (2016-12-16 11:23:34 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current

for you to fetch changes up to 649ac63a9ae5e08b7123f2fa98c2bf42f033bdb9:

  i2c: mux: mlxcpld: fix i2c mux selection caching (2016-12-18 08:54:38 +0100)

----------------------------------------------------------------
Jan Glauber (1):
      i2c: octeon: thunderx: Limit register access retries

Peter Rosin (1):
      i2c: mux: mlxcpld: fix i2c mux selection caching

Russell King (1):
      i2c: mux: pca954x: fix i2c mux selection caching

Tin Huynh (2):
      i2c: xgene: Fix missing code of DTB support
      i2c: designware: fix wrong Tx/Rx FIFO for ACPI

 drivers/i2c/busses/i2c-designware-platdrv.c | 31 ++++++++++++++++++++++-------
 drivers/i2c/busses/i2c-octeon-core.c        |  4 +++-
 drivers/i2c/busses/i2c-octeon-core.h        | 21 ++++++++++++++-----
 drivers/i2c/busses/i2c-xgene-slimpro.c      |  1 +
 drivers/i2c/muxes/i2c-mux-mlxcpld.c         | 24 ++++++++++++----------
 drivers/i2c/muxes/i2c-mux-pca954x.c         |  5 ++++-
 6 files changed, 61 insertions(+), 25 deletions(-)

--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYWOfHAAoJEBQN5MwUoCm25CEP/0bs1qTFIFd+cekzvSIhkFyM
RYULjybux3lDTjJXYo3CXEUUP8Qt+5lbQDyOrt7oaSYyd3ncXgJiNdkNPPhw/MzU
3bvsgkuB2b710zCGptIl8F9+H/hqTbEsd21epWIBbIgeBDdNl7FTUNDhRggZtxQL
ifvTYrkYxHawVT8pxj3+zKJfYAR+TnohBKco98J5FM0H5XVePZsSaPOHWVhRKIOu
Zij08QTQEu7Ll53WeODdJAKVLD/ysdFjbcJWLXn1accZCLW0D6OrdtK1W02K1+sQ
9Xi8s35uZm3b4nQqSMQXZmDAtt3rYw1BN/2PRj5Q8CyoHU3zps2+neEDcwSLt4Y7
2oVIkWrjl9/6Q8id7HJTZ5XpsdSO5S7H+RIJuUz0vMxNrPYatMj1SEA+9+Gh5Yq9
KLJ5Zny3m/6qNOYwuncHPBhfeUgK8QgQgd/QsZQIv/Gtw1DvYiV4ckVrb0Q6Pw5c
Fms3hrOzTXoI1diWUhH9DGtqlkthRU5kDHuuU+cN32Fh9IkIhNnC7yPHWaJiTzUv
jqnYUW/11Wl836c5gQD3IT4eFJjRGV7ChJw0QPWbXFqf0vATCkTEc0QgQG0MqJV4
OgDT2kL6rAEfPUI5Xj1sF87wKoJGRZovPCe71s1w3cTPjZc2ffee8fS6dl3rQa1z
dPsscufbcs+ixC/ZffZ2
=n491
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--
