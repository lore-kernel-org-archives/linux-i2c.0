From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PULL REQUEST] i2c for 4.13
Date: Wed, 9 Aug 2017 21:29:29 +0200
Message-ID: <20170809192924.svb7qfvqywsddszy@ninjato>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fufgqrdbbb24seki"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Rosin <peda@axentia.se>
List-Id: linux-i2c@vger.kernel.org


--fufgqrdbbb24seki
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

here is a pull request from I2C. The main thing is to allow empty
id_tables for ACPI to make some drivers get probed again. It looks a bit
bigger than usual because it needs some internal renaming, too. Other
than that, there is a fix for broken DSTDs, a super simple enablement
for ARM MPS, and two documentation fixes which I'd like to see in v4.13
already. Please pull.

Thanks,

   Wolfram


The following changes since commit 16f73eb02d7e1765ccab3d2018e0bd98eb93d973:

  Linux 4.13-rc3 (2017-07-30 12:40:36 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current

for you to fetch changes up to 9c80034921d1ece5c0e3241ba1645bce32387684:

  i2c: rephrase explanation of I2C_CLASS_DEPRECATED (2017-07-31 17:33:53 +0200)

----------------------------------------------------------------
Andy Shevchenko (1):
      i2c: core: Allow empty id_table in ACPI case as well

Chris Gorman (1):
      i2c: mux: pinctrl: mention correct module name in Kconfig help text

Hans de Goede (2):
      i2c: designware: Print clock freq on invalid clock freq error
      i2c: designware: Some broken DSTDs use 1MiHz instead of 1MHz

Russell King (1):
      i2c: allow i2c-versatile for ARM MPS platforms

Wolfram Sang (2):
      Merge branch 'i2c-mux/for-current' of https://github.com/peda-r/i2c-mux into i2c/for-current
      i2c: rephrase explanation of I2C_CLASS_DEPRECATED


with much appreciated quality assurance from
----------------------------------------------------------------
Andy Shevchenko (2):
      (Rev.) i2c: designware: Some broken DSTDs use 1MiHz instead of 1MHz
      (Rev.) i2c: designware: Print clock freq on invalid clock freq error

Rajmohan Mani (1):
      (Test) i2c: core: Allow empty id_table in ACPI case as well

 drivers/i2c/busses/Kconfig                  |  2 +-
 drivers/i2c/busses/i2c-designware-platdrv.c |  6 +++++-
 drivers/i2c/i2c-core-acpi.c                 | 19 +++++++++++++++----
 drivers/i2c/i2c-core-base.c                 |  1 +
 drivers/i2c/i2c-core.h                      |  9 +++++++++
 drivers/i2c/muxes/Kconfig                   |  2 +-
 include/linux/i2c.h                         |  3 ++-
 7 files changed, 34 insertions(+), 8 deletions(-)

--fufgqrdbbb24seki
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlmLYo8ACgkQFA3kzBSg
KbZEhQ//avk6pRF+vpLl++xqKZOHI9Ct0HUtZERvsq+qQmF4VCT129SHZCcZ5kLJ
nAdKzWXYkX/zqnEH8VYIQMHTZuZgm/+a4EbPSFxFrlTjLJUsILBXQoNrRDgimfSA
NNRDtxnPaxjwB5KXpxtpeORgR9gqFJ0ju8c1gAYtF8yHaqcEK4vO/DUSnkCPpAM+
i8QzGt5w1jpNruWdCKIsnxAG2xH/IXkvGRf1FokjBYCsGnaf3qFmPmfIX8zxBtCZ
RlVc4xA8RT8VA4Vv70iaIGCKF1JCunbC/B7NbP8vwwO7l39AFlIguvU9rQ25D6TZ
zfL5AgfJOAHs6pKOyLKdjmv/gkNBNd2AMj5P1fovIysCX5pkTThQjb7iwThYHEOv
RzJC52FDHzJVmeVzC8111DDtyoF88MIcSoiburaVOrkk6D9KKqzcxa8ZZ2MBqiwl
LhURoOAfkC/GG97tqmNutR+yOio/jhw1IHiB4S1Kbefc9Ycv/yYyeHATGg5ysBsT
wa3lhAT9s8zRQsxQt/NMHnFkXB4ftf2fuIpxxW+cuSfBduIVBdhXXmTN8uSvb/UK
CmDQkiYBQrgfIxNAuixO6QrYGL1P2q/51nO8y3e3Ja4+kR3PzxYBcuntV1YU2+F9
MNcvDNAAjhr8fb5Kh/eGB6riUdjhREX2t+oYSmMlPLoLT0jZCKY=
=h75C
-----END PGP SIGNATURE-----

--fufgqrdbbb24seki--
