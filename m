From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: [PULL REQUEST] i2c for 3.19
Date: Sat, 31 Jan 2015 15:11:48 +0100
Message-ID: <20150131141144.GA30737@katana>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

a pull request from I2C with driver bugfixes (s3c2410, slave-eeprom,
sh_mobile), size regression "bugfix" (i2c slave), documentation bugfix
(st). Also, one documentation update (da9063), so some devicetrees can
now be verified. Please pull.

Thanks,

   Wolfram


The following changes since commit eaa27f34e91a14cdceed26ed6c6793ec1d186115:

  linux 3.19-rc4 (2015-01-11 12:44:53 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current

for you to fetch changes up to 32e224090fa310a58fdb47049caf631272ceb044:

  i2c: sh_mobile: terminate DMA reads properly (2015-01-30 17:58:43 +0100)

----------------------------------------------------------------
Geert Uytterhoeven (1):
      DT: i2c: Add devices handled by the da9063 MFD driver

Jean Delvare (1):
      i2c: Only include slave support if selected

Lee Jones (1):
      i2c: st: Rename clock reference to something that exists

Paul Osmialowski (1):
      i2c: s3c2410: fix ABBA deadlock by keeping clock prepared

Wolfram Sang (2):
      i2c: slave-eeprom: fix boundary check when using sysfs
      i2c: sh_mobile: terminate DMA reads properly

 Documentation/devicetree/bindings/i2c/i2c-st.txt   |  2 +-
 .../devicetree/bindings/i2c/trivial-devices.txt    |  1 +
 drivers/i2c/busses/Kconfig                         |  1 +
 drivers/i2c/busses/i2c-s3c2410.c                   | 23 ++++++++++++++++------
 drivers/i2c/busses/i2c-sh_mobile.c                 | 12 ++++++++++-
 drivers/i2c/i2c-core.c                             |  2 ++
 drivers/i2c/i2c-slave-eeprom.c                     |  4 ++--
 include/linux/i2c.h                                |  6 ++++++
 8 files changed, 41 insertions(+), 10 deletions(-)

--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUzOKgAAoJEBQN5MwUoCm26YQP/Rz+BSX8ddPI206yjBPE6vkL
uhWS3OWPZmMosXIGSX8T6YSkIdq2FItvrE8MAJWanFjpjdn9coS/AyDduigczV6t
Bta5a2m89PisI8nd5vlRFQAm5p92Aq5xmskgghk5Yqiux4TETvjwoUyL/Lmqvgbs
xpk0nxp7/v/wW5lW5rNkrr8Fdzqks4GY7C4MBVZ2qFXCyiQrthjuhu7t8znTO++X
w8831C3H42r+HphIOsrbOMh1URxeuwD4aGc14YEiHBUHz6FvBwzSMAm0zjUEkCL8
D33AR5ldoZ+JhWMtpgpOldE2t4d7qsMkC1f3wD7GWtddaU5Z4/sDuZL9zi0v07by
vcgSLaKBeRC0p/vAtx+ScjWlEaXox4JHM26RsOUO5V7rMpE8U7c8J0OmSCWQQrR6
+g77IjNdhqA5gmtgwtVCxP1sDrCtzdEeeI4bhSebr/OgzUbsaEV1fDUDZIQa/C/s
kZHz3H246CZazQa68NedHFFU1GmtWk1Q8xvEftS6aon+m/NyHuDnkTFoClh/VImG
7ykXgx1BDk53rlCH+VxVC/9N5YYXdA+eDLPdBG0MWIRTjp1GDI/kEj8g1tNKEOZE
1HOsa39P6UjBxralLeZd3MB9TLdlIKrGCVGmudw31wJt0muIHwi6m67wJMHf3WUV
cyYhD2nRx/OvJRPUrqit
=1ZlH
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--
