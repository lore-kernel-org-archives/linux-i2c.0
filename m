Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65772275B03;
	Fri, 20 Feb 2026 09:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771578461; cv=none; b=WUySkHp7d6CaoOYVksoyzFSdDADo1JsFKtAfLrVL5JNgZRu1AyWLQ6HW/bhDsd7rEPAHfEp2T+d9BLmJGOtZTlnWlho7C8URwFAH6ilPQB7d8QxW5hVP6Dbze3cGRZtMuFLN+4sQ3J/oiNus/PV0yppJSRgZK1wqfWjAJaNCfP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771578461; c=relaxed/simple;
	bh=zVU4YHAMPuyP3TXSeujd3zW7idIB926oNCh+q5/7yB4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=m26U86evcy3P5CYT5GhHFmPag3c3pRvpp81fopvN783KjzMwPDtVwdBZ2z1g4BybkXlEfEa+18m4o8gclVhaiih9+K5HcnjWl+M+N7baJoJJrCZjf36c3wZ4HE7dKmjKPJKAUDzIcpi1X1oBB4J4vQ8pr95Nd/yK1OLr4DFzRK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ib/aad0/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ib/aad0/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3310AC116C6;
	Fri, 20 Feb 2026 09:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771578460;
	bh=zVU4YHAMPuyP3TXSeujd3zW7idIB926oNCh+q5/7yB4=;
	h=Date:From:To:Cc:Subject:From;
	b=ib/aad0/ilZtVB9BCsExTVe3/fiYJ2pN21Ye7o2gtfEKtTaWGxqA0rNxSYFFAf2n7
	 kY4o7uxXxm6Ot0ZIeTccwgNaGQ41/TxXkMhEjhLIYch6szO+5YXxRMrjRh/V1hg+mY
	 x+dhvt5/hPueXiS1tu9iLwF3r9PjVzkVFMb6h1gqgvZEytNuMSZm2L0152I1yIcFq+
	 4Y5x4XSfGNk9H+Z8BaptXH2Rpx6L2WTnM5Y8qt1/rgKPoVVjreJBqcw/ZHaHfkrsO+
	 Lw7fvhdmQJGv6gsbyIKq1x/SPr+g5XQQNfMgTsDTqvDQ9kf3rw4bxOFaFbhlR+14Zw
	 ic1wMWiwTW0fg==
Date: Fri, 20 Feb 2026 10:07:37 +0100
From: Wolfram Sang <wsa@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andi Shyti <andi.shyti@kernel.org>
Subject: [PULL REQUEST] i2c-for-7.0-part2
Message-ID: <aZgkWTsMn1zWAlJa@ninjato>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uyoyAyrsjlv2nq/r"
Content-Disposition: inline


--uyoyAyrsjlv2nq/r
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Linus,

here is the second part refactoring the designware driver for this
cycle. Some easy ID additions and cleanups for other drivers added.

Please pull.

   Wolfram


The following changes since commit 2b7a25df823dc7d8f56f8ce7c2d2dac391cea9c2:

  Merge tag 'mm-nonmm-stable-2026-02-18-19-56' of git://git.kernel.org/pub/=
