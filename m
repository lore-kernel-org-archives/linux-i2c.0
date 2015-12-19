From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PULL REQUEST] i2c for 4.4
Date: Sat, 19 Dec 2015 12:05:12 +0100
Message-ID: <20151219110508.GA3289@katana>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bg08WKrSYDhXBjb5"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:50137 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750931AbbLSLFR (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sat, 19 Dec 2015 06:05:17 -0500
Content-Disposition: inline
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

here is a set of "usual" driver bugfixes for the I2C subsystem. Please
pull.

Thanks,

   Wolfram


The following changes since commit 1ec218373b8ebda821aec00bb156a9c94fad9cd4:

  Linux 4.4-rc2 (2015-11-22 16:45:59 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current

for you to fetch changes up to b4cd08aa1f53c831e67dc5c6bc9f9acff27abcba:

  i2c: rcar: disable runtime PM correctly in slave mode (2015-12-19 12:00:37 +0100)

----------------------------------------------------------------
Alexander Sverdlin (1):
      i2c: davinci: Increase module clock frequency

Dmitry V. Krivenok (1):
      i2c: do not use 0x in front of %pa

Gao Pan (1):
      i2c: imx: init bus recovery info before adding i2c adapter

Hans de Goede (1):
      i2c: mv64xxx: The n clockdiv factor is 0 based on sunxi SoCs

Jarkko Nikula (1):
      i2c: designware: Keep pm_runtime_enable/_disable calls in sync

Wolfram Sang (2):
      i2c: rk3x: populate correct variable for sda_falling_time
      i2c: rcar: disable runtime PM correctly in slave mode

Xiangliang Yu (1):
      i2c: designware: fix IO timeout issue for AMD controller

 drivers/i2c/busses/i2c-davinci.c            | 11 +++++++++--
 drivers/i2c/busses/i2c-designware-core.c    |  6 ++++++
 drivers/i2c/busses/i2c-designware-core.h    |  1 +
 drivers/i2c/busses/i2c-designware-platdrv.c | 16 ++++++++++------
 drivers/i2c/busses/i2c-imx.c                |  4 ++--
 drivers/i2c/busses/i2c-mv64xxx.c            | 27 ++++++++++++++++++---------
 drivers/i2c/busses/i2c-rcar.c               |  4 ++--
 drivers/i2c/busses/i2c-rk3x.c               |  2 +-
 drivers/i2c/busses/i2c-st.c                 |  2 +-
 9 files changed, 50 insertions(+), 23 deletions(-)

--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWdTnkAAoJEBQN5MwUoCm2ccEQAJlpYpi6Fqx4qm2Tb0xvN7Rw
Et3jrUC5Ym+SpX6UOeODVlQE5S6Wle+O7gHLjGcL+ZkWiF/Z1f3JsAkuHRGrAe+b
tChqAWyLnKE8Pa3b3lYq2+EQgfHIyK6kILQrh7EE1baiE+tc2XexqB8BDqDkDakb
X8v3GK/TiRLzl2nAZqp0kqAqxjlKtqdajggQYBImq/S/gXlcSzwfsSCsIPJ53e/O
AWKaN65owFhgmqf70L1CL011NS6y+5l0mChbb1sjBbYcXhW/OijK1gSpx291FnCi
EXn72W/c3fgmVbV9Xq8ydxrRTDjt+9vrCO/n9DpQJxZZHWzVd+T75ldY0IaodkFr
C5dplHFYQ+2gxQsUc9Y5xiL7Q6tFdjXEH7mVTqq0ajDX5GETv6W6sU3SJAbWbZTA
d0srGXoq2Z/VgdkqSYrQ4hTFPOK0TrRN7tK/EsQ0LEaa/WSZxiQ1wPfkJ5cQIeV9
wymH79r2V4ww3WVr6DiBNO1T8cKPZvmQaKkpIReriPmUoES+7iZsydH9cgucxfuI
jv6QpfZKT8UWzRL5ddi+miSonA4qSmnASekadBvSe+7Z9Dx6arOwIS8m8eJHKa2Y
uMLS8UwsImcsRrVVhmH9DU1TyrLh8PO5gjn6HxmJNuFU/lYDFm6zC+fwClTCIE2p
hHUDnxN4nQ5bdYRCD5mT
=cwWS
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--
