From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PULL REQUEST] i2c for 4.6
Date: Sun, 10 Apr 2016 09:31:38 +0200
Message-ID: <20160410073134.GA1778@katana>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:43581 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751547AbcDJHbr (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sun, 10 Apr 2016 03:31:47 -0400
Content-Disposition: inline
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

some bugfixes from I2C:

* fix a uevent triggered boot problem by removing a useless debug print
* fix sysfs-attributes of the new i2c-demux-pinctrl driver to follow
  standard kernel behaviour
* fix a potential division-by-zero error (needed two takes)

Please pull.

   Wolfram


The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

  Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current

for you to fetch changes up to caf280800aaf73f0796d1bb3fa0f6576c8222258:

  i2c: jz4780: really prevent potential division by zero (2016-04-09 08:36:44 +0200)

----------------------------------------------------------------
Ben Hutchings (1):
      i2c: mux: demux-pinctrl: Clean up sysfs attributes

Wolfram Sang (5):
      i2c: prevent endless uevent loop with CONFIG_I2C_DEBUG_CORE
      i2c: mux: demux-pinctrl: Update docs to new sysfs-attributes
      i2c: jz4780: prevent potential division by zero
      Revert "i2c: jz4780: prevent potential division by zero"
      i2c: jz4780: really prevent potential division by zero

 .../ABI/testing/sysfs-platform-i2c-demux-pinctrl   | 29 +++++++---------
 drivers/i2c/busses/i2c-jz4780.c                    |  7 +++-
 drivers/i2c/i2c-core.c                             | 10 ++----
 drivers/i2c/muxes/i2c-demux-pinctrl.c              | 39 ++++++++++++++++------
 4 files changed, 49 insertions(+), 36 deletions(-)

--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXCgFWAAoJEBQN5MwUoCm2q88QAKHodu/Of/EWZk7yVV2rprLo
GTE0km01eouXoFGP+pGVTZNnb8Gq2t0ZMVHAzcJQxg13C0YiUh+kzPaH4YXgg1oL
aa4YLKH+9TOQCok8/Xhe0GXxiaROz6FMsGLYFudpAXDF45xqFaAJbR6Oy/zRfkPb
06SNjvyG9fQnIF35h+dW7Qq6nLAhG5ccPS1T8258uLZTUibBkKR4T3cscOmJhkvm
hPBXh/gxxk+BfhLlpUfn5jt3mHGZckJWVNcpurTFlMFtzwsuE9PXIUNwl0WXj8BV
p+jsDxqGS7T3gIf9DFb6S4le7sryJZl/oaYsuc9qE0mN/B+KMuYvTIvMgO9P6fKb
BYw12Ly60SJEgod5PYMmyRXQbiDS9kwmKdcbYLNNSh/Wz/vLoCEkGPI9QzaiWsF+
RrpwQVi4ontG3liM5tAQNE4EDFVodw78OygjYPIHkGaZp86RjAQ+s4m6bw9pJlyd
Gf1WyBn0wyWkv1iYpXD7gZHO14LKNnMrO8heyseULaxHpG0jMm/A4uaybLmrRGlS
GctHT3GquXf83kSrrEYkpSZxoA4X+lO+6OjtyP46jSmOYZ4Gerd5ksE4PCsKr47D
RT1gACrPz3+jhWRjWKkMEHKeVRPVd9rVEtASerDeU5s4wKwRUO91T47WQsDoZkxJ
BuyPSqtmQkKCmgw2Fprr
=ELZ4
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--
