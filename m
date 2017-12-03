From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PULL REQUEST] i2c for 4.15
Date: Sun, 3 Dec 2017 16:06:13 +0100
Message-ID: <20171203150609.wlwagsltct4g3ylo@ninjato>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="igg5hfmxzgazlflw"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:40986 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752505AbdLCPGP (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sun, 3 Dec 2017 10:06:15 -0500
Content-Disposition: inline
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Rosin <peda@axentia.se>, Bartosz Golaszewski <brgl@bgdev.pl>


--igg5hfmxzgazlflw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

here are two bugfixes for I2C, fixing a memleak in the core and irq
allocation for i801. Also, three bugfixes for the at24 eeprom driver
which Bartosz collected while taking over maintainership for this
driver. Good start, Bartosz!

Please pull.

Thanks,

   Wolfram


The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:

  Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current

for you to fetch changes up to edef30980dc06bea547baefcfc8d910682b6e060:

  Merge tag 'at24-4.15-fixes-for-wolfram' of git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux into i2c/for-current (2017-12-03 15:55:20 +0100)

----------------------------------------------------------------
Bartosz Golaszewski (1):
      eeprom: at24: correctly set the size for at24mac402

Colin Ian King (1):
      i2c: i2c-boardinfo: fix memory leaks on devinfo

Hans de Goede (1):
      i2c: i801: Fix Failed to allocate irq -2147483648 error

Heiner Kallweit (2):
      eeprom: at24: fix reading from 24MAC402/24MAC602
      eeprom: at24: check at24_read/write arguments

Wolfram Sang (1):
      Merge tag 'at24-4.15-fixes-for-wolfram' of git://git.kernel.org/.../brgl/linux into i2c/for-current

 drivers/i2c/busses/i2c-i801.c |  3 +++
 drivers/i2c/i2c-boardinfo.c   |  2 ++
 drivers/misc/eeprom/at24.c    | 19 ++++++++++++++++++-
 3 files changed, 23 insertions(+), 1 deletion(-)

--igg5hfmxzgazlflw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlokEt0ACgkQFA3kzBSg
KbbHpQ/+OASLrY8lcPlt25z+E7IqXUq0fNZ4BCxXhKGHhz/WaTDGBNKRhrj7hfNo
MGPEHkVflDBoBCk/ftIkHsRABc/PQ9l9zfFidN4NXPxJKlgC0fNbSuAF28TN+Jnq
tiajJyt0F0VPyD2KefHkjT1TuAiYjgmmpIwP/zHd0Ud5ESVwodPWZfoGidczzLpX
ZBxUWc7R+QRkEyQHZZPBMb268ofOuRAdKReVuNZWlrc4+XUAT5yjoS+JMeScG66X
5JjRHGjnWbVFI14fjlBhbNDj6kOepKX5MZOS8Y6FNqsZVtl246B+bgQVOwMqwtp0
y0/CoMoZJchZoAZUW4uytQh5paSpYVMsaaa37PhQlAchHlkcIPD8MW60FbJ3qH3q
2yHwbYhq86pFPXxa1NVSnVAe8qK0+UE5Rn+wzXXyn1jhO3LClpgYP7iDUgXhUUpn
CQnZCUWtRxjNXd75KpM0vMQrppOuRh6puQ9wGtSE8JwYQDFhs4HXDX2K4b4MCbS3
dNUiny6kforEu7vMlRhm5oHbfJUb5dIntRkjgpF16KBjXYVrvAnRkj35b4jKlZV1
FxZ9u4i7MbTrVfVsWSJnQ7GgdtRrO1CGk32+ZjKfyVv3jNTJq91aCGDsmxvQ/7Rh
hKHF6xdSBm5jZHDUCjzfRkRdYIQuwF/Iwzt038KuQrpCCwkNyeo=
=SnEj
-----END PGP SIGNATURE-----

--igg5hfmxzgazlflw--
