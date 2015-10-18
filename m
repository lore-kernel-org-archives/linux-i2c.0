From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PULL REQUEST] i2c for 4.3
Date: Sun, 18 Oct 2015 14:19:48 +0200
Message-ID: <20151018121944.GA5214@katana>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:54973 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752477AbbJRMUC (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sun, 18 Oct 2015 08:20:02 -0400
Content-Disposition: inline
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

here are some bugfixes for the I2C subsystem. Kieran found a flaw in the
recently renewed wake irq handling. Mika handled a user bug report where
the ACPI info turned out to be unusable. I updated MAINTAINERS so that
such bug reports will sooner get to the right people. Geert pointed me
to a problem of some i2c drivers regarding PM which I fixed. Please
pull.

Thanks,

   Wolfram


The following changes since commit 25cb62b76430a91cc6195f902e61c2cb84ade622:

  Linux 4.3-rc5 (2015-10-11 11:09:45 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current

for you to fetch changes up to 56d4b8a24cef5d66f0d10ac778a520d3c2c68a48:

  i2c: designware: Do not use parameters from ACPI on Dell Inspiron 7348 (2015-10-18 14:11:08 +0200)

----------------------------------------------------------------
Kieran Bingham (1):
      i2c: return probe deferred status on dev_pm_domain_attach

Mika Westerberg (1):
      i2c: designware: Do not use parameters from ACPI on Dell Inspiron 7348

Wolfram Sang (4):
      i2c: rcar: enable RuntimePM before registering to the core
      i2c: s3c2410: enable RuntimePM before registering to the core
      i2c: designware-platdrv: enable RuntimePM before registering to the core
      MAINTAINERS: add maintainers for Synopsis Designware I2C drivers

 MAINTAINERS                                 |  9 ++++++++
 drivers/i2c/busses/i2c-designware-platdrv.c | 33 +++++++++++++++++++++++------
 drivers/i2c/busses/i2c-rcar.c               |  7 +++---
 drivers/i2c/busses/i2c-s3c2410.c            |  8 ++++---
 drivers/i2c/i2c-core.c                      | 12 +++++------
 5 files changed, 51 insertions(+), 18 deletions(-)

--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWI45gAAoJEBQN5MwUoCm2aFgP+wcJcnaoItFpczFmFIBzryfw
1ZE7RSGQsKMIiQgVezfSUaXTG/hGv7+0NzBFQgCcdXKdwU1j1Z1PuRCMp0am7wGi
qdkGdeWB+Idkcc+k/xJSi9oOr0etIhw4SYBVEpzBvI86G37Szgomb4S5qahvu/KG
8mesicWspZs1WU0rvU56rxHwMBbGE2CBjL5TLpdUkR39wjQke/9+6fhYyrOW7rsR
njQcWjNpMA+AveOsgI5VM71JZ0jVUnZ5hG8r0t7ZQWyGOkansQBWYmgBhkop1ouj
w7Luz1UzUi8U70uxEWKB30On6HzjEeM2MnURXGj7npVbzsh9pfYXtjmDe5weYt49
pXqImFahrHcIgHCegfdWU6QAEHVrYzVHp2JVLSQcpAXMJtwnWudWD7eaKr0ElwG6
BMSlEGchvcjsnzTOSx+PFQVNTy3ZNxHWAwmNU60h0RxlTkulhb0744LFF2Uwau8z
sYyKYLpBykQMUElVFUGJl39H07N7a2E909JCd9EjwAQU4yNXBvbH2rab4MVRO9GX
D/P4Xjc6COxeSpaRNHeEevLWO3MfkvXohdwQA3O53qaTFZMrtCpUv417IGh3ckyS
6QsjJl+BUBdEOGgtLrzBzA5cWKDQzx2PeVYCanU8qVaQ2PXyqIzeCKyYVUWuGNY4
9BqyCI2eu5gZIZJfpEJo
=ZrKc
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--
