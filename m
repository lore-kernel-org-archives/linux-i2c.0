Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792537078;
	b=Wb9AQkLQSGp/hoDGDiUeGX14c9s+JL3R1sCPrwwQU2yZAOh1igA7sRw55LI58ZLdqMLv
	 70gJWrZyYNp78N+vkFXcdltpUAx65jzBFId7U4Tj6v8k52O09Mn9B2dzXgTeVVnvyu1z5
	 cw7xwTIKnRFIHZ/FtP9rtlWJ7QLj5Kvq27w0zV+oHYq7IXrNxi1dO+HgrNVek5CIhp/eF
	 TRk4vO6Ie4jtlVmcORWn5bjM8B5V5IEoHXU1c/Nk4FXSwZTKvUegy2KMkG7X5exWN+uAu
	 f5b8+1TjnRFKGqRouqv/cai159X7/K1klcIDSa4r7IbVvV7AxDYjQ7+kW2XFCI/3q0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792537078;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition;
	bh=LUNshFZqZaFXxW/P7Xs7mH7j1VD6LUQBsJ4amtdaKOc=;
	b=2/nAgEM8kYtmOLYtTqSG5r5CR/1SimVgJM4962B1zF58rvsi7f7cpmVSv42e3gJmNvHa
	 yULJO9rZd4EzjlVOeuLJRnW/UXYecZB26Rf/msUu6dH29NcU4rgZh9EdSxO/thu4hviv9
	 bbrVvoy5bt/fGNwlL0z0RmzXPnfo35UnEjUD/gwHYJfth7VdeowE/jji6lMfZO70V1dXh
	 BdOBdR3cj5wIYqrwz86Q11g5bBti4jQIL+4PBEzh5o8uE0/Vma/PmDHnalEf9R3fZM7gm
	 ABcktRO/y8szeZkLgbEttGuxI8un43GQUCurI2vMaJM4cquMdj1gdjBa7xd8MCT64hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lMYKqaK6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77E3606A319;
	Tue, 20 Oct 2026 22:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lMYKqaK6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADC8D1F000C9;
	Tue, 20 Oct 2026 22:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792537077;
	bh=LUNshFZqZaFXxW/P7Xs7mH7j1VD6LUQBsJ4amtdaKOc=;
	h=Date:From:To:Cc:Subject;
	b=lMYKqaK6AwmXSVYEXzBVi36tj/ewM5C/ubAsQ2ptbZbh6bSlFp4R9xVw76zn5Y2iX
	 Y+ZMatOe7NCAkXSWfMg37xyRqny8rXAMvXBs5mDqtClA6IouQWa/Pq7iACKoq2nFqf
	 Ttvn/43IruIP+c8agDhI6BNNCMv4f43pbFLKjfMr4KHDT/yKBVey9/jBZK/XSpInH6
	 kT3DSP6BkOvhOe2GHgxomiax3uDXZzuKb6TQmZd6B5xD9HWq5sceYD76lyY62YC3zZ
	 McRNo92sPqtMuqMj31C7/KPEdh4WzkKgvV040SQTJou8ZmouzS0uu4akUOnmcqTaMk
	 +7NeajAtOstlQ==
Date: Wed, 21 Oct 2026 00:57:54 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: lkml <linux-kernel@vger.kernel.org>, 
	linux-i2c <linux-i2c@vger.kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Subject: [GIT PULL] i2c for v7.4, part 1
Message-ID: <atfu5GAnLLhoGn9N@zenone.zhora.eu>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

here is the first part of the I2C pull request for v7.4.

The main changes are the new Novatek NT72676 driver, the qcom-cci
clock and timing updates and a collection of smaller driver, core
and DT binding improvements.

Between family commitments and conferences, a few patches didn't
make it into this round. If the merge window gets an extra third
week, I'll use it to catch up with some of them.

A second part will definitely follow, probably on Sunday.  I
already have some patches queued up, a few waiting for
dependencies to be fixed and others simple enough to be safely
included.

Meanwhile, I wish you great holidays, both under and above the
water.

Andi

