From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PULL REQUEST] i2c for v5.0
Date: Sat, 9 Feb 2019 22:32:59 +0100
Message-ID: <20190209213255.b2udenonysi4hgca@ninjato>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7zuuuvhamouopxwh"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Rosin <peda@axentia.se>, Bartosz Golaszewski <brgl@bgdev.pl>
List-Id: linux-i2c@vger.kernel.org


--7zuuuvhamouopxwh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

I2C has for you:

one PM related driver bugfix and a MAINTAINERS update.

Please pull.

Thanks,

   Wolfram


The following changes since commit 8834f5600cf3c8db365e18a3d5cac2c2780c81e5:

  Linux 5.0-rc5 (2019-02-03 13:48:04 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current

for you to fetch changes up to 13c80dda84c4c0c0f52f8dc2e8f083ca3ccc2aa0:

  MAINTAINERS: Update the ocores i2c bus driver maintainer, etc (2019-02-08 22:15:24 +0100)

----------------------------------------------------------------
Andrew Lunn (1):
      MAINTAINERS: Update the ocores i2c bus driver maintainer, etc

Tony Lindgren (1):
      i2c: omap: Use noirq system sleep pm ops to idle device for suspend

 MAINTAINERS                   |  2 ++
 drivers/i2c/busses/i2c-omap.c | 13 +++++--------
 2 files changed, 7 insertions(+), 8 deletions(-)

--7zuuuvhamouopxwh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxfRwIACgkQFA3kzBSg
KbYq8w//W05tgEgkLAyFLN/FNRpmm47QEf18Eax20i9lhOwGHKEca7uFh+LsdKXs
Oy6BMdyV0J1TRGFWFFhrB5FEqGLaMsRSxrfMW/h6lgp3Acv8o6s/Ceg7x88PmylE
mIbvpX3zhp+aF0uq0Yct3PKqjmLVByhA4XWbHMNKegvLYsvcucZNn/S/CVQJhXqF
9vWp1+b2tpIiXjdpQvoU6xLSEONomk0bzUXL5Lw1ElPQJe0kiilxW4by7PDJkaGD
zv7OhNAbd66vJEkUgeUN9liApzUkL2M0b5byBM5LyAPnwTunR9p7Mhys0K0buIB+
YT30Diqej9pAdnc+oiwZjYMwHlUl+Zm9oEmM3Tfu0PxcSX1w16KX8gdyZmz+Ixas
T+GrkRuA1KxNmcExVCQ/jlpd0BBEIoGCmz75XFXlFHuTLEegFtvi4Iuif/TGbx/i
c3xa7UAGqdP0uR6G+oo6exlsAHjLsGekrAjQTL6OspuS0EOJGIhkC6shwSuiuMKx
LSgSHzShyOWFWCUaDbJuB/G/ii9JrZt3eLEaTPXQYAGHCxUGGqslkPuoVj2UOduY
xH9DiiqIDsCH2DOIxuS2PfRTDHUoNEkDgOLPQZjHCylkVch1aih1RPuc8R5WyhMm
DThlgPdZ1RpJkJ57jAypR738sRKzJLsqPRB5Y6wmLiW5n0CJL34=
=3/zy
-----END PGP SIGNATURE-----

--7zuuuvhamouopxwh--
