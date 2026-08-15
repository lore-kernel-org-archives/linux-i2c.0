Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3805025B091;
	Sat, 15 Aug 2026 10:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786790294; cv=none; b=FCR3bFrytUIjDEpS1qzkHTOiuoqB5Ai8aISQRCNPjv337n0vwwHqINZ0LjmDTZUmVLWMEypO0eBfsquwGXyGNDHcTiX5TPrNw+uZktq+m0XgulCTmAJ5+FeVEAW61tr6p60kGlWGZ6qGiI5ewU2b/AcI26v5ussX015RMZnI0RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786790294; c=relaxed/simple;
	bh=E+L214Y6531LNyH/ib+DxxKNdsa3Ox7TaCTqEib+wYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=I6wjm328jPTC/+U519Qkkgj5edG8K5mUYySwS/L3wfVl8bZzN6qToqnx5g94am/Hnnt97yDE4Wqib550adNAVgBaNr9n+M3ewscgQ1pX7NCsLLcgU6T6aenHUpeyI0ep74LzbfFkEXJcbbvqz0O3lmIaDL4rNYnEUwfCd4PViVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TZouXbPm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TZouXbPm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E00C1F000E9;
	Sat, 15 Aug 2026 10:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786790292;
	bh=m7PwOt+EZEa9A8ruDUrtwIK2F40BynaFLzwg4FliVLY=;
	h=Date:From:To:Cc:Subject;
	b=TZouXbPmeOBqRAj47tAjN37B3T1Uj48Ghz0H3Ip096Lk9hnj7lt23VoDEnTWDqGXW
	 UqFZFhqhRgGrTRvobMB0KKhPtgeI22zlkSlpzbee/ZbzbfiiN7+KeLUChDlf28XHAl
	 BjYu9eyB8JNDa11CPV7AE2u0/bJgy6fGgladoTxgoUxJr4xaEG97xZhMeWJMEr/zFg
	 tRyKirWolX8wMaA3nx9v3d3OJiLpw5SJPPGNTR8hPEC/mJvQTFNqZxg8wIlAmKGtEP
	 uIMuOYIQwVX6ZCdQn6/I1j2MsE/CGu47I+NSwK4LfOWxFB+ewhzHLO/hZoOYEm10tw
	 AoupMXnqKsu1w==
Date: Sat, 15 Aug 2026 12:38:09 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: lkml <linux-kernel@vger.kernel.org>, 
	linux-i2c <linux-i2c@vger.kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Subject: [GIT PULL] i2c for v7.3, part 1
Message-ID: <aoBAaw7d1A6-a5PJ@zenone.zhora.eu>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

here is the first part of the I2C pull request for v7.3. I expect
to send a second part next Saturday, as a few patches still have
dependencies and a few others are left over.

The main changes are support for shared SCL lines in i2c-gpio,
a larger qcom-geni update covering tracing and transfer recovery
and support for R-Car Gen5.

The rest is mostly smaller driver, core and DT binding updates.

Thanks,
Andi

