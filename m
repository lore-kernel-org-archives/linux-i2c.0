From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PULL REQUEST] i2c for 4.17
Date: Sat, 28 Apr 2018 14:26:40 +0200
Message-ID: <20180428122636.zq3e5zwgb6aekupp@ninjato>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rd5xnnsjfm6asq43"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Rosin <peda@axentia.se>, Bartosz Golaszewski <brgl@bgdev.pl>
List-Id: linux-i2c@vger.kernel.org


--rd5xnnsjfm6asq43
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Linus,

I2C has two driver fixes, one better parameter check for the core,
Documentation updates, and part of a tree-wide HAS_DMA cleanup for you.

Please pull.

Thanks,

   Wolfram


The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-curre=
nt

for you to fetch changes up to 2a010461207cc96bee5ab81748325dec1972976f:

  i2c: sprd: Fix the i2c count issue (2018-04-27 14:12:43 +0200)

----------------------------------------------------------------
Alexander Popov (1):
      i2c: dev: prevent ZERO_SIZE_PTR deref in i2cdev_ioctl_rdwr()

Baolin Wang (2):
      i2c: sprd: Prevent i2c accesses after suspend is called
      i2c: sprd: Fix the i2c count issue

Geert Uytterhoeven (1):
      i2c: Remove depends on HAS_DMA in case of platform dependency

Sam Hansen (3):
      Documentation/i2c: whitespace cleanup
      Documentation/i2c: sync docs with current state of i2c-tools
      Documentation/i2c: adopt kernel commenting style in examples


with much appreciated quality assurance from
----------------------------------------------------------------
Mark Brown (1):
      (Rev.) i2c: Remove depends on HAS_DMA in case of platform dependency

Uwe Kleine-K=C3=B6nig (1):
      (Rev.) i2c: dev: prevent ZERO_SIZE_PTR deref in i2cdev_ioctl_rdwr()

 Documentation/i2c/dev-interface | 32 ++++++++++++++------------------
 drivers/i2c/busses/Kconfig      |  3 ---
 drivers/i2c/busses/i2c-sprd.c   | 22 ++++++++++++++++++----
 drivers/i2c/i2c-dev.c           |  2 +-
 4 files changed, 33 insertions(+), 26 deletions(-)

--rd5xnnsjfm6asq43
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlrkaHgACgkQFA3kzBSg
KbZVBBAAp6Hj2xdziR81Amwv7g09AGyf/hiWlHP+UPPvvcKpWF5J4HMOKO3tFkRt
TLGUsJJg5D9wF297W2L+pj+l8RS2Svo5b84mNaLL8/ghUtwRX+yiPDT5vh7bzoX4
JpZ96g3jrXCv/KpPlz/KV/Iwzs2QsKeDMHAhAbcKUgmhd2lC3LmBaANL3KH8lrIL
PEKNLY1QEWRVTHjD8uQeMuHYKZottSr5Mkj6Cds6+U+sE9/3/osozzoGe1tQqV8i
CTkh3kI0cEYOHLlHO3IngfffVy0a4ampfD54dI3bjAMBw3HJmWfdl6kzLSKEv165
/Zh6n08feSHTlIFBuLozlKs7jBEyWXSeY8ptym32GhzHUl/mPcyX3ya4/C0puCdo
DcdusMk7yq61rXXF+/fqn2G35N1e4PoHWwgsL6xvZNNip/HLan7q+MdwveiKXBn1
K2aY+ccjU/k8JUjGYOGOHFU9VB60dJmlZ8ijUme8jIrsgXTNZQ5QFnQnM560wqLT
INKyI4RhN/TzsqVYuThGH8/NbRQyC4BmjfmpjkJLELSDfdKWWKhyd0L9QoqdKvJB
pAqjovmB2P7mtkQxZSi0E1heRzd1ky/v7Qq9osFLef5HhgGq6wEAVHXzw//2v6cx
KQs7bhSMQbWYVmiA21UfSy2eD6FAMSu/51uHmkK5Usufk2+4j1s=
=iM47
-----END PGP SIGNATURE-----

--rd5xnnsjfm6asq43--
