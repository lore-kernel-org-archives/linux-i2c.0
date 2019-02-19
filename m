From: Gareth Williams <gareth.williams.jx@renesas.com>
Subject: [PATCH v2 0/2] dt: i2c: Add support for bus clock
Date: Tue, 19 Feb 2019 15:10:40 +0000
Message-ID: <1550589042-11096-1-git-send-email-gareth.williams.jx@renesas.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Wolfram Sang <wsa@the-dreams.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Gareth Williams <gareth.williams.jx@renesas.com>, devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

The Synopsys I2C Controller has a bus clock that some SoCs require to access
the registers. This series also details the new clock property in the bindings
documentation.

v2:
 - Use new devm_clk_get_optional() function as it simplifies handling when
   the optional clock is not present.

Phil Edworthy (2):
  dt: snps,designware-i2c: Add clock bindings documentation
  i2c: designware: Add support for a bus clock

 Documentation/devicetree/bindings/i2c/i2c-designware.txt |  9 +++++++++
 drivers/i2c/busses/i2c-designware-common.c               | 12 +++++++++++-
 drivers/i2c/busses/i2c-designware-core.h                 |  1 +
 drivers/i2c/busses/i2c-designware-platdrv.c              |  5 +++++
 4 files changed, 26 insertions(+), 1 deletion(-)

-- 
2.7.4