The following changes since commit cee9395acd8043be0644b25c34bfa86623f2b935:

  Linux 7.3-rc1 (2026-08-30 13:34:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux.git tags/i2c-7.4-part1

for you to fetch changes up to 0f6be986ad0eb6fe7338d963a14eaf0dee87677d:

  i2c: imx-lpi2c: remove dmaengine_desc_free() (2026-10-13 15:55:40 +0200)

----------------------------------------------------------------
i2c for v7.4, part 1

A mix of new hardware support, driver improvements and smaller
core, DT binding and documentation cleanups.

Core and helpers:

- acpi: run ASUS and Dell touchpads at 100 kHz to avoid lag
- core: return bool from check_functionality() and update users
- smbus: limit block reads to the caller's buffer size
- acpi: mark I2C transfer buffers as DMA-safe

Drivers:

- qcom-geni: several firmware node and runtime PM improvements
- qcom-cci: several patches rework clock selection and timings
- qcom-cci: enable SCL clock stretching
- imx-lpi2c: fix DMA mapping device selection and cleanup
- designware: tune RX FIFO thresholds to reduce interrupts
- i801: respect SPD write protection when probing DDR5 modules
- bcm2835: fully initialize clock configuration data

Generic cleanups:

- mux: simplify channel lookup and firmware node handling
- core, busses: tidy up ACPI device ID tables
- docs: clarify adapter lookup and fix a client driver example
- xlnx: update maintainer for Xilinx IIC bindings
- ljca: remove redundant adapter deletion

New support and DT bindings:

- add DW compatibles for Synaptics SL2610 and UltraRISC DP1000
- allow six DMA channels for R-Car Gen5
- add Allwinner A733 compatible to mv64xxx bindings
- add support for Novatek NT72676 (new driver)

----------------------------------------------------------------
Ahmad Byagowi (2):
      i2c: mux: Factor out channel node lookup
      i2c: mux: Propagate firmware nodes to channel adapters

Alex Tran (1):
      i2c: busses: Use pm_runtime_resume_and_get()

Ben Huang (3):
      dt-bindings: i2c: Add Novatek NT72676 I2C controller
      i2c: nt72676: Add Novatek NT72676 I2C controller driver
      MAINTAINERS: Add entry for Novatek NT72676 I2C controller driver

Dmitry Torokhov (1):
      i2c: smbus: make i2c_smbus_read_block_data() safer

Felix Gu (1):
      i2c: ljca: drop redundant explicit adapter deletion

Frank Li (1):
      i2c: imx-lpi2c: remove dmaengine_desc_free()

Geert Uytterhoeven (1):
      i2c: bcm2835: Make sure clk_init_data is fully initialized

Hans de Goede (2):
      i2c: qcom-geni: Use device_set_node() helper
      i2c: acpi: Use I2C_M_DMA_SAFE in acpi_gsb_i2c_[read|write]_bytes()

Harinn (1):
      i2c: acpi: Force ASUE140D touchpads to 100 kHz

Hitesh Patel (1):
      i2c: qcom-cci: always enable SCL clock stretching

Jerome Brunet (1):
      dt-bindings: i2c: mv64xxx: Add Allwinner A733 compatible string

Jia Wang (1):
      dt-bindings: i2c: dw: Add compatible for UltraRISC DP1000 SoC

Jisheng Zhang (1):
      dt-bindings: i2c: dw: Add Synaptics sl2610 i2c

Johan Hovold (1):
      i2c: core: document preference for i2c_get_adapter_by_fwnode()

Krzysztof Kozlowski (1):
      dt-bindings: i2c: xlnx,xps-iic-2.00.a: Drop bouncing mocean-labs.com

Loic Poulain (5):
      i2c: qcom-cci: Switch msm8953 to the CCI v2 timing/rate config
      i2c: qcom-cci: Support per-mode CCI clock rates
      i2c: qcom-cci: Add 19.2 MHz timings for the v2 CCI
      i2c: qcom-cci: Share the timing table across CCI revisions
      i2c: qcom-cci: Enforce the required CCI clock rate

Manuel Ebner (1):
      docs: i2c: writing-clients: Add missing end of command

Mukesh Kumar Savaliya (2):
      i2c: qcom-geni: Use modern PM operation macros
      i2c: qcom-geni: Simplify PM resume error handling

Navon John Lukose (1):
      i2c: designware: size the RX FIFO threshold to the queued transfer

Oleg Keri (1):
      i2c: qcom-cci: skip core clock rates the clock cannot provide

Pawel Zalewski (2):
      i2c: i2c-core-acpi: use named initializers for acpi_device_id
      i2c: busses: use named initializers for acpi_device_id

Peng Fan (1):
      i2c: imx-lpi2c: use dmaengine_get_dma_device() for DMA mapping

Thorsten Blum (2):
      media: i2c: isl7998x: Inline i2c_check_functionality() check
      i2c: Change return type to bool for i2c_check_functionality()

Wolfram Sang (1):
      dt-bindings: i2c: renesas,rcar-i2c: allow 6 DMA channels

Yo-Jung (1):
      i2c: i801: Gate SPD instantiation on SPD Write Disable bit

YuXin Xiao (1):
      i2c: acpi: Add DELL0A86 to i2c_acpi_force_100khz_device_ids

 .../bindings/i2c/marvell,mv64xxx-i2c.yaml          |   1 +
 .../bindings/i2c/novatek,nt72676-i2c.yaml          |  76 +++
 .../devicetree/bindings/i2c/renesas,rcar-i2c.yaml  |   4 +-
 .../bindings/i2c/snps,designware-i2c.yaml          |  16 +
 .../bindings/i2c/xlnx,xps-iic-2.00.a.yaml          |   2 +-
 Documentation/i2c/writing-clients.rst              |   2 +-
 MAINTAINERS                                        |   7 +
 drivers/i2c/busses/Kconfig                         |  12 +
 drivers/i2c/busses/Makefile                        |   1 +
 drivers/i2c/busses/i2c-amd-asf-plat.c              |   2 +-
 drivers/i2c/busses/i2c-amd-mp2-plat.c              |   2 +-
 drivers/i2c/busses/i2c-bcm2835.c                   |   2 +-
 drivers/i2c/busses/i2c-cros-ec-tunnel.c            |   2 +-
 drivers/i2c/busses/i2c-designware-master.c         |  15 +-
 drivers/i2c/busses/i2c-designware-platdrv.c        |  42 +-
 drivers/i2c/busses/i2c-gpio.c                      |   2 +-
 drivers/i2c/busses/i2c-hisi.c                      |   2 +-
 drivers/i2c/busses/i2c-i801.c                      |  10 +-
 drivers/i2c/busses/i2c-imx-lpi2c.c                 |  20 +-
 drivers/i2c/busses/i2c-imx.c                       |   2 +-
 drivers/i2c/busses/i2c-ljca.c                      |   9 -
 drivers/i2c/busses/i2c-ls2x.c                      |   2 +-
 drivers/i2c/busses/i2c-mlxbf.c                     |   8 +-
 drivers/i2c/busses/i2c-nt72676.c                   | 725 +++++++++++++++++++++
 drivers/i2c/busses/i2c-qcom-cci.c                  | 334 ++++++----
 drivers/i2c/busses/i2c-qcom-geni.c                 |  33 +-
 drivers/i2c/busses/i2c-qup.c                       |   2 +-
 drivers/i2c/busses/i2c-scmi.c                      |   8 +-
 drivers/i2c/busses/i2c-synquacer.c                 |   4 +-
 drivers/i2c/busses/i2c-tegra.c                     |   8 +-
 drivers/i2c/busses/i2c-usbio.c                     |  12 +-
 drivers/i2c/busses/i2c-viai2c-zhaoxin.c            |   2 +-
 drivers/i2c/busses/i2c-xgene-slimpro.c             |   6 +-
 drivers/i2c/busses/i2c-xlp9xx.c                    |   6 +-
 drivers/i2c/i2c-core-acpi.c                        |  20 +-
 drivers/i2c/i2c-core-base.c                        |   3 +
 drivers/i2c/i2c-core-smbus.c                       |  24 +-
 drivers/i2c/i2c-mux.c                              |  98 +--
 drivers/media/i2c/isl7998x.c                       |   3 +-
 include/linux/i2c.h                                |  23 +-
 40 files changed, 1241 insertions(+), 311 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i2c/novatek,nt72676-i2c.yaml
 create mode 100644 drivers/i2c/busses/i2c-nt72676.c
