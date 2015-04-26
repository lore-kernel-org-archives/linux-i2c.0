From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: [PULL REQUEST] i2c for 4.1
Date: Sun, 26 Apr 2015 14:40:45 +0200
Message-ID: <20150426124041.GA2803@katana>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

I2C has a mixture of merge window cleanups and bugfixes for you.
Based on your tree from 3 days ago. Please pull.

Thanks,

   Wolfram


The following changes since commit 27cf3a16b2535a490f8cf1d29a6634f1c70f7831:

  Merge branch 'upstream' of git://git.infradead.org/users/pcmoore/audit (2015-04-22 14:49:23 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-next

for you to fetch changes up to fcdd5f09c03bfc95f196dfa781ff447c5cbcc319:

  i2c: st: add include for pinctrl (2015-04-23 19:35:33 +0200)

----------------------------------------------------------------
Charles Keepax (1):
      i2c: Mark adapter devices with pm_runtime_no_callbacks

Dmitry Torokhov (1):
      i2c: rk3x: report number of messages transmitted

Wolfram Sang (5):
      i2c: mxs: fix broken email address
      i2c: pca-platform: fix broken email address
      i2c: digicolor: remove duplicate include
      i2c: mux: use proper dev when removing "channel-X" symlinks
      i2c: st: add include for pinctrl

 drivers/i2c/busses/i2c-digicolor.c    |  3 +--
 drivers/i2c/busses/i2c-mxs.c          |  2 +-
 drivers/i2c/busses/i2c-pca-platform.c |  2 +-
 drivers/i2c/busses/i2c-rk3x.c         |  2 +-
 drivers/i2c/busses/i2c-st.c           | 13 +++++++------
 drivers/i2c/i2c-core.c                |  2 ++
 drivers/i2c/i2c-mux.c                 |  8 +++++---
 7 files changed, 18 insertions(+), 14 deletions(-)

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVPNzJAAoJEBQN5MwUoCm2BuIP/0W8GW66Y3r7yPOsgAa2ywkt
s7bGVP25+roQIon0Xo33y4gKIDee69spcup1BhmxE+cFFLw9ZFX4kozgu2aFQC8n
VWTujERqB0uquM+sdur2tE/XuDaJY8RWRNbYJNxvsChQImwK7HzHX1Yv2XEEcs1t
rORJhkgKVHfX+A7+yTWDra9PVBUUoaCp58Z6Wh7lX0tg3mTcn6UP60SEkI+Xdjpw
i0EYwzFc5yfEhGnRFJRJjZIKIT5F/gmk6BE6VFJ8qH4zerv54OZGFDVieCfzRKLv
typK2S9Kjeskp/UJFCxjN/ItIxI/Xo5d2GNSs1c5dXZcvPS3O+MOmNWnxuDonN7a
QP4YeEsSO9j4VRo/FTtJTPfBd6skMGwnmC47tVicvF2m+BUT0tiPqAZU9BJF9vW5
qnjhvyLz7qZ2oGB1/0mPszEvXlS8oP0mBWrxLiNoNyBqzIT7+LFVtbFSyPn8G8lF
rF8PpzouHFJElpv6Sh3/tuFW3wp9Ya1BxwvoU1kcA54EHU2H2f2dK4vYjFyAbv/S
B3jmS1DloeDvmOkTT+bV+GoQAAJhO/cTXnrZTuTbzlgAHH5UDIV1gljj+goQHBMF
HHSEvXnCdKR74qqoOHnhWvEzW+e7N1ugneKiaV48mHRzpSc6XvuBocDpzoFc8ksH
p9FXWUmbDjk5mzYJDMHF
=o+Bi
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--