scm/linux/kernel/git/akpm/mm (2026-02-18 21:40:16 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git tags/i2c-for-=
7.0-part2

for you to fetch changes up to 709cc48d3d01facaeb1eec3d93e1e1fb2fb21717:

  Merge branch 'i2c/i2c-host-2' of git://git.kernel.org/pub/scm/linux/kerne=
l/git/andi.shyti/linux into i2c/for-mergewindow (2026-02-19 15:11:15 +0100)

----------------------------------------------------------------
i2c-for-7.0-part2

designware:
- refactor the transfer path to support I2C_M_STOP
- handle pm runtime by using the active auto try macros
- handle controllers lacking explicit START and STOP conditions
- general cleanups

qualcomm: add support for qcs8300-cci
amd8111: general cleanups
cp2112: add DT bindings

----------------------------------------------------------------
Andy Shevchenko (1):
      i2c: designware: Remove dead code in AMD ISP case

Artem Shimko (2):
      i2c: designware-platdrv: simplify reset control
      i2c: designware-platdrv: fix cleanup on probe failure

Beno=C3=AEt Monin (3):
      i2c: designware: Implement I2C_M_STOP support
      i2c: designware: Use runtime PM macro for auto-cleanup
      i2c: designware: Support of controller with IC_EMPTYFIFO_HOLD_MASTER =
disabled

Danny Kaehn (1):
      dt-bindings: i2c: Add CP2112 HID USB to SMBus Bridge

Filippo Muscher=C3=A0 (2):
      i2c: amd8111: Remove spaces in MODULE_* macros
      i2c: amd8111: switch to devm_ functions

Nihal Kumar Gupta (1):
      dt-bindings: i2c: qcom-cci: Document qcs8300 compatible

Wolfram Sang (1):
      Merge branch 'i2c/i2c-host-2' of git://git.kernel.org/pub/scm/linux/k=
ernel/git/andi.shyti/linux into i2c/for-mergewindow


with much appreciated quality assurance from
----------------------------------------------------------------
Andy Shevchenko (3):
      (Rev.) i2c: designware: Support of controller with IC_EMPTYFIFO_HOLD_=
MASTER disabled
      (Rev.) i2c: designware: Use runtime PM macro for auto-cleanup
      (Rev.) i2c: designware: Implement I2C_M_STOP support

Bryan O'Donoghue (1):
      (Rev.) dt-bindings: i2c: qcom-cci: Document qcs8300 compatible

Pratap Nirujogi (1):
      (Rev.) i2c: designware: Remove dead code in AMD ISP case

Rob Herring (Arm) (1):
      (Rev.) dt-bindings: i2c: Add CP2112 HID USB to SMBus Bridge

Vladimir Zapolskiy (1):
      (Rev.) dt-bindings: i2c: qcom-cci: Document qcs8300 compatible

 .../devicetree/bindings/i2c/qcom,i2c-cci.yaml      |   2 +
 .../devicetree/bindings/i2c/silabs,cp2112.yaml     | 100 +++++++++++++
 drivers/i2c/busses/i2c-amd8111.c                   |  30 ++--
 drivers/i2c/busses/i2c-designware-amdisp.c         |  13 +-
 drivers/i2c/busses/i2c-designware-common.c         |  20 +++
 drivers/i2c/busses/i2c-designware-core.h           |   3 +
 drivers/i2c/busses/i2c-designware-master.c         | 162 +++++++++++++++--=
----
 drivers/i2c/busses/i2c-designware-platdrv.c        |  42 ++----
 8 files changed, 266 insertions(+), 106 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i2c/silabs,cp2112.yaml

--uyoyAyrsjlv2nq/r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmmYJFkACgkQFA3kzBSg
KbYGThAAlFZagcB3MP4JDLKMigUqur2fUkykz30rQaULN3ZMJ+9grrJCwpeFTLUy
L4Ghc/kuJG42N3qIBrt6o7LAwwZn3bpKdc01nh8aWArDR9NH7WkHbxKF40NnTjin
IoPprtcxLMNcB5X4N/Rhg5qby2Ge0dWBfHtOIHw5Lte0qrSyypnj1yfmFeQqs60D
WdmkXUILxRWAE1RFiKG0Wod2dadktOmqky0XaIZpXpBaUcWw16tyTL4fxkOAwcVz
WOO7PFBWfFEAMYCC8meeJ99YWyPpXpxyA8hH3Bg3jBOwyLywb0aDgVMtzHtWLbt7
9CpKOMuuMlw0Jv2wVsh1tt5IjXyeAnjS5AEd6ixl68+gV3ncJPr86Fv2kKIHJawF
zcZaSo5gPNwo9ymAVinQrb+QNhWYBo17g58+leG3ERqfuwQIZWyGbksob5wLGAlC
QEFuul/bDvaK9TASWjs/5e7gUv08ykj1SfvAqRDs5otwp31mlivarJYPK08MFvWA
ZObKy6cx18H//UMw96segb2jcgTZteqnbZF6rjhqTihE4vNDzIAtCTxSqiefY4qV
edUXxpwMuHkObv0f1zxfbzxfw24ixk/xsuaqb/WKJqf1vCZSly6RbxmL/yuiZlYJ
gejjMaT3E+KVgvavFquptm1ab7C4S+Ac8zWfcdhRLTZV89vJaNU=
=dufV
-----END PGP SIGNATURE-----

--uyoyAyrsjlv2nq/r--
