Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CAF25392A;
	Sun, 15 Feb 2026 10:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771149914; cv=none; b=ImCLJxwzoaXRXEdtx+G8bfm07WNF5DxtbQDf/2wN6CNghx5pQAeuMQBOOSMoRx2MvcpbCf1B6qzJhbD48D61xNozLaTUL/CVtt6/5RLfdZ8/Tj6e2MFsijx+vQ4aBRgmu7rrbrrVFXCQsBNfRt59aKyry21ZyxLkjJ9PMheA7Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771149914; c=relaxed/simple;
	bh=i9NKyrficJsW+b6es96SkLkfMTHPKnVmoqwxIrrcOU8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fuXAMossok5DSn1aUeQAz9PrMAmw+69uLLBW1TEm7GGC+GBsHFJcLROcEsQ4xsa0eBCubCwCWND/v4VPY1rlEXuXddQGvRa9XtE7p5FT+5vjxDdWk3VdkEhv8HxY9DyFe3AIz9Apj46CGVyUx/iGIwlvelFPFgLxQsxZ6VRp/K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uP31Oaaj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uP31Oaaj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82C86C4CEF7;
	Sun, 15 Feb 2026 10:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771149914;
	bh=i9NKyrficJsW+b6es96SkLkfMTHPKnVmoqwxIrrcOU8=;
	h=Date:From:To:Cc:Subject:From;
	b=uP31OaajNrmuXes/J4nP2slhTCjUB+KbZlTX4H6cIHFzU7NDFicjxYsUlkJeZBYwN
	 vs6K9qDdXUDR0G3p6n4KMFluMt9KcSxQcXZansziPV4tDKi1bfgEK7QJ0+i6MK6BvI
	 4a5P70P3VPmVECpLnmht9L3nBz7lh8mO32VWPlxs0jFfSq96kptZ55TwZ5NPF9JYWv
	 J8SKmO/aHUO6wFPq++eBWPR0kTCZJsthcWRzHMCmVM9unFixMISSTMKsq5MTPrZ47p
	 1gGXm2nobqO3Zjv/H9XJQRslNi+bQnSHlC13NrhsYjiA14h8gj7aSQoRxpLoSzjWVr
	 MxbrsGEcLkwlg==
Date: Sun, 15 Feb 2026 11:05:10 +0100
From: Wolfram Sang <wsa@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andi Shyti <andi.shyti@kernel.org>
Subject: [PULL REQUEST] i2c-for-7.0-rc1
Message-ID: <aZGaVvjGs7vP4lHv@ninjato>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZEsLxSDogxa/7Lst"
Content-Disposition: inline


