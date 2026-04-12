Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EB41E8332;
	Sun, 12 Apr 2026 01:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775958225; cv=none; b=R6wj+JbgAzNTdWZPyCsUX/JDwLD6kZCGZ5Unyh0G0NgnUxC7Sug3LE6XLKCGosBGaEknXy6b3/Zo5uz+X6ipWcQQ+hmG4j8Nir4NooP5FSop5o9JpkpecAKlWbQE/yH1QfgmkErG6BMt+F27/nozz/FgtWcinq9wAIstS4VAeeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775958225; c=relaxed/simple;
	bh=75aEW26gyOTDP50JbtZpTir1rn/21wqfzHoiMEVRIO8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PfLbYred44i6dOPPAeEUf5bB82+Rk9F2IOTTy+Gyi0H+JsjWi1MgVNgAY00cwcSfVKiOQwbmOteqW4Dtmfj4VlSFy1N7C4WBEzlHXdmBz6ZnnJRlys7F+ZIR0wPAUMo6C3iTJnQJnq8DAmGqcK90KfbFEICLio2Uz8R+hryZxMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SxC9KvN/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SxC9KvN/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AACA0C116C6;
	Sun, 12 Apr 2026 01:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775958224;
	bh=75aEW26gyOTDP50JbtZpTir1rn/21wqfzHoiMEVRIO8=;
	h=Date:From:To:Cc:Subject:From;
	b=SxC9KvN/yICM4bW85Tj1dGAXbHR5d6YAfkDwxUf7bYtrTuJTbPd+RnvOH4HmsTY/w
	 U63nYNK07Tt330SwfE/b0X8v12puXlpYHA6ai3eKJ2kv/3WqiyJmdCNTI5NyOZ1U3N
	 JWp2J34v0v/44KwFjVMPKcUzsYMSrxvGxtfh6y1LLZjC1+mUzEbW9FZnxBm0Og0mrH
	 UixclXrrVz1l6immnidjMNCfqy7OlXantdo1/nhXkDn2MUQiRnaJNbjkh0LEoF010K
	 H4nctFQtuWTQC1U7xttHMKaYLU1c2rQ7h6Xyly2ZDQ8ujyFY7rKheN/+5CYndJF0NS
	 +hEikZqtOujuA==
Date: Sun, 12 Apr 2026 03:43:40 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: lkml <linux-kernel@vger.kernel.org>, 
	linux-i2c <linux-i2c@vger.kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Subject: [GIT PULL] i2c-host for v7.1, part 1
Message-ID: <adr2UAyCWpT8VwB8@zenone.zhora.eu>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Wolfram,

here's the first part of the merge window pull request.

It has the usual refactoring, cleanups and updates, with no big
surprises. There is also some new hardware support. The main
chunks this time are the xiic and rtl9300 work.

One patch is already queued for part 2, as it needed some
dependencies first and I will keep collecting patches with no
major impact.

Thanks and enjoy the rest of the weekend,
Andi

