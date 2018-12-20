From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PULL REQUEST] i2c for 4.20
Date: Thu, 20 Dec 2018 22:57:09 +0100
Message-ID: <20181220215705.2zccmtoiuc2v74hm@ninjato>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wwsvx6d7aaikpnov"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Rosin <peda@axentia.se>, Bartosz Golaszewski <brgl@bgdev.pl>
List-Id: linux-i2c@vger.kernel.org


--wwsvx6d7aaikpnov
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

I2C has a MAINTAINERS update for you, so people will be immediately
pointed to the right person for this previously orphaned driver. And one
of Arnd's build warning fixes for a new driver added this cycle.

Please pull.

Thanks,

   Wolfram


The following changes since commit 40e020c129cfc991e8ab4736d2665351ffd1468d:

  Linux 4.20-rc6 (2018-12-09 15:31:00 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current

for you to fetch changes up to 32774a8153b4c62e408297fba352248afb2e0143:

  i2c: nvidia-gpu: mark resume function as __maybe_unused (2018-12-11 21:39:43 +0100)

----------------------------------------------------------------
Adamski, Krzysztof (Nokia - PL/Wroclaw) (1):
      MAINTAINERS: add entry for i2c-axxia driver

Arnd Bergmann (1):
      i2c: nvidia-gpu: mark resume function as __maybe_unused


with much appreciated quality assurance from
----------------------------------------------------------------
Alexander Sverdlin (1):
      (Rev.) MAINTAINERS: add entry for i2c-axxia driver

Andy Shevchenko (1):
      (Rev.) i2c: nvidia-gpu: mark resume function as __maybe_unused

 MAINTAINERS                         | 7 +++++++
 drivers/i2c/busses/i2c-nvidia-gpu.c | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

--wwsvx6d7aaikpnov
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwcEC0ACgkQFA3kzBSg
KbbhYxAAoNPbJS86aSOHeciU2tQ5pkv10M12Uusakg73Rl/j856TphCIi+Pn713N
KM5dtOAs5ss0dBb7WK+c/p9IdRjRSfzd/qpBHg3f90OrlTzMqKriBcdxAybmWH4B
bO6jyutDaXpgDnbJEDDnSaTI8QujnORCuZKWzp0yjAQnwrGPg3yqIA1f365uFMHW
dd52YmgGDnj+tzss3wGzcG2WdPYPE7TTBXA3/o67/AN3DqwzIydVpN5UXXwe/2Uj
b2NhiX/ZeIfpNJR/WcdRwok/h7q5wkYrIg5fCzkHiHIzU3+zFJuU/L9OwYF7P1J4
5hiXIGStiYY9FixiidBBKbzGg4o5ItPac1qdZRGvNy65fX9sFaO7fvzAS5UTY4Yk
l5iNfei6geDyZziN2Hc4xxFNy6ELOUMuBlbUBsfhGrdPZzhUhun84gO5F/cPVKL3
wWfK4qQmbOHmCala96uR43oQfc6wjlcJMvDWDeOcuJB5ielK9KIf/j0J+mjJpnW1
1J17c0p9LBy2m44uhft+BcxG+BReR8aOfHzKJLsDYczXAiDifDQJv+dwiAftRXTG
yleOBZJyynP0JYT15WRXmDqbnYXzOpQWfjSudMc0Ruk38xEkH2RSMUDUocZ6861H
qJXdPatRsdz8wgCVb9IUIuMsMXBUi2cwNeX2IWwimr7QdOFwo4s=
=zGUl
-----END PGP SIGNATURE-----

--wwsvx6d7aaikpnov--
