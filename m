From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v2 0/6] Add support for MSCC Ocelot i2c
Date: Tue, 31 Jul 2018 15:47:34 +0200
Message-ID: <20180731134740.441-1-alexandre.belloni@bootlin.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, James Hogan <jhogan@kernel.org>
Cc: Paul Burton <paul.burton@mips.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Allan Nielsen <allan.nielsen@microsemi.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>
List-Id: linux-i2c@vger.kernel.org

Hi,

Because the designware IP was not able to handle the SDA hold time before
version 1.11a, MSCC has its own implementation. Add support for it and then add
i2c on ocelot boards.

I would expect patches 1 to 4 to go through the i2c tree and 5-6 through
the mips tree once patch 4 has been reviewed by the DT maintainers.

Changes in v2:
 - removed first patch as a similar one is in i2c-next
 - rebase on top of i2c-next
 - Added two patches to implement ideas from Andy

Alexandre Belloni (6):
  i2c: designware: use generic table matching
  i2c: designware: move #ifdef CONFIG_OF to the top
  i2c: designware: allow IP specific sda_hold_time
  i2c: designware: add MSCC Ocelot support
  mips: dts: mscc: Add i2c on ocelot
  mips: dts: mscc: enable i2c on ocelot_pcb123

 .../bindings/i2c/i2c-designware.txt           |  9 ++-
 arch/mips/boot/dts/mscc/ocelot.dtsi           | 18 ++++++
 arch/mips/boot/dts/mscc/ocelot_pcb123.dts     |  6 ++
 drivers/i2c/busses/i2c-designware-common.c    |  2 +
 drivers/i2c/busses/i2c-designware-core.h      |  4 ++
 drivers/i2c/busses/i2c-designware-platdrv.c   | 62 +++++++++++++++----
 6 files changed, 87 insertions(+), 14 deletions(-)

-- 
2.18.0
