Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FDC347FF4;
	Sat, 31 Jan 2026 03:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769829755; cv=none; b=O3ZncwIck1qLtC79S+RDzX3Ys3StlKaMdDq5mXnyihqGFfXhHBoOCW/PnpV1GJ99vD1iNXyKuI6TzjNUNjWjlf1Uu33kkD3kIr9nXnyGP30lV7q6n7BZAHI03Nffh7OFkswgOUJS5D33ib+SLgiz/37IWZSLzQZlv5tYuFGlNn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769829755; c=relaxed/simple;
	bh=jJj8iWe6Gr6ftvomzWPuCUlaN/ZZYx6tJlWu0Tynlrw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Efwj2hZOzWqk17d4QMCxLVHbSOexsChZ+kLFe91XROsZeLsV8eb953i07xDEB0/WwxsBWnRstD/MK9yak6dYzWxbs7Tt4YsQ5wldT2cqLi8RNkGWQeY03jzL9jbmDI1zWjGgcDkhAo+9sqT9LWjkfLQftCNlbUuqSoVv3MlfcbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lbtcx+XK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lbtcx+XK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5047C4CEF7;
	Sat, 31 Jan 2026 03:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769829754;
	bh=jJj8iWe6Gr6ftvomzWPuCUlaN/ZZYx6tJlWu0Tynlrw=;
	h=Date:From:To:Cc:Subject:From;
	b=Lbtcx+XKh1kjJqOUqRDdNM4bI+Y0OG9NRS2GEoAhVk4csuUY2BrkjXJP8FOGyyNqO
	 rtK02VbkV38l9oNipB99L8Yc1q27d4/ofDnR05UWlLo63Det47q6uXHDO4HuF9FHX4
	 IL+ZeaSVCqBW7nz6EwrxSFaYTXGzbDU7KHvgTUMGVJ23Wr4k8GpSS5Scdf8QOkZGQO
	 /acuoAzQIrUVED3f57cbBr19aVpfu383rdf81qex36rqObDsPH5euoXuiVB+3pkJ5N
	 F1ZQjsvEVpP+kZ66entwsTS+D66EO0kw0EgHHCzsCjNiay5HqOW7Fqze7ZyelF/CrK
	 MUcCMO4EL8T7g==
Date: Sat, 31 Jan 2026 04:22:31 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: lkml <linux-kernel@vger.kernel.org>, 
	linux-i2c <linux-i2c@vger.kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Subject: [GIT PULL] i2c-host for v6.20
Message-ID: <aX1yiVJq7s2iJ3FH@zenone.zhora.eu>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Wolfram,

here is the pull request for the merge window. Most of the
patches that did not make it were not ready to be merged due to
missing or pending reviews. Some were ready only very late and I
did not feel comfortable including them. For a smaller set I
simply ran out of time to follow up properly.

This pull request includes general cleanups across several
drivers, a DesignWare core refactoring to enable mode switching,
runtime PM improvements for imx-lpi2c, a new lan9691 I2C driver
and targeted fixes in rtl9300, spacemit and tegra.

I will try to collect a few more minor patches for next week, so
if it is OK with you, please expect a second part.

Thank you and I wish you a great weekend,
Andi

The following changes since commit 8f0b4cce4481fb22653697cced8d0d04027cb1e8:

  Linux 6.19-rc1 (2025-12-14 16:05:07 +1200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux.git tags/i2c-host-6.20

for you to fetch changes up to 51e8ce3630878fa6083e1eec84f58f49ec85089b:

  i2c: designware: Remove an unnecessary condition (2026-01-22 14:43:57 +0100)

----------------------------------------------------------------
i2c-host for v6.20

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

----------------------------------------------------------------
Andy Shevchenko (11):
      units: Add HZ_PER_GHZ
      i2c: mlxbf: Use HZ_PER_GHZ constant instead of custom one
      i2c: mt65xx: Use HZ_PER_GHZ constant instead of plain number
      i2c: nomadik: Use HZ_PER_GHZ constant instead of plain number
      i2c: rk3x: Use HZ_PER_GHZ constant instead of plain number
      i2c: st: Use HZ_PER_GHZ constant instead of plain number
      i2c: synquacer: Use HZ_PER_GHZ constant instead of plain number
      i2c: mlxbf: Remove unused bus speed definitions
      i2c: mlxbf: Use HZ_PER_KHZ in the driver
      i2c: designware: Remove not-going-to-be-supported code for Baikal SoC
      i2c: designware: Use device_is_compatible() instead of custom approach

Artem Shimko (1):
      i2c: designware: Replace magic numbers with named constants

Benoît Monin (3):
      i2c: designware: Optimize flag reading in i2c_dw_read()
      i2c: designware: Sort compatible strings in alphabetical order
      i2c: designware: Add dedicated algorithm for AMD NAVI

Carlos Song (1):
      i2c: imx-lpi2c: Add runtime PM support for IRQ and clock management on i.MX8QXP/8QM

David Laight (1):
      drivers/i2c/busses: use min() instead of min_t()

Encrow Thorne (2):
      dt-bindings: i2c: spacemit: add optional resets
      i2c: k1: add reset support

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

Robert Marko (1):
      dt-bindings: i2c: atmel,at91sam: add microchip,lan9691-i2c

Rosen Penev (2):
      i2c: rtl9300: remove const cast
      i2c: rtl9300: use of instead of fwnode

Troy Mitchell (1):
      i2c: spacemit: drop useless spaces

 Documentation/devicetree/bindings/i2c/atmel,at91sam-i2c.yaml |   1 +
 Documentation/devicetree/bindings/i2c/spacemit,k1-i2c.yaml   |   3 ++
 drivers/i2c/busses/Kconfig                                   |  11 ++-----
 drivers/i2c/busses/Makefile                                  |   2 +-
 drivers/i2c/busses/i2c-amd-mp2-pci.c                         |   8 +++--
 drivers/i2c/busses/i2c-designware-amdisp.c                   |   4 +--
 drivers/i2c/busses/i2c-designware-common.c                   | 246 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------
 drivers/i2c/busses/i2c-designware-core.h                     |  40 ++++++++++++++---------
 drivers/i2c/busses/i2c-designware-master.c                   | 187 ++++++++++++++++--------------------------------------------------------------------------------------------
 drivers/i2c/busses/i2c-designware-platdrv.c                  |  72 ++----------------------------------------
 drivers/i2c/busses/i2c-designware-slave.c                    | 127 +++++++++++--------------------------------------------------------------
 drivers/i2c/busses/i2c-imx-lpi2c.c                           |  84 +++++++++++++++++++++++++++++++++++++++++--------
 drivers/i2c/busses/i2c-k1.c                                  |  19 +++++++----
 drivers/i2c/busses/i2c-mlxbf.c                               |  13 ++------
 drivers/i2c/busses/i2c-mt65xx.c                              |  11 ++++---
 drivers/i2c/busses/i2c-nomadik.c                             |   7 +++--
 drivers/i2c/busses/i2c-rk3x.c                                |  12 +++----
 drivers/i2c/busses/i2c-rtl9300.c                             |  17 +++++-----
 drivers/i2c/busses/i2c-st.c                                  |   3 +-
 drivers/i2c/busses/i2c-synquacer.c                           |   3 +-
 drivers/i2c/busses/i2c-tegra.c                               |   2 --
 include/linux/units.h                                        |   3 ++
 22 files changed, 423 insertions(+), 452 deletions(-)
