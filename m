From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PULL REQUEST] i2c for 4.10
Date: Fri, 10 Feb 2017 15:56:23 +0100
Message-ID: <20170210145620.bkltdzddksd4blk7@ninjato>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3kf4omwugamc626s"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--3kf4omwugamc626s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

here are two bugfixes (proper IO mapping and use of mutex) for a driver
feature we introduced in this cycle. Please pull.

Thanks,

   Wolfram


The following changes since commit d5adbfcd5f7bcc6fa58a41c5c5ada0e5c826ce2c:

  Linux 4.10-rc7 (2017-02-05 15:10:58 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current

for you to fetch changes up to bbb27fc33d44e7b8d96369810654df4ee1837566:

  i2c: piix4: Request the SMBUS semaphore inside the mutex (2017-02-09 17:13:01 +0100)

----------------------------------------------------------------
Ricardo Ribalda Delgado (2):
      i2c: piix4: Fix request_region size
      i2c: piix4: Request the SMBUS semaphore inside the mutex

 drivers/i2c/busses/i2c-piix4.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

--3kf4omwugamc626s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlid1I4ACgkQFA3kzBSg
KbY4Rw/+K+tsjp0zp7F+Du9ioQ5mYqoFhZH0D0XQo8Ea1cQtVngDBaJ816rK295F
ZUPUt7dP6+Vpc+xON+dXfnKcGMyvgme/qFft2mWf/j4l0/wmaOyuVXlsFD7Q9qlA
wpZ4mJz1XJjnnUPLbZxTzLFE2L+W81D8zgitSy9iwX+amdv8jRc4Y5xM0yPdcoeE
yL94o4M9q+kXvFimQ/gvrsMFjke+3kpvaVYaRc6g+rd05hHdiNvOlXMWNd+Uiveg
CxVABby+7dsvtguKqY2IMZib73h6k/tHTbD7ZibftT4W7x0texwjFRXC0P9XEOO0
rbYe9WpLxih17MTxd4TqZWrjv54MB58AypJdo1vt0WRrzffdfGVWRDbbnykdlW0J
zBW8WIfl82iu46RiVV5SYrPqWK0xh/ellS566A5zlyQaKNMdmCUSsGoeBSDUeCMe
+JuS4RGjPz9khjQb5Lim78P4jw56c0RVxtCnNuapnD7E9z0Vj766CQY6T4ehFUfx
F5TyXjnnIQbtuTQhWjx6CPw2jgSlQrEd0gjn2KijquIX8junzllhZYwbEjxDFipX
4cwpdIB+RDo8pawholXR7CgqFHpQV/mEG4e4/0VdcxefcQ0UdmzisMmYFLcUHIOj
rmQeo2Bt/vRuEVOhYHf+WLqXv7W+ill1yyLnV7GKsZc0+u9sMCc=
=gDoi
-----END PGP SIGNATURE-----

--3kf4omwugamc626s--
