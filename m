Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A1136D9EB;
	Mon, 15 Jun 2026 10:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781520875; cv=none; b=W0mPzITXih22+RiSsVcFfTJwbiQqz48NWM/i4dSVonW00CxR//yuUj6AxFToaD9JRsyc3Z0gD/ClbrL3kCFbXIae0QzAidl4qzZeimOzle4sgFq3SN2XSwEj3whI10s6yp4PFlR8/gcqXG0RrrGYKyHTCDcwJmAw04Q0/rrO4Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781520875; c=relaxed/simple;
	bh=3xS2l4eL9dAlx+NJB6HvrPX6CwmjP+083M9spFqr69U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=o/TJb9jOO85ohFrHal8AJq1bNcBmNzOz5omuWYXY4t0qflbq81JDV4OKT0nbdTg6gX0ClwZ3L7b7FwLymIA8FrfP9E2oKMlgahPoES77xfHnZGNXl8QnH3LkLg1KwtssFNT3MlwUlMkVTvEGvzvRI8Jhu5aCmxkvLpWxLiYjm9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L0M3tEIM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L0M3tEIM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C63A1F000E9;
	Mon, 15 Jun 2026 10:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781520871;
	bh=8ExId+XGq85hWbetd3p+3XaacbftUo5xYJ3P8ywPwrw=;
	h=Date:From:To:Cc:Subject;
	b=L0M3tEIMPjrA0KcE9q0RZauuSiIfl8XwLnThIq2/O74AngfeORycTk5q70e3/GHj+
	 Gz09vsmtqaXIUObNTCV65evKEu9r3gqT7KXwJkuOKrGiZ9Tymh6bdF3td/4ehuXOma
	 mW8Aq9QFeev0vG1Q/Q792q0W6mdxVwp1MnHc2sJSJF9ySLh5XEOCfmlyA3gYsPGkvq
	 R0hn2wJNQc9s6tz6sI+8Vb1up45nuyrQFDNaNtqKJHbKYiL8Z/3193cvcY/b0xu4Pl
	 OjNXgcmCsNayEO3ci3oX9f/v3kNaIYc1jUra9ZsUBj3umVHO8zYdGY8zlw/LWMz+sX
	 OBrLlvaKwtpVQ==
Date: Mon, 15 Jun 2026 12:54:26 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	lkml <linux-kernel@vger.kernel.org>, linux-i2c <linux-i2c@vger.kernel.org>, 
	Andi Shyti <andi.shyti@kernel.org>
Subject: [GIT PULL] i2c for v7.2
Message-ID: <ai_WLu9JC7GXTU_t@zenone.zhora.eu>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Linus,

this is my first pull request sent to you, and I hope I have
learned enough from Wolfram over the years not to make a mess of
things.

The branch is still called "i2c-host"; for the next cycle I will
rename it to simply "i2c".

This pull request is mostly made of cleanups and small
infrastructure improvements across the I2C core, drivers and
bindings. It also adds support for three drivers and a few new
compatibles.

This is only part 1 of the pull request. I am planning a second
one for the middle of the merge window with a few fixes, some
patches with dependencies that have been tested anyway and a
handful of small outstanding changes.

Thank you,
Andi

