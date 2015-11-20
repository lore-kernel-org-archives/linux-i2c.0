From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PULL REQUEST] i2c for 4.4
Date: Sat, 21 Nov 2015 00:28:50 +0100
Message-ID: <20151120232846.GA2661@tetsubishi>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:47116 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759863AbbKTX25 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 20 Nov 2015 18:28:57 -0500
Content-Disposition: inline
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

here are a few bugfixes and one PCI ID addition from I2C. Please pull.

Thanks,

   Wolfram


The following changes since commit 8005c49d9aea74d382f474ce11afbbc7d7130bec:

  Linux 4.4-rc1 (2015-11-15 17:00:27 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current

for you to fetch changes up to cdc5a3110e7c3ae793f367285789a6bc39c962dc:

  i2c: i801: add Intel Lewisburg device IDs (2015-11-20 16:22:21 +0100)

----------------------------------------------------------------
Alexandra Yates (1):
      i2c: i801: add Intel Lewisburg device IDs

Grygorii Strashko (1):
      i2c: fix wakeup irq parsing

Hou Zhiqiang (1):
      i2c: imx: fix a compiling error

Lars-Peter Clausen (2):
      i2c: Revert "i2c: xiic: Do not reset controller before every transfer"
      i2c: xiic: Prevent concurrent running of the IRQ handler and __xiic_start_xfer()

 Documentation/i2c/busses/i2c-i801 | 1 +
 drivers/i2c/busses/Kconfig        | 1 +
 drivers/i2c/busses/i2c-i801.c     | 6 ++++++
 drivers/i2c/busses/i2c-imx.c      | 1 +
 drivers/i2c/busses/i2c-xiic.c     | 4 +++-
 drivers/i2c/i2c-core.c            | 2 +-
 6 files changed, 13 insertions(+), 2 deletions(-)

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWT6yuAAoJEBQN5MwUoCm2oCwP/jurCBuecnKRSkmvUDKAwdYN
Oflstmb0L0/KBly1L5pbXoaxd5R2eWqh8tdrlQLH5vYpejRVVu0ARoQCFVitseLx
A6Mc6rpRMEkz7bA7Y8tUxu2UNDuCDFIZPFIXYINYNAWsbGDbTwdZ7ueLTUL+NL18
f5m3Q/IbE9gn/W5sGY+t9vBZFT+m5TjogSeeYp1hGAk33wB/hmzvIVG8cWRmxf84
3nFKNTV/BD9IPfXarrsif7eMMSdews7tqecg3msmY4yV+gOR3cNJKyLtCWMfo6m9
BmUJIslYLUe6VkH423oyCZ0gGnLTOnyh54CCtRVsPJsr+JyL9qoorO6h4VeOf2nE
t/mP6sctvkzxKpcT2icotfhP/k8YDF3j6ySwnXFYkogxRKEINRxh6UYdtUI55ygi
+Dh+W5G84+Fh1DEZR91AryhIRcGMYiwdAPGQxzIxVLqk1Bq+gqDAGLyNYITq2X5w
+9VDQUzqPhaJSb11BUv3noUhStPfn2f66IUTqFdYkhIhlep1MHxJwFQjONuUTwRw
QuNvSE21haK8qNV0qC16vu1Irv4CtTvkv/Nu0beRWgHmVRs25tXvB7lfpej/vJ9h
Hofe/hS3eW8qFT23fB/XftMJrREslwR0DumKtzt8GB1wB9kjqpB/w86pPUkM+38r
mVQ75vHmwMM/CSeYrgBk
=4Rce
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--