--ZEsLxSDogxa/7Lst
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following changes since commit f8f9c1f4d0c7a64600e2ca312dec824a0bc2f1da:

  Linux 6.19-rc3 (2025-12-28 13:24:26 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git tags/i2c-for-=
7.0-rc1

for you to fetch changes up to efdc383d1cc28d45cbf5a23b5ffa997010aaacb4:

  i2c: imx-lpi2c: fix SMBus block read NACK after byte count (2026-02-08 18=
:17:09 +0100)

----------------------------------------------------------------
i2c-for-7.0-rc1

- core: cleaner fwnode usage
- tegra: timing improvements and Tegra264 support
- lpi2c: fix SMBus block read NACK after byte count
- amd-mp2, designware, mlxbf, rtl9300, spacemit, tegra: cleanups
- designware: use a dedicated algorithm for AMD Navi
- designware: replace magic numbers with named constants
- designware: replace min_t() with min() to avoid u8 truncation
- designware: refactor core to enable mode switching
- imx-lpi2c: add runtime PM support for IRQ and clock handling
- lan9691-i2c: add new driver
- rtl9300: use OF helpers directly and avoid fwnode handling
- spacemit: add bus reset support
- units: add HZ_PER_GHZ and use it in several i2c drivers

at24 updates for v7.0-rc1

- add a set of new compatibles to DT bindings
- use dev_err_probe() consistently in the driver

----------------------------------------------------------------
Akhil R (4):
      i2c: tegra: Use separate variables for fast and fastplus
      i2c: tegra: Update Tegra256 timing parameters
      i2c: tegra: Add HS mode support
      i2c: tegra: Add Tegra264 support

Andy Shevchenko (14):
      units: Add HZ_PER_GHZ
      i2c: mlxbf: Use HZ_PER_GHZ constant instead of custom one
      i2c: mt65xx: Use HZ_PER_GHZ constant instead of plain number
      i2c: nomadik: Use HZ_PER_GHZ constant instead of plain number
      i2c: rk3x: Use HZ_PER_GHZ constant instead of plain number
      i2c: st: Use HZ_PER_GHZ constant instead of plain number
      i2c: synquacer: Use HZ_PER_GHZ constant instead of plain number
      i2c: core: Check for error pointer for fwnode
      i2c: core: Replace custom implementation of device_match_fwnode()
      i2c: core: Use dev_fwnode()
      i2c: mlxbf: Remove unused bus speed definitions
      i2c: mlxbf: Use HZ_PER_KHZ in the driver
      i2c: designware: Remove not-going-to-be-supported code for Baikal SoC
      i2c: designware: Use device_is_compatible() instead of custom approach

Artem Shimko (1):
      i2c: designware: Replace magic numbers with named constants

Bartosz Golaszewski (1):
      eeprom: at24: use dev_err_probe() consistently

Beno=C3=AEt Monin (3):
      i2c: designware: Optimize flag reading in i2c_dw_read()
      i2c: designware: Sort compatible strings in alphabetical order
      i2c: designware: Add dedicated algorithm for AMD NAVI

Carlos Song (2):
      i2c: imx-lpi2c: Add runtime PM support for IRQ and clock management o=
n i.MX8QXP/8QM
      i2c: imx-lpi2c: fix SMBus block read NACK after byte count

David Laight (1):
      drivers/i2c/busses: use min() instead of min_t()

Encrow Thorne (2):
      dt-bindings: i2c: spacemit: add optional resets
      i2c: k1: add reset support

FUKAUMI Naoki (1):
      dt-bindings: eeprom: at24: Add compatible for Belling BL24C04A/BL24C1=
6F

Guixin Liu (1):
      i2c: tegra: remove unused rst

Heikki Krogerus (6):
      i2c: designware: Remove useless driver specific option for I2C target
      i2c: designware: Remove unnecessary function exports
      i2c: designware: Combine some of the common functions
      i2c: designware: Combine the init functions
      i2c: designware: Enable mode swapping
      i2c: designware: Remove an unnecessary condition

Johan Hovold (1):
      i2c: amd-mp2: clean up amd_mp2_find_device()

Kartik Rajput (2):
      i2c: tegra: Do not configure DMA if not supported
      i2c: tegra: Add support for SW mutex register

Louis-Alexis Eyraud (1):
      dt-bindings: i2c: i2c-mt65xx: Add compatible for MT8189 SoC

Luca Weiss (2):
      dt-bindings: eeprom: at24: Add compatible for Giantec GT24P64A
      dt-bindings: eeprom: at24: Add compatible for Puya P24C128F

Robert Marko (1):
      dt-bindings: i2c: atmel,at91sam: add microchip,lan9691-i2c

Rosen Penev (2):
      i2c: rtl9300: remove const cast
      i2c: rtl9300: use of instead of fwnode

Troy Mitchell (1):
      i2c: spacemit: drop useless spaces

Wolfram Sang (2):
      Merge tag 'at24-updates-for-v7.0-rc1' of git://git.kernel.org/pub/scm=
/linux/kernel/git/brgl/linux into i2c/for-mergewindow
      Merge tag 'i2c-host-6.20' of git://git.kernel.org/pub/scm/linux/kerne=
l/git/andi.shyti/linux into i2c/for-mergewindow


with much appreciated quality assurance from
----------------------------------------------------------------
Alex Elder (1):
      (Rev.) i2c: spacemit: drop useless spaces

Andi Shyti (1):
      (Rev.) units: Add HZ_PER_GHZ

Andy Shevchenko (7):
      (Rev.) i2c: designware: Remove an unnecessary condition
      (Rev.) i2c: designware: Combine the init functions
      (Rev.) i2c: designware: Remove unnecessary function exports
      (Rev.) i2c: designware: Remove useless driver specific option for I2C=
 target
      (Rev.) i2c: designware: Add dedicated algorithm for AMD NAVI
      (Rev.) i2c: designware: Sort compatible strings in alphabetical order
      (Rev.) i2c: designware: Optimize flag reading in i2c_dw_read()

AngeloGioacchino Del Regno (8):
      (Rev.) dt-bindings: i2c: i2c-mt65xx: Add compatible for MT8189 SoC
      (Rev.) i2c: synquacer: Use HZ_PER_GHZ constant instead of plain number
      (Rev.) i2c: st: Use HZ_PER_GHZ constant instead of plain number
      (Rev.) i2c: rk3x: Use HZ_PER_GHZ constant instead of plain number
      (Rev.) i2c: nomadik: Use HZ_PER_GHZ constant instead of plain number
      (Rev.) i2c: mt65xx: Use HZ_PER_GHZ constant instead of plain number
      (Rev.) i2c: mlxbf: Use HZ_PER_GHZ constant instead of custom one
      (Rev.) units: Add HZ_PER_GHZ

Chris Packham (2):
      (Rev.) i2c: rtl9300: use of instead of fwnode
      (Rev.) i2c: rtl9300: remove const cast

Frank Li (2):
      (Rev.) i2c: imx-lpi2c: fix SMBus block read NACK after byte count
      (Rev.) i2c: imx-lpi2c: Add runtime PM support for IRQ and clock manag=
ement on i.MX8QXP/8QM

Heiko Stuebner (1):
      (Rev.) i2c: rk3x: Use HZ_PER_GHZ constant instead of plain number

Jon Hunter (6):
      (Rev.) i2c: tegra: Add Tegra264 support
      (Rev.) i2c: tegra: Add support for SW mutex register
      (Rev.) i2c: tegra: Add HS mode support
      (Rev.) i2c: tegra: Update Tegra256 timing parameters
      (Rev.) i2c: tegra: Use separate variables for fast and fastplus
      (Rev.) i2c: tegra: Do not configure DMA if not supported

Konrad Dybcio (1):
      (Rev.) dt-bindings: eeprom: at24: Add compatible for Puya P24C128F

Linus Walleij (2):
      (Rev.) i2c: nomadik: Use HZ_PER_GHZ constant instead of plain number
      (Rev.) units: Add HZ_PER_GHZ

Patrice Chotard (1):
      (Rev.) i2c: st: Use HZ_PER_GHZ constant instead of plain number

Shyam Sundar S K (1):
      (Rev.) i2c: amd-mp2: clean up amd_mp2_find_device()

Troy Mitchell (2):
      (Rev.) i2c: k1: add reset support
      (Rev.) dt-bindings: i2c: spacemit: add optional resets

Wolfram Sang (7):
      (Rev.) i2c: synquacer: Use HZ_PER_GHZ constant instead of plain number
      (Rev.) i2c: st: Use HZ_PER_GHZ constant instead of plain number
      (Rev.) i2c: rk3x: Use HZ_PER_GHZ constant instead of plain number
      (Rev.) i2c: nomadik: Use HZ_PER_GHZ constant instead of plain number
      (Rev.) i2c: mt65xx: Use HZ_PER_GHZ constant instead of plain number
      (Rev.) i2c: mlxbf: Use HZ_PER_GHZ constant instead of custom one
      (Rev.) units: Add HZ_PER_GHZ

 Documentation/devicetree/bindings/eeprom/at24.yaml |   4 +
 .../devicetree/bindings/i2c/atmel,at91sam-i2c.yaml |   1 +
 .../devicetree/bindings/i2c/i2c-mt65xx.yaml        |   1 +
 .../devicetree/bindings/i2c/spacemit,k1-i2c.yaml   |   3 +
 drivers/i2c/busses/Kconfig                         |  11 +-
 drivers/i2c/busses/Makefile                        |   2 +-
 drivers/i2c/busses/i2c-amd-mp2-pci.c               |   8 +-
 drivers/i2c/busses/i2c-designware-amdisp.c         |   4 +-
 drivers/i2c/busses/i2c-designware-common.c         | 246 +++++++++++++++--
 drivers/i2c/busses/i2c-designware-core.h           |  40 ++-
 drivers/i2c/busses/i2c-designware-master.c         | 187 ++-----------
 drivers/i2c/busses/i2c-designware-platdrv.c        |  72 +----
 drivers/i2c/busses/i2c-designware-slave.c          | 127 ++-------
 drivers/i2c/busses/i2c-imx-lpi2c.c                 | 191 ++++++++++---
 drivers/i2c/busses/i2c-k1.c                        |  19 +-
 drivers/i2c/busses/i2c-mlxbf.c                     |  13 +-
 drivers/i2c/busses/i2c-mt65xx.c                    |  11 +-
 drivers/i2c/busses/i2c-nomadik.c                   |   7 +-
 drivers/i2c/busses/i2c-rk3x.c                      |  12 +-
 drivers/i2c/busses/i2c-rtl9300.c                   |  17 +-
 drivers/i2c/busses/i2c-st.c                        |   3 +-
 drivers/i2c/busses/i2c-synquacer.c                 |   3 +-
 drivers/i2c/busses/i2c-tegra.c                     | 306 +++++++++++++++++=
----
 drivers/i2c/i2c-core-base.c                        |  10 +-
 drivers/misc/eeprom/at24.c                         |  20 +-
 include/linux/units.h                              |   3 +
 26 files changed, 781 insertions(+), 540 deletions(-)

--ZEsLxSDogxa/7Lst
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmmRmlYACgkQFA3kzBSg
KbZDxw/+KJs2GmA6uG3347E3i6upkvDyIUo3xeMk9PXH6Z57hf9f1sV+dBHgMkWS
mhKtvBquQoiLo/pphvt2llEU7znJCEb/T+7orW6VXME01Q7V226HzJS6NvbO76EE
efyASFHvUKKVkdUJiComELAteo38T+tLK4hE6QlcRPIzYwOSjwYw789oTGA4pJKa
zsAlkT1nLOI3SxpzfkBWZA/LXRcOpbRfVAIx6YT83doQCsS/xd/ZQfocKymQIRYh
qOJ5cHz+mYAr0T/OoPKqT9WGEn7P5/46mgYS5YJjewy9aF5/b3efWqBLjRTPw7Vc
n3MJIoamzYISnui2PVqTkzlkunje+K6sSTpceMODSWXFboTj3wkKit0Av86SwmBP
eAAkSk7rNwrnoAFC908/q29SvD4sxDkDqs693wFkXJajDkP1WYjFp0HOqDq02b6z
rWuCOpZ5Xi5WtiFXFLN/HpH6wKSBHAAZBohTdsnOPIMZLs6zlMNrneTSCgg+s4+U
pe9FBMfsgcVNKk08sVU/odXMuu/PUu76Zqd/xneDKlU+fQ8nPQUtzsKoz6S03bN2
X0BYRBbfHeUNwwoVR4fXdPOrFuubxufyLAbr5ooq7SifiOqPWkHsyN1SH1wMAd+5
nW0mdtImwRPUXl1Xxhqi46uW1ilJxD7qi67xUCjO3/ihrXlqZi8=
=GfDW
-----END PGP SIGNATURE-----

--ZEsLxSDogxa/7Lst--