The following changes since commit 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f:

  Linux 7.0-rc1 (2026-02-22 13:18:59 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux.git tags/i2c-host-7.1-part1

for you to fetch changes up to e43f2df330a1b87c97235e4faade860d15787735:

  i2c: usbio: Add ACPI device-id for NVL platforms (2026-04-10 23:08:42 +0200)

----------------------------------------------------------------
i2c-host for v7.1, part 1

- generic cleanups in npcm7xx, qcom-cci, xiic and designware DT
  bindings

- atr: use kzalloc_flex for alias pool allocation
- ixp4xx: convert bindings to DT schema
- ocores: use read_poll_timeout_atomic() for polling waits
- qcom-geni: skip extra TX DMA TRE for single read messages
- s3c24xx: validate SMBus block length before using it
- spacemit: refactor xfer path and add K1 PIO support
- tegra: identify DVC and VI with SoC data variants
- tegra: support SoC-specific register offsets
- xiic: switch to devres and generic fw properties
- xiic: skip input clock setup on non-OF systems

rtl9300:
- add per-SoC callbacks and clock support for RTL9607C
- add support for new 50 kHz and 2.5 MHz bus speeds
- general refactoring in preparation for RTL9607C support

New support:
- DesignWare GOOG5000 (ACPI HID)
- Intel Nova Lake (ACPI ID)
- Realtek RTL9607C
- SpacemiT K3 binding
- Tegra410 register layout support

----------------------------------------------------------------
Abdurrahman Hussain (7):
      i2c: xiic: switch to devres managed APIs
      i2c: xiic: remove duplicate error message
      i2c: xiic: switch to generic device property accessors
      i2c: xiic: cosmetic cleanup
      i2c: xiic: cosmetic: use resource format specifier in debug log
      i2c: xiic: use numbered adapter registration
      i2c: xiic: skip input clock setup on non-OF systems

Andy Shevchenko (1):
      dt-bindings: i2c: dw: Remove unused bindings

Aniket Randive (1):
      i2c: qcom-geni: Avoid extra TX DMA TRE for single read message in GPI mode

Arun T (1):
      i2c: usbio: Add ACPI device-id for NVL platforms

Greg Kroah-Hartman (1):
      i2c: s3c24xx: check the size of the SMBUS message before using it

Jan Kantert (1):
      i2c: rtl9300: add support for 50 kHz and 2.5 MHz bus speeds

Kartik Rajput (3):
      i2c: tegra: Introduce tegra_i2c_variant to identify DVC and VI
      i2c: tegra: Add logic to support different register offsets
      i2c: tegra: Add support for Tegra410

Krzysztof Kozlowski (1):
      i2c: npcm7xx: Use NULL instead of 0 for pointer

Martin Aberer (1):
      i2c: ocores: Use read_poll_timeout_atomic to avoid false poll timeouts

Moritz Fischer (1):
      i2c: designware: Add a new ACPI HID for GOOG5000 I2C controller

Rosen Penev (1):
      i2c: atr: use kzalloc_flex

Rustam Adilov (8):
      i2c: rtl9300: split data_reg into read and write reg
      i2c: rtl9300: introduce max length property to driver data
      i2c: rtl9300: introduce F_BUSY to the reg_fields struct
      i2c: rtl9300: introduce a property for 8 bit width reg address
      dt-bindings: i2c: realtek,rtl9301-i2c: extend for clocks and RTL9607C support
      i2c: rtl9300: introduce clk struct for upcoming rtl9607 support
      i2c: rtl9300: introduce new function properties to driver data
      i2c: rtl9300: add RTL9607C i2c controller support

Shi Hao (1):
      dt-bindings: i2c: intel,ixp4xx-i2c: Convert to DT schema

Troy Mitchell (2):
      i2c: spacemit: move i2c_xfer_msg()
      i2c: spacemit: introduce pio for k1

Vladimir Zapolskiy (1):
      i2c: qcom-cci: Remove unused CCI_RES_MAX macro definition

Yixun Lan (1):
      dt-bindings: i2c: spacemit: k3: Add compatible

 .../devicetree/bindings/i2c/i2c-iop3xx.txt         |  20 -
 .../devicetree/bindings/i2c/intel,ixp4xx-i2c.yaml  |  41 ++
 .../bindings/i2c/realtek,rtl9301-i2c.yaml          |  15 +
 .../bindings/i2c/snps,designware-i2c.yaml          |   2 -
 .../devicetree/bindings/i2c/spacemit,k1-i2c.yaml   |   6 +-
 drivers/i2c/busses/i2c-designware-platdrv.c        |   1 +
 drivers/i2c/busses/i2c-k1.c                        | 316 +++++++++---
 drivers/i2c/busses/i2c-npcm7xx.c                   |   2 +-
 drivers/i2c/busses/i2c-ocores.c                    |  24 +-
 drivers/i2c/busses/i2c-qcom-cci.c                  |   3 -
 drivers/i2c/busses/i2c-qcom-geni.c                 |  24 +-
 drivers/i2c/busses/i2c-rtl9300.c                   | 195 ++++++--
 drivers/i2c/busses/i2c-s3c2410.c                   |   7 +-
 drivers/i2c/busses/i2c-tegra.c                     | 534 +++++++++++++++------
 drivers/i2c/busses/i2c-usbio.c                     |   1 +
 drivers/i2c/busses/i2c-xiic.c                      |  97 ++--
 drivers/i2c/i2c-atr.c                              |  17 +-
 17 files changed, 939 insertions(+), 366 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/i2c/i2c-iop3xx.txt
 create mode 100644 Documentation/devicetree/bindings/i2c/intel,ixp4xx-i2c.yaml
