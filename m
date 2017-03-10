From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PULL REQUEST] i2c for 4.11
Date: Fri, 10 Mar 2017 13:33:12 +0100
Message-ID: <20170310123308.4suuobaz2q372tod@ninjato>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="geviu64vcerpb5fi"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--geviu64vcerpb5fi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

here are some driver bugfixes from I2C. Unusual this time are the two
reverts. One because I accidently picked a patch from the list which I
should have pulled from my co-maintainer instead ("missing
of_node_put"). And one which I wrongly assumed to be an easy fix but it
turned out already that it needs more iterations ("copy device
properties").

Please pull.

Thanks,

   Wolfram


The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:

  Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current

for you to fetch changes up to 806dbb20efde821910b5f747befed794077a9109:

  Revert "i2c: copy device properties when using i2c_register_board_info()" (2017-03-09 16:41:48 +0100)

----------------------------------------------------------------
Chris Brandt (1):
      i2c: riic: fix restart condition

Dmitry Torokhov (1):
      i2c: copy device properties when using i2c_register_board_info()

Heiner Kallweit (1):
      i2c: meson: fix wrong variable usage in meson_i2c_put_data

Jaedon Shin (1):
      i2c: brcmstb: Fix START and STOP conditions

Javier Martinez Canillas (1):
      i2c: exynos5: Avoid transaction timeouts due TRANSFER_DONE_AUTO not set

Qi Hou (2):
      i2c: add missing of_node_put in i2c_mux_del_adapters
      i2c: add missing of_node_put in i2c_mux_del_adapters

Wolfram Sang (4):
      i2c: m65xx: drop superfluous quirk structure
      Revert "i2c: add missing of_node_put in i2c_mux_del_adapters"
      Merge branch 'i2c-mux/for-current' of https://github.com/peda-r/i2c-mux into i2c/for-current
      Revert "i2c: copy device properties when using i2c_register_board_info()"

Zhangfei Gao (1):
      i2c: designware: add reset interface


with much appreciated quality assurance from
----------------------------------------------------------------
Andrzej Hajda (1):
      (Rev.) i2c: exynos5: Avoid transaction timeouts due TRANSFER_DONE_AUTO not set

Andy Shevchenko (1):
      (Rev.) i2c: designware: add reset interface

Jun Gao (1):
      (Test) i2c: m65xx: drop superfluous quirk structure

Ramiro Oliveira (1):
      (Test) i2c: designware: add reset interface

Simon Horman (1):
      (Test) i2c: riic: fix restart condition

Zhang Xiao (2):
      (Rev.) i2c: add missing of_node_put in i2c_mux_del_adapters
      (Rev.) i2c: add missing of_node_put in i2c_mux_del_adapters

 drivers/i2c/busses/i2c-brcmstb.c            | 27 +++++++++++++++++++++------
 drivers/i2c/busses/i2c-designware-core.h    |  1 +
 drivers/i2c/busses/i2c-designware-platdrv.c | 28 ++++++++++++++++++++++++----
 drivers/i2c/busses/i2c-exynos5.c            |  3 ++-
 drivers/i2c/busses/i2c-meson.c              |  2 +-
 drivers/i2c/busses/i2c-mt65xx.c             |  9 ---------
 drivers/i2c/busses/i2c-riic.c               |  6 +++++-
 drivers/i2c/i2c-mux.c                       |  2 ++
 8 files changed, 56 insertions(+), 22 deletions(-)

--geviu64vcerpb5fi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAljCnP8ACgkQFA3kzBSg
Kba2+w//az4LGe6LoD+NRN945gf3CNwjkGcVks0GlUpLftJlvk+fva9+rxut8lpV
xbPm3lVsPxEbGbWv2RIXLuDAOfMHGab4LUIXjKq6yhx5XoFTzNsjDaHgqTL7uxub
5qcpyvzf/C1OWEezwUY4kG9u2IXwWnVelgfnrmiXWIAe0pJN61AGy/hwC5ikDXRv
bTcv36SrnVu2ti66qx6FVO4p/rjuqgC30KlAnvdImd3iCa55hCB7E83SEYPA6LZ4
+2IiyOuY5bobtnWXIMwqOKOEtSQ1bXotaNyx64/Ae2K9lCEDgiVr+EGxiqk0ZNez
rqK01oSHg+PUWMaTNfFgI3U0zeiVbFC7eaRSjcnn3pIIxMQus+xAHT8174NAPn6U
sxpwv6mSKIsWbobOM9+hK6TbMXSWc9jQw9IEM1rjYvFHGuKlRs5D4syHBL8wi7CV
PfBdg7LiWqM8HV4u+2vKBTvdEPQ/Az2i9vKfFTOyyPz8tw74tg/RV6RnbK3w118l
t8tSNdBYFKrEIo0kiVw/RT1aEZuLThKf7jTq+xVCkPOJkEbbLxrXFpUXmbJ5m+0D
0gYFizBOqhXgqgvSCqhnpGE1/XN+V3y4NGtdBcScEJ/dacY9XpNQbcvYrmZ9UiwS
tqhTbMT6ry6DWYKeHAYwPouai6iEpLA2mtVNFRp+LiqMdVO+774=
=Zlk4
-----END PGP SIGNATURE-----

--geviu64vcerpb5fi--
