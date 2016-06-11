From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PULL REQUEST] i2c for 4.7
Date: Sat, 11 Jun 2016 19:57:30 +0200
Message-ID: <20160611175727.GA12308@katana>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:44695 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751328AbcFKR5i (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sat, 11 Jun 2016 13:57:38 -0400
Content-Disposition: inline
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

please pull the bugfixes for I2C:

* bigger fix for i801 to finally be able to be loaded on some machines again
* smaller driver fixes
* documentation update because of a renamed file

Thanks,

   Wolfram


The following changes since commit af8c34ce6ae32addda3788d54a7e340cad22516b:

  Linux 4.7-rc2 (2016-06-05 14:31:26 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current

for you to fetch changes up to 9f05e6219023116b59f6495e8c4d4ba352dd5fea:

  i2c: mux: reg: Provide of_match_table (2016-06-09 22:38:16 +0200)

----------------------------------------------------------------
Jan Glauber (2):
      i2c: octeon: Missing AAK flag in case of I2C_M_RECV_LEN
      i2c: octeon: Avoid printk after too long SMBUS message

Lukasz Gemborowski (1):
      i2c: mux: reg: Provide of_match_table

Mika Westerberg (1):
      i2c: i801: Allow ACPI SystemIO OpRegion to conflict with PCI BAR

Simon Horman (1):
      i2c: mux: refer to i2c-mux.txt

 .../bindings/i2c/i2c-arb-gpio-challenge.txt        |  4 +-
 .../devicetree/bindings/i2c/i2c-demux-pinctrl.txt  |  3 +-
 .../devicetree/bindings/i2c/i2c-mux-gpio.txt       |  6 +-
 .../devicetree/bindings/i2c/i2c-mux-pinctrl.txt    |  4 +-
 .../devicetree/bindings/i2c/i2c-mux-reg.txt        |  6 +-
 drivers/i2c/busses/i2c-i801.c                      | 99 +++++++++++++++++++++-
 drivers/i2c/busses/i2c-octeon.c                    | 17 ++--
 drivers/i2c/muxes/i2c-mux-reg.c                    |  1 +
 8 files changed, 119 insertions(+), 21 deletions(-)

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXXFEHAAoJEBQN5MwUoCm2xLIP/iEEWvq/u+p0qny73kXc/Mrx
mitTkp2tm/0anCvYWNxrqTawSX8bukTmKU9rk8cqvz19FKrSy8mC9PUVMVpoLiAJ
A9bIepEUDCSWwIcvj2jvTiHo20EZBQfdjV8VzM6bayzceUl+UsIm+JzXIoY7vLor
MwEDMpdvpdAa8JXWSN5nQPOAQsZ//KLNp1LIKtOmeEBh2xBI1RY2AJNvFqZExYZx
cAsDSSoJz1ZEM4nKlMNq2J03lCBx/jE+ujQc8O+PIDHo1CvrpFuHh06j4bnEbcz+
rEZvpJRkmuRTYcw5Tdian7/ulMMqPI4JFZy2oTAubuax8vqrguSllGseGmBHXawO
NrvVxmr8iACpJ5lVpo7AIgTtb5K6Lh3xgcmZO5Xvd08v9uOTf4QxoTNzwBPvnp1b
3b1bqlpmlk1xRuUuGbJnWLDSyEMG1ThzzcdK9MTKShkCmcVUTWyz31Nf7SKUL3Pt
qyOJt8mrQNzWB+88HgmBwO8844Tc2bMAv3btkNyLpJoBGRbxSKOZALvcFVbq81Qj
MHmwARAztcPp277gu4zHe4XoMBx4oGhaixx2ezQvW5p/z6xuuEDheXZv4tWFjP5u
aLYg54HAkLeNpTQkoAz/MhVXwjE4870rgQ0ectGXiIbkWzXgnkcSAmdth7qUiuAs
VHTnN1Fo+Fp6T8b2sEka
=7y37
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
