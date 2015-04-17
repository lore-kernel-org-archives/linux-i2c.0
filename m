From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: [PULL REQUEST] i2c for 4.1
Date: Fri, 17 Apr 2015 10:33:54 +0200
Message-ID: <20150417083349.GA1323@katana>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IJpNTDwzlM2Ie8A6"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

here are two buildfixes for I2C based on your tree from the day before
yesterday. Sadly, these build errors never reached me while the patches
were sitting in -next. Need to fix that. Please pull.

Thanks,

   Wolfram


The following changes since commit bb0fd7ab0986105765d11baa82e619c618a235aa:

  Merge branch 'for-linus' of git://ftp.arm.linux.org.uk/~rmk/linux-arm (2015-04-14 21:03:26 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-next

for you to fetch changes up to c1c21f4e60ed4523292f1a89ff45a208bddd3849:

  i2c: core: Export bus recovery functions (2015-04-15 21:02:07 +0200)

----------------------------------------------------------------
Guenter Roeck (1):
      i2c: jz4780: Fix build for m68k and sparc64

Mark Brown (1):
      i2c: core: Export bus recovery functions

 drivers/i2c/busses/i2c-jz4780.c | 1 +
 drivers/i2c/i2c-core.c          | 3 +++
 2 files changed, 4 insertions(+)

--IJpNTDwzlM2Ie8A6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVMMVtAAoJEBQN5MwUoCm2rlgP/1fv4v1B9M3ckX1FKZcbNvIB
HCevsxJXgzJLKqU99/ujyAmx4ZZkWgb3LtqAPh+evuplNAYpjEHe6HQGp/pMHb3l
5DJcJqZk6AhIdq6dBn+bgW9Tp/MwLzqdyPNFdSp5phaJkQ8juGUb7Gxe3K5gn967
mZVXLj14QIw0YiwwS5/JCQsewqsJF3RAj4drvCyl7slQmNUyz8gvGIoBKGEFNWu7
pRqYJRpAaSQLn7udh50dt1NrFIRllt2Ag1aZDlMpAYIB84BSUITgiv/D5D4xwByd
ywuwMYj+xEDKKb1BvukwhAZeeUlYIrQ/IKKp3CjZutiuRDgeyIH6eJyX4JGTfigV
rgvoXIeqFexra0sFswRqwCvZAnZZmKb+k5l5X0wvFNR1sn+OIdaFp37AsUZsgMVa
gdYR8duMy/GvfnCu8FyX3twdxGYVM+X813y1Jmkm607N/uunWu1bHeAq6FuOc2s2
SMTgO2ieNm+ahJtaRzGm+DLUN+DCz/cVZyP+DaywanMcy8lZT8+NOhrRIIdatIYQ
8qiGRZiGJCr1ax3vv04XmqEcknBvu1znRDVeo+AtX7SaUZaL0V3rPRJndRz0vXD/
+rGxCiisF+t8UvUodP2nishHLTQUW0pWdw23ks52LAxmCX/+XsCyIPGqvNG6XwIo
XXzmuWgkZuIh39l0PiyF
=euvD
-----END PGP SIGNATURE-----

--IJpNTDwzlM2Ie8A6--
