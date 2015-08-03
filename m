From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: [PULL REQUEST] i2c for 4.2
Date: Mon, 3 Aug 2015 22:47:14 +0200
Message-ID: <20150803204711.GA2749@katana>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

this pull request from I2C was planned for the last rc, yet for holiday
reasons I sadly couldn't send it out that weekend. I hope it is still
okay for the next rc. Inside is a refcounting bugfix for the i2c-core,
bugfixes for the generic bus recovery algorithm and for its omap-user,
making binary file attributes for EEPROMs behave POSIX compliant, and a
small typo fix while we are here. Please pull!

Thanks,

   Wolfram


The following changes since commit bc0195aad0daa2ad5b0d76cce22b167bc3435590:

  Linux 4.2-rc2 (2015-07-12 15:10:30 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current

for you to fetch changes up to e3311469734093724b10c2a81c1193197db03b78:

  i2c: fix leaked device refcount on of_find_i2c_* error path (2015-08-01 12:11:58 +0200)

----------------------------------------------------------------
Jan Luebbe (2):
      i2c: core: only use set_scl for bus recovery after calling prepare_recovery
      i2c: omap: fix bus recovery setup

Masanari Iida (1):
      i2c: Fix typo in i2c-bfin-twi.c

Vladimir Zapolskiy (3):
      i2c: slave eeprom: clean up sysfs bin attribute read()/write()
      misc: eeprom: at24: clean up at24_bin_write()
      i2c: fix leaked device refcount on of_find_i2c_* error path

 drivers/i2c/busses/i2c-bfin-twi.c |  4 ++--
 drivers/i2c/busses/i2c-omap.c     | 11 +++++++++++
 drivers/i2c/i2c-core.c            | 24 +++++++++++++++++-------
 drivers/i2c/i2c-slave-eeprom.c    |  6 ------
 drivers/misc/eeprom/at24.c        |  3 ---
 5 files changed, 30 insertions(+), 18 deletions(-)

--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVv9NPAAoJEBQN5MwUoCm2RIMP/jZXCG5rBlHu5Rr4RH7+V9Qg
FaI6/lEpd0ctU0kXhgqj6m7BMNOLNw6sWCjIhsHtpjZ3u7y7pYZxfXH3TzwnRTRD
YQlrvzsPfHTRihPuU/9hu3AtxdzNcGj5paONKSFcxrCbf+ODGsB4EZAhB+gAeqFP
w7lqe4avr0Z6ULoVjfmS3CJUwvbwJ7Wv025tYy0ySANlq7FoWRYSzIkg25UAMtyz
BDDbqe0I7ej1OnzvKuldP6kiSDKnOx3ighkYGOLqKfLjUrP12VeeRt3Rt4UEveT0
hFzRrIv0cfhgNwEV/sDvYeKP7zH0rcg3wPGnI74lREognps2I/H13moN2gEdayqH
p/WVJ1FfMeQhj3M9kkUWP2ZK7xSyRz3iPeScsyfeByqNaRAijSZE9zMjLvt7+I92
xqCqIZhRGDQWAoJkvFZA+x3+abRZhZePFvqIy8nBn7ZOTcxOVPdfv9ojfUaahLHm
A5p0btViWTlUw/9TYaX8ZmTlYw2C5vbRx8ENMu2Uqb/ZYqKw2+4rSSMa85girmTS
pSLmTq1+dxzWg67kgdM2mKbz8yOyNTaKse3gGpublgP5RniZBWbgk/EWVJW3EkAe
4cVjE/nZ/jazkPptMYYr70rgnC/cmA7F8jEioAqIyruJ3DMUymoxrNovJQdPkbAp
x+bsmbjpdHb1huBsQojS
=WAJl
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--
