From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PULL REQUEST] i2c for 4.9
Date: Fri, 14 Oct 2016 13:37:42 +0200
Message-ID: <20161014113739.GA2030@katana>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

here is a small update pull request from I2C. It adds one comment to a
change we did in this merge window to handle lockdep better, and pulls
in a branch which should have been in 4.8 already improving DT support
for I2C.

Please pull.

Thanks,

   Wolfram


The following changes since commit de34f4da7f62ff59ac6e1ef320b0fcfa3296fce3:

  Merge tag 'media/v4.9-1' of git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media (2016-10-11 13:22:22 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-next

for you to fetch changes up to b2edcdae3d9a29b25f6c161a8711caa74ce49991:

  Merge tag 'tegra-for-4.8-i2c' of git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux into i2c/for-next (2016-10-11 23:37:26 +0200)

----------------------------------------------------------------
Bartosz Golaszewski (1):
      gpio: pca953x: add a comment explaining the need for a lockdep subclass

Jon Hunter (2):
      dt-bindings: i2c: Add support for 'i2c-bus' subnode
      i2c: core: Add support for 'i2c-bus' subnode

Wolfram Sang (1):
      Merge tag 'tegra-for-4.8-i2c' of git://git.kernel.org/.../tegra/linux into i2c/for-next

 Documentation/devicetree/bindings/i2c/i2c.txt |  8 ++++++++
 drivers/gpio/gpio-pca953x.c                   | 16 ++++++++++++++++
 drivers/i2c/i2c-core.c                        | 10 ++++++++--
 3 files changed, 32 insertions(+), 2 deletions(-)

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYAMODAAoJEBQN5MwUoCm2LBMP/3kPgaxUvHJY7TOxYpeGcHwB
WhY8GzdgACaq5l3iOQOJ8hb5VpUb3xGfJJ5mEZ84FTYJiZoD2MwL8hdhnW1pOtFG
FRngE0DuwQkwg1KhCbwZHh6Jjp+vpzcGGLUdmG0nYDE/JigJch8wCCXfm25gyl+U
VTzguZ4nLJnSBAXeLGBq/xSaIGHnbEo52bP/IkJt9NDuccu81HGfqqVnD8Fo/UiC
xBefpwyEYMFzcmb5pHsZbHb4gwOSlwkf4OclNea4Er94yGB9fK5wXxl/6Cvfjk6v
lr19SQ6Byd/r56Gi76Z4NeMQ9LB09dmFZDyqkFvlKUlcVC0kvHgFRelDTbD86bG7
9AjfmjPVFd3R586a+H4dmOXwLMdhpnGT8vQVMhPvL6GxVR1ITLW8L0VkFsTUz8Zo
RKSVIRXHS5i8E/oyCjFV3JAoW0Fiysb8+WRVcg+hkd4V8WFdaxN7oMMvdETVF6kM
kz6mJD3b7FALuMExvsFoeCTRIpmNhopUyxnjqERl+f+LTGycfGMC3T2nNNHtRJv5
0HKlmCi3+8uKVA7U3QouOr31u+cS/ATjI4/XaO9ixdHgAUfGm5cB/noMoXcg0tyY
owQ4Yz+gUd8NDNlXGVD0gwKpYsY8/N9Au5fBdcy4pElMuIPcMTO3F2SwHnYtG9zu
TZIpz5mVdImyGSdlTkAe
=0DXa
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
