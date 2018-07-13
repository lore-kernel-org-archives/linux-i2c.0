From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PULL REQUEST] i2c for 4.18
Date: Fri, 13 Jul 2018 22:34:23 +0200
Message-ID: <20180713203419.ty2boi6zj6qvzyoh@katana>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mwcxmur3ww62ikxn"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Rosin <peda@axentia.se>, Bartosz Golaszewski <brgl@bgdev.pl>
List-Id: linux-i2c@vger.kernel.org


--mwcxmur3ww62ikxn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

I2C has for you:

- one I2C core bugfix regarding bus recovery
- one driver bugfix for the tegra driver
- one typo correction

Please pull.

Thanks,

   Wolfram


The following changes since commit 021c91791a5e7e85c567452f1be3e4c2c6cb6063:

  Linux 4.18-rc3 (2018-07-01 16:04:53 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current

for you to fetch changes up to abe41184abac487264a4904bfcff2d5500dccce6:

  i2c: recovery: if possible send STOP with recovery pulses (2018-07-12 23:38:18 +0200)

----------------------------------------------------------------
Jon Hunter (1):
      i2c: tegra: Fix NACK error handling

Thadeu Lima de Souza Cascardo (1):
      i2c: stu300: use non-archaic spelling of failes

Wolfram Sang (1):
      i2c: recovery: if possible send STOP with recovery pulses

 drivers/i2c/busses/i2c-stu300.c |  2 +-
 drivers/i2c/busses/i2c-tegra.c  | 17 ++++++++---------
 drivers/i2c/i2c-core-base.c     | 11 ++++++++++-
 3 files changed, 19 insertions(+), 11 deletions(-)

--mwcxmur3ww62ikxn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAltJDMsACgkQFA3kzBSg
Kbbt4A//Y6aUUG/9P1ZuycD+2HRdTU4p2Ma+ogx5O6bX93blLwWtlAG1XJPorUUy
fldw0NuHQDd0N2CgeJH0OGdTlDpwO1cyGkOEUXVjVMEZc6sySa4utY+kRNEqhiUF
TXmqW3NNqEwDskxS89XwIGQn45dQ856PW5n4C580u4KUCu1KXXp3OjPUFnX+lDDl
nzcnW3fn4AtEPXSAkHDuZyw7algIbkkrTorhejNfPIEP5R3b93QGpjaIZto6gDXT
xc5/odzR9Ag2GcP2IWpdkk6kc1qJ1mT0GqwJKi5+IybLWZddrg3oarravbRvdfL5
2WmVWYq/DktfJIwZu8IFt+eCycNHtylT6VS0PhAHNh9G5P02TSrUi8ywm+EZBI6s
PYeqrTXWCjKYiPjxjusfkDkag/MgYMguuJB28G7yrvBXLLKh1QxDRyUpqPteDDY1
KH8drR8NUQ+qxfWArgMQGQjg/iJrrQRXK6DOre+AnBCK91dB/N+ATg6/PY/vPONN
/QqjHoMN14449VYrJ5LxYnh2qC8p0pAuywpgMfUQSetao7p+7GqC+4FHfuX85SDh
o0xt/J+d36oOUNt8/XXpegClXxEc/52Y2A+OnjmgBcbmTUWtsqLTkZhUj/GidLfg
HTtMFxCau3L6iESjKQjZ338mkPLsKWLt/cWWMapiWqmIJMOa1Fc=
=aVKt
-----END PGP SIGNATURE-----

--mwcxmur3ww62ikxn--