The following changes since commit 254f49634ee16a731174d2ae34bc50bd5f45e731:

  Linux 7.1-rc1 (2026-04-26 14:19:00 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux.git tags/i2c-7.2-part1

for you to fetch changes up to 90220ddfa8e2c93e26af2cd51d6158ca2243c622:

  i2c: mxs: add missing kernel-doc for struct mxs_i2c_dev members (2026-06-10 23:10:34 +0200)

----------------------------------------------------------------
i2c for v7.2

Two major cleanup across drivers and core code:
 - use named initializers in device ID tables
 - replace dev_err() with dev_err_probe()

Drivers:
- at24: use named initializers for arrays of i2c_device_data
- at91: add MCHP_LAN966X_PCI dependency
- cadence: add shutdown callback
- k1: enable by default on SpacemiT
- mxs: improve documentation
- qcom-geni: use pm_runtime_force_suspend/resume for system sleep
- tegra:
   - disable fair arbitration on non-MCTP buses
   - allocate DMA buffers from the correct DMA device
- designware:
   - handle active target shutdown cleanly
   - add shutdown callbacks for platform and PCI drivers
   - adopt the new PM_RUNTIME_ACQUIRE() helpers

DT bindings:
- convert davinci bindings to DT schema

Core and muxes:
- acpi: report missing I2C resources as -ENOENT
- gpiolib: add gpiod_is_single_ended() helper for I2C GPIO users
- i2c-mux-reg: add generic firmware node support
- a set of 10 patches from Johan Hovold fixing adapter
  registration races, cleanup paths and resource management
  issues

New support:
- DesignWare LECA0003 (ACPI ID)
- Loongson LS2K0300 I2C controller (new driver)
- Qualcomm CCI Glymur and Shikra compatibles

----------------------------------------------------------------
Abdurrahman Hussain (1):
      i2c: mux: reg: use device property accessors

Ajay Neeli (1):
      i2c: cadence: Add shutdown handler

Akhil R (2):
      i2c: tegra: use dmaengine_get_dma_device() for DMA buffer allocation
      i2c: tegra: Disable fair arbitration for non-MCTP buses

Andi Shyti (3):
      Merge tag 'ib-gpio-add-gpiod-is-single-ended-for-v7.2' into i2c/i2c-host
      Merge tag 'at24-updates-for-v7.2-rc1' into i2c/i2c-host
      Merge remote-tracking branch 'wsa/i2c/fix-registration' into i2c/i2c-host

Andy Shevchenko (1):
      i2c: acpi: Return -ENOENT when no resources found in i2c_acpi_client_count()

Binbin Zhou (2):
      dt-bindings: i2c: loongson,ls2x: Add ls2k0300-i2c compatible
      i2c: ls2x-v2: Add driver for Loongson-2K0300 I2C controller

Chaitanya Sabnis (1):
      dt-bindings: i2c: convert davinci i2c to dt-schema

Enrico Zanda (10):
      i2c: tiny-usb: Replace dev_err() with dev_err_probe() in probe function
      i2c: tegra: Replace dev_err() with dev_err_probe() in probe function
      i2c: sun6i-p2wi: Replace dev_err() with dev_err_probe() in probe function
      i2c: stm32f7: Replace dev_err() with dev_err_probe() in probe function
      i2c: stm32f4: Replace dev_err() with dev_err_probe() in probe function
      i2c: stm32: Replace dev_err() with dev_err_probe() in probe function
      i2c: st: Replace dev_err() with dev_err_probe() in probe function
      i2c: sprd: Replace dev_err() with dev_err_probe() in probe function
      i2c: sis96x: Replace dev_err() with dev_err_probe() in probe function
      i2c: sis630: Replace dev_err() with dev_err_probe() in probe function

Herve Codina (1):
      i2c: at91: Add MCHP_LAN966X_PCI dependency

Iker Pedrosa (1):
      i2c: busses: make K1 driver default for SpacemiT platforms

Jie Li (1):
      gpiolib: add gpiod_is_single_ended() helper

Johan Hovold (10):
      i2c: core: fix irq domain leak on adapter registration failure
      i2c: core: fix hang on adapter registration failure
      i2c: core: fix NULL-deref on adapter registration failure
      i2c: core: fix adapter probe deferral loop
      i2c: core: fix adapter debugfs creation
      i2c: core: disable runtime PM on adapter registration failure
      i2c: core: fix adapter registration race
      i2c: core: fix adapter deregistration race
      i2c: core: clean up bus id allocation
      i2c: core: clean up adapter registration error label

Nihal Kumar Gupta (2):
      dt-bindings: i2c: qcom-cci: Document Shikra compatible
      dt-bindings: i2c: qcom-cci: Document Glymur compatible

Praveen Talari (1):
      i2c: qcom-geni: Use pm_runtime_force_{suspend,resume} helpers

Rosen Penev (1):
      i2c: mxs: add missing kernel-doc for struct mxs_i2c_dev members

Stepan Ionichev (1):
      i2c: bcm-kona: fix spelling mistake in timeout-check comment

Thomas Lin (1):
      i2c: designware: Add ACPI ID LECA0003 for LECARC SoCs

Uwe Kleine-König (The Capable Hub) (5):
      eeprom: at24: Use named initializers for arrays of i2c_device_data
      i2c: icy: Use named initializer for zorro_device_id arrays
      i2c: Use named initializers for arrays of i2c_device_data
      i2c: designware-pcidrv: Consistently define pci_device_ids using named initializers
      i2c: eg20t: Consistently define pci_device_ids using named initializers

William A. Kennington III (4):
      i2c: designware: Introduce shutdown exported function
      i2c: designware: Convert PCI driver to use shutdown hook
      i2c: designware: Convert platform driver to use shutdown hook
      i2c: designware: Handle active target cleanly

Xueqin Luo (1):
      i2c: designware: Use PM_RUNTIME_ACQUIRE()/PM_RUNTIME_ACQUIRE_ERR()

 Documentation/devicetree/bindings/i2c/i2c-davinci.txt        |  43 ------
 Documentation/devicetree/bindings/i2c/loongson,ls2x-i2c.yaml |   4 +
 Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml      |   4 +
 Documentation/devicetree/bindings/i2c/ti,davinci-i2c.yaml    |  70 ++++++++++
 MAINTAINERS                                                  |   3 +-
 drivers/acpi/acpi_apd.c                                      |   7 +
 drivers/gpio/gpiolib.c                                       |  22 +++
 drivers/i2c/busses/Kconfig                                   |  14 +-
 drivers/i2c/busses/Makefile                                  |   1 +
 drivers/i2c/busses/i2c-bcm-kona.c                            |   2 +-
 drivers/i2c/busses/i2c-cadence.c                             |  20 +++
 drivers/i2c/busses/i2c-designware-common.c                   |  36 ++++-
 drivers/i2c/busses/i2c-designware-core.h                     |   1 +
 drivers/i2c/busses/i2c-designware-master.c                   |  31 ++--
 drivers/i2c/busses/i2c-designware-pcidrv.c                   |  92 ++++++------
 drivers/i2c/busses/i2c-designware-platdrv.c                  |  15 ++
 drivers/i2c/busses/i2c-eg20t.c                               |  10 +-
 drivers/i2c/busses/i2c-icy.c                                 |   4 +-
 drivers/i2c/busses/i2c-ls2x-v2.c                             | 544 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/i2c/busses/i2c-mxs.c                                 |   8 ++
 drivers/i2c/busses/i2c-qcom-geni.c                           |  24 ++--
 drivers/i2c/busses/i2c-sis630.c                              |  31 ++--
 drivers/i2c/busses/i2c-sis96x.c                              |  30 ++--
 drivers/i2c/busses/i2c-sprd.c                                |  13 +-
 drivers/i2c/busses/i2c-st.c                                  |  34 ++---
 drivers/i2c/busses/i2c-stm32.c                               |   4 +-
 drivers/i2c/busses/i2c-stm32f4.c                             |  53 +++----
 drivers/i2c/busses/i2c-stm32f7.c                             |  78 ++++-------
 drivers/i2c/busses/i2c-sun6i-p2wi.c                          |  55 +++-----
 drivers/i2c/busses/i2c-tegra.c                               |  37 ++++-
 drivers/i2c/busses/i2c-tiny-usb.c                            |   5 +-
 drivers/i2c/i2c-core-acpi.c                                  |   7 +-
 drivers/i2c/i2c-core-base.c                                  | 177 +++++++++++++----------
 drivers/i2c/i2c-slave-eeprom.c                               |  16 +--
 drivers/i2c/i2c-slave-testunit.c                             |   2 +-
 drivers/i2c/i2c-smbus.c                                      |   2 +-
 drivers/i2c/muxes/i2c-mux-ltc4306.c                          |   4 +-
 drivers/i2c/muxes/i2c-mux-pca9541.c                          |   4 +-
 drivers/i2c/muxes/i2c-mux-pca954x.c                          |  36 ++---
 drivers/i2c/muxes/i2c-mux-reg.c                              |  90 +++++-------
 drivers/misc/eeprom/at24.c                                   |  62 ++++----
 include/linux/gpio/consumer.h                                |   5 +
 42 files changed, 1200 insertions(+), 500 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/i2c/i2c-davinci.txt
 create mode 100644 Documentation/devicetree/bindings/i2c/ti,davinci-i2c.yaml
 create mode 100644 drivers/i2c/busses/i2c-ls2x-v2.c
