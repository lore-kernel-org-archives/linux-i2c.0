From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PULL REQUEST] i2c for 4.12
Date: Fri, 23 Jun 2017 20:27:10 +0200
Message-ID: <20170623182706.mkz65j55re4koakc@ninjato>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qg53ojx4fq6a2ncw"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--qg53ojx4fq6a2ncw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

I2C has another driver bugfix for you. Please pull.

Thanks,

   Wolfram


The following changes since commit 41f1830f5a7af77cf5c86359aba3cbd706687e52:

  Linux 4.12-rc6 (2017-06-19 22:19:37 +0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current-fixed

for you to fetch changes up to 6c782a5ea56a799658e213a78dc1455264938afa:

  i2c: imx: Use correct function to write to register (2017-06-22 10:52:02 +0200)

----------------------------------------------------------------
Michail Georgios Etairidis (1):
      i2c: imx: Use correct function to write to register

 drivers/i2c/busses/i2c-imx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--qg53ojx4fq6a2ncw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAllNXXUACgkQFA3kzBSg
Kbbt3g//Z6nIMEwjMz617+EpxEObyl2nGnTjLA+tNa0EINSEtG/8vdabbJ8H67TN
q5PWVb5FzG5MEOfNSZrxffaWREbyL6gjxB59b4Ea/q7zdeHzsgl8Snuzkmi2JlvW
7HGZPacOtt2cPAapjrYZNyvvGBGHhbT22sXJucm0o0ZsDl7NQ2SI82g2fiUM1USK
iuwn3cMW42NeT7bxYwm4fcIpXJp9AN18UC2jOjxH3LaUt+jh5xFtSxqm2SJm2oiZ
cLwldcLug7oMXjta40T/TvfrEs0LJ0GAXqOrHnAIuOPyfgpyC1aCDV/2bEkj1n+8
zDYbHxiTJztm/obh/gryoUlc+YvalU92zmA0Gqod7Wz0u/8ncqE62Vwi/V9b54TE
AytDjR3XTvcZ8HIV6qeS804xm+qcbwjFXEl0yQzJ6faqh4QXSXvs28ffN0nFrslT
hQt7e1Ktiv1w6fxTzJmsB/sMe7tMF2uAexbtO7HL4r4Y6Y/Qg/bu/MDhxah7to/K
QVHVO7EBN2oNncJbqlFxS4HkxL1ys8AWo5XJ1eyFLQ479bxFAggy6RvpCqEAy+nA
cAOlYJIjFMOBsw5/I0lZ/e5PRYF32h+7OiACmtyqAuSfgL1CDDEldhzQ/6X0Tj6m
TEeu7Eoc11QrlCcRKRF3e5fdcFc4OeOQSTBdXryeQzJew/MW4D4=
=6O7f
-----END PGP SIGNATURE-----

--qg53ojx4fq6a2ncw--
