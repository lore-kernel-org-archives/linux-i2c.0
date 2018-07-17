From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 0/5] Add support for MSCC Ocelot i2c
Date: Tue, 17 Jul 2018 13:48:32 +0200
Message-ID: <20180717114837.21839-1-alexandre.belloni@bootlin.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, James Hogan <jhogan@kernel.org>
Cc: Paul Burton <paul.burton@mips.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Allan Nielsen <allan.nielsen@microsemi.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>
List-Id: linux-i2c@vger.kernel.org

Hi,

Because the designware IP was not able to the the SDA hold time, MSCC has
its own implementation. Add support for it and then add i2c on ocelot
boards.

I would expect patches 1 to 3 to go through the i2c tree and 4-5 through
the mips tree once patch 3 has been reviewed by the DT maintainers.

Alexandre Belloni (5):
  i2c: designware: factorize setting SDA hold time
  i2c: designware: allow IP specific sda_hold_time
  i2c: designware: add MSCC Ocelot support
  mips: dts: mscc: Add i2c on ocelot
  mips: dts: mscc: enable i2c on ocelot_pcb123

 .../bindings/i2c/i2c-designware.txt           |  5 ++-
 arch/mips/boot/dts/mscc/ocelot.dtsi           | 19 +++++++++++
 arch/mips/boot/dts/mscc/ocelot_pcb123.dts     |  5 +++
 drivers/i2c/busses/i2c-designware-common.c    | 33 +++++++++++++++++++
 drivers/i2c/busses/i2c-designware-core.h      |  3 ++
 drivers/i2c/busses/i2c-designware-master.c    | 22 +------------
 drivers/i2c/busses/i2c-designware-platdrv.c   | 20 +++++++++++
 drivers/i2c/busses/i2c-designware-slave.c     | 22 +------------
 8 files changed, 86 insertions(+), 43 deletions(-)

-- 
2.18.0
