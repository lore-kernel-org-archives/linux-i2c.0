From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: [PULL REQUEST] i2c for 4.1
Date: Fri, 5 Jun 2015 10:28:47 +0900
Message-ID: <20150605012841.GA1756@katana>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

two small bugfixes for I2C. Please pull.

Thanks,

   Wolfram


The following changes since commit 5ebe6afaf0057ac3eaeb98defd5456894b446d22:

  Linux 4.1-rc2 (2015-05-03 19:22:23 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current

for you to fetch changes up to 8d487a43c36b54a029d74ad3b0a6a9d1253e728a:

  i2c: s3c2410: fix oops in suspend callback for non-dt platforms (2015-05-12 18:13:46 +0200)

----------------------------------------------------------------
Axel Lin (1):
      i2c: hix5hd2: Fix modalias to make module auto-loading work

Vasily Khoruzhick (1):
      i2c: s3c2410: fix oops in suspend callback for non-dt platforms

 drivers/i2c/busses/i2c-hix5hd2.c | 2 +-
 drivers/i2c/busses/i2c-s3c2410.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVcPtJAAoJEBQN5MwUoCm2I+IP/jFhGO9nChAHdZfOA5WOfRZA
3mgzRzddlP10WGVEkg2pdggckf77KJDdVhSa2v4w7lplj8HLiSjj8b5/Q/LRkRkU
VrDpXXTp+xqf9l51WS/tyTm+arj+rAbrrhDT2RkEIkeOgrHiEAaF5lAJ/WgosSc0
NgLevBTmp3CZSPcBsq6VOdocriMTw9FKoLzvaiHAeQ+5czcPdd/SlM3JdW6CypAY
NYOQG7QTIToVaop0ky32iGieUOgduuivC5IOcN2c/pBxLpExquvqxGWaHU0ApD9Z
GoSkoWAtPhBcxWtleLY1kKG/J2OT9e78JuCF/FIbMhrrI/jyL8pWqi/OvKEw+Ftr
JbzTP/Qee7u/SpsJ4UxwBI2bvtCltLxVoU5FDIMDMiBgEsOGf/RzU3SwM4tRx1Ox
kysB/ABKrEsKaJZ/RYP2fl6+n6S8iQWHn952qdWqSsyl+NWOOYDJ9THCYWOlcZUG
qLvOkfa3sP0/Ta7d2MAu/nTLFguRSz2t2FSEMEAb1bJ2cawb8cgaNrkLk3UN4ZTj
eJOGuCj09CQTIUtIgIIa176IP5F5IMGHIJcFGZ+wBcJ5mVyKf8O6bb6G4aK6KFaj
O9d7r4lsxxtJwwcSWDQYGaHg5RX0cld9V3qw8zxlU5HBUAD3T1RvMeSBkfsmnnoz
sXNp37jlwnhshHIB9xuw
=X7Nt
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--