The following changes since commit dc59e4fea9d83f03bad6bddf3fa2e52491777482:

  Linux 7.2-rc1 (2026-06-28 12:01:31 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux.git tags/i2c-7.3-part1

for you to fetch changes up to 18ca2ce160ffff977f28456039f2475a3b500bc0:

  i2c: core: support recovery for single-ended GPIOs (2026-07-29 23:38:13 +0200)

----------------------------------------------------------------
i2c for v7.3

Core and helpers:
- support bus recovery with single-ended GPIOs
- acpi: clean up resource handling
- acpi: force ELAN1300 to 100 kHz
- algo-bit: allow consumers to skip the optional bus test

Drivers:
- use generic bus frequency definitions in nomadik,
  octeon-core, microchip-corei2c, k1, davinci and pnx
- i2c-gpio: support multiple buses sharing the same SCL line
- qup: propagate clock enable failures
- spacemit: configure SCL timing and clean up clock handling
- amd-asf: guard against oversized firmware length

qcom-geni:
- add tracepoints for bus setup, interrupts and errors
- use dedicated completion events for abort and reset
- distinguish address and data NACK handling
- cancel transfers before falling back to abort
- simplify runtime PM and resource management
- refactor resource and serial engine initialization

DT bindings:
- convert Altera bindings to DT schema
- convert Axxia bindings to DT schema

New support:
- R-Car Gen5 and R-Car X5H
- Axiado AX3005
- Qualcomm Nord SA8797P
- Qualcomm SA8255p

----------------------------------------------------------------
Abhijeeth Babu (1):
      i2c: acpi: Force ELAN1300 touchpads to 100 kHz

Andy Shevchenko (7):
      i2c: acpi: Free resource list at appropriate time
      i2c: pnx: Use generic definitions for bus frequencies
      i2c: davinci: Use generic definitions for bus frequencies
      i2c: k1: Use generic definitions for bus frequencies
      i2c: microchip-corei2c: Use generic definitions for bus frequencies
      i2c: octeon-core: Use generic definitions for bus frequencies
      i2c: nomadik: Use generic definitions for bus frequencies

Chaitanya Sabnis (2):
      dt-bindings: i2c: convert axxia i2c to dt-schema
      dt-bindings: i2c: convert altera i2c to dt-schema

Jie Li (1):
      i2c: core: support recovery for single-ended GPIOs

Markus Stockhausen (2):
      i2c: algo: bit: Allow to skip bit test
      i2c: i2c-gpio: Enhance driver for buses with shared SCL

Minh Le (1):
      dt-bindings: i2c: rcar-i2c: Document R-Car X5H support

Mukesh Kumar Savaliya (1):
      i2c: qcom-geni: Use devm_pm_runtime_enable() for PM management

Paritosh Potukuchi (1):
      i2c: amd-asf: Validate firmware-reported length

Pengpeng Hou (1):
      i2c: qup: Propagate clock enable failures

Praveen Talari (11):
      dt-bindings: i2c: Describe SA8255p
      i2c: qcom-geni: Isolate serial engine setup
      i2c: qcom-geni: Move resource initialization to separate function
      i2c: qcom-geni: Use resources helper APIs in runtime PM functions
      i2c: qcom-geni: Store of_device_id data in driver private struct
      i2c: qcom-geni: Enable I2C on SA8255p Qualcomm platforms
      i2c: qcom-geni: use cancel command before abort on transfer timeout
      i2c: qcom-geni: use dedicated completions for abort and reset events
      i2c: qcom-geni: distinguish address-phase and data-phase NACK
      i2c: qcom-geni: trace: Add trace events for Qualcomm GENI I2C
      i2c: qcom-geni: Add trace events for Qualcomm GENI I2C driver

Shawn Guo (1):
      dt-bindings: i2c: qcom,sa8255p-geni-i2c: Add compatible for Nord SA8797P

Swark Yang (1):
      dt-bindings: i2c: cdns: add Axiado AX3005 I2C variant

Troy Mitchell (2):
      i2c: spacemit: configure ILCR/IWCR for accurate SCL frequency
      i2c: spacemit: drop warning when clock-frequency property is absent

Wolfram Sang (1):
      i2c: rcar: add R-Car Gen5 support

 Documentation/devicetree/bindings/i2c/altr,softip-i2c-v1.0.yaml  |  62 +++++++++++++++++++
 Documentation/devicetree/bindings/i2c/cdns,i2c-r1p10.yaml        |  10 +++-
 Documentation/devicetree/bindings/i2c/i2c-altera.txt             |  39 ------------
 Documentation/devicetree/bindings/i2c/i2c-axxia.txt              |  30 ----------
 Documentation/devicetree/bindings/i2c/lsi,api2c.yaml             |  52 ++++++++++++++++
 Documentation/devicetree/bindings/i2c/qcom,sa8255p-geni-i2c.yaml |  68 +++++++++++++++++++++
 Documentation/devicetree/bindings/i2c/renesas,rcar-i2c.yaml      |   6 ++
 drivers/i2c/algos/i2c-algo-bit.c                                 |   2 +-
 drivers/i2c/busses/Kconfig                                       |   2 +-
 drivers/i2c/busses/i2c-amd-asf-plat.c                            |   4 ++
 drivers/i2c/busses/i2c-davinci.c                                 |   4 +-
 drivers/i2c/busses/i2c-gpio.c                                    | 223 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 drivers/i2c/busses/i2c-k1.c                                      | 183 ++++++++++++++++++++++++++++++++++++++++++++++++++-----
 drivers/i2c/busses/i2c-microchip-corei2c.c                       |   4 +-
 drivers/i2c/busses/i2c-nomadik.c                                 |   4 +-
 drivers/i2c/busses/i2c-octeon-core.h                             |   2 +-
 drivers/i2c/busses/i2c-pnx.c                                     |   3 +-
 drivers/i2c/busses/i2c-qcom-geni.c                               | 456 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------------------------------------------------------------
 drivers/i2c/busses/i2c-qup.c                                     |  31 +++++++---
 drivers/i2c/busses/i2c-rcar.c                                    |  22 +++++--
 drivers/i2c/i2c-core-acpi.c                                      |   6 +-
 drivers/i2c/i2c-core-base.c                                      |   3 +-
 include/linux/i2c-algo-bit.h                                     |   1 +
 include/trace/events/qcom_geni_i2c.h                             |  82 +++++++++++++++++++++++++
 24 files changed, 963 insertions(+), 336 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i2c/altr,softip-i2c-v1.0.yaml
 delete mode 100644 Documentation/devicetree/bindings/i2c/i2c-altera.txt
 delete mode 100644 Documentation/devicetree/bindings/i2c/i2c-axxia.txt
 create mode 100644 Documentation/devicetree/bindings/i2c/lsi,api2c.yaml
 create mode 100644 Documentation/devicetree/bindings/i2c/qcom,sa8255p-geni-i2c.yaml
 create mode 100644 include/trace/events/qcom_geni_i2c.h
