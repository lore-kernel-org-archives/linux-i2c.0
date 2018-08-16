From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v4 0/7] Add support for MSCC Ocelot i2c
Date: Thu, 16 Aug 2018 10:45:14 +0200
Message-ID: <20180816084521.16289-1-alexandre.belloni@bootlin.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, James Hogan <jhogan@kernel.org>
Cc: Paul Burton <paul.burton@mips.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Allan Nielsen <allan.nielsen@microsemi.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>
List-Id: linux-i2c@vger.kernel.org

Hello,

Because the designware IP was not able to handle the SDA hold time before
version 1.11a, MSCC has its own implementation. Add support for it and then add
i2c on ocelot boards.

I would expect patches 1 to 5 to go through the i2c tree and 6-7 through
the mips tree once patch 4 has been reviewed by the DT maintainers.

This is based on top of i2c-next

Changes in v4:
 - collected review and ack tags
 - split bindings to a separate patch

Changes in v3:
 - collected review tags
 - fixed build warnings on 64bit machines

Changes in v2:
 - removed first patch as a similar one is in i2c-next
 - rebase on top of i2c-next
 - Added two patches to implement ideas from Andy


Alexandre Belloni (7):
  i2c: designware: use generic table matching
  i2c: designware: move #ifdef CONFIG_OF to the top
  i2c: designware: allow IP specific sda_hold_time
  i2c: designware: document MSCC Ocelot bindings
  i2c: designware: add MSCC Ocelot support
  MIPS: dts: mscc: Add i2c on ocelot
  MIPS: dts: mscc: enable i2c on ocelot_pcb123

 .../bindings/i2c/i2c-designware.txt           |  7 ++-
 arch/mips/boot/dts/mscc/ocelot.dtsi           | 18 ++++++
 arch/mips/boot/dts/mscc/ocelot_pcb123.dts     |  6 ++
 drivers/i2c/busses/i2c-designware-common.c    |  2 +
 drivers/i2c/busses/i2c-designware-core.h      |  4 ++
 drivers/i2c/busses/i2c-designware-platdrv.c   | 63 +++++++++++++++----
 6 files changed, 86 insertions(+), 14 deletions(-)

-- 
2.18.0
