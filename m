From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: [PULL REQUEST] i2c for 4.2
Date: Sat, 11 Jul 2015 12:06:42 +0200
Message-ID: <20150711100639.GA1739@katana>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

here are the bugfixes for I2C since rc1. Mostly slight adjusments for
new drivers, but also one core fix for which finally the dependencies
are now available as well. Please pull.

Thanks,

   Wolfram


The following changes since commit d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754:

  Linux 4.2-rc1 (2015-07-05 11:01:52 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current

for you to fetch changes up to 4f001fd30145a6a8f72f9544c982cfd3dcb7c6df:

  i2c: Mark instantiated device nodes with OF_POPULATE (2015-07-09 22:25:54 +0200)

----------------------------------------------------------------
Axel Lin (2):
      i2c: xgene-slimpro: Fix missing mbox_free_channel call in probe error path
      i2c: jz4780: Fix return value if probe fails

Geert Uytterhoeven (1):
      i2c: I2C_MT65XX should depend on HAS_DMA

Pantelis Antoniou (1):
      i2c: Mark instantiated device nodes with OF_POPULATE

 drivers/i2c/busses/Kconfig             |  1 +
 drivers/i2c/busses/i2c-jz4780.c        | 15 ++++++++-------
 drivers/i2c/busses/i2c-xgene-slimpro.c |  1 +
 drivers/i2c/i2c-core.c                 | 16 +++++++++++++++-
 4 files changed, 25 insertions(+), 8 deletions(-)

--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVoOqvAAoJEBQN5MwUoCm2v6UQAINSwmaFSNBYLx84o+nOEDGm
fFwUkVL3WZpTpLScvO+xkG2222w5Q/FpeT04CCaH+R7eZWnK+UN/xh79PKzsXrbJ
j4ZQHGo0+Qrei2aGtGoS0Q1kNLkOf5s9JOpyje4j1t7PZedKCVSQcWw4XbyGZZVb
KUjSS2PJL7Obw9RVa5ThlrtvoTUGcWT4WDVTLg/AhHvU+ML1axHgPT+4m+TjjO9C
RdGzTnj4YiA+ivFaCtC1v354b+G/Hqk+KPSBuljaAF2ObvUwRmVnC2aWd0pSiz2y
CP0IWVSeQdJqk8rwN3gb/ljCgjHqjxLj+v7fwXHq4RBVKNc/cDB+ozb893nEOngk
RMKNp7mAPuHOsKUDSbFqifWtJQdq621mgJK6YwFauyEECg/BUbIbd6QOH3f/LIqn
mXtH3qkQOrewhEufArtAm4Yq+Wz7VGHgQHAXyVXQtcDqRXxeKDFk5yTkohvqbzQz
vE0ZDLhWkc6YaIf2MLM4T7NP9uEkqI/kQ5y/r/xplmHRafEfIiIxkepSHxLM8vtI
IZn55U3M65ke9JAOo3tWs5YGZwTk1f9acXWYpp113T3ZJ+24oceZOKlR1X/65iLS
y26T5YAiqAcmnS8RjIXdtk3OBdlUzC0oyuOOwkA5Lt4wrCNNRWCEMP4DSUIz4Y2v
5UOonSOV+0GxQMcihbU2
=NBv7
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--
