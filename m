From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH 8/8] i2c: designware: Find bus speed from ACPI
Date: Fri, 12 Aug 2016 17:02:54 +0300
Message-ID: <1471010574-28598-9-git-send-email-jarkko.nikula@linux.intel.com>
References: <1471010574-28598-1-git-send-email-jarkko.nikula@linux.intel.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:54302 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752596AbcHLODW (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 12 Aug 2016 10:03:22 -0400
In-Reply-To: <1471010574-28598-1-git-send-email-jarkko.nikula@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Weifeng Voon <weifeng.voon@intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>

Fast mode is the default speed of i2c-designware which can be overridden
by platform data or by "clock-frequency" device property. Even though
the ACPI 5.1 can pass device properties via _DSD method, shipping systems
define the connection speed between I2C host and each slave in their
I2cSerialBus resources. Which means speed is not defined per bus but per
slave.

As there is now support in i2c-core to find the bus speed from ACPI use
that to set up the bus speed prior registering the I2C adapter.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 drivers/i2c/busses/i2c-designware-platdrv.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index cb846cb50512..0b42a12171f3 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -157,7 +157,7 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 	struct i2c_adapter *adap;
 	struct resource *mem;
 	int irq, r;
-	u32 ht = 0;
+	u32 acpi_speed, ht = 0;
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
@@ -192,6 +192,10 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 					 &dev->clk_freq);
 	}
 
+	acpi_speed = i2c_acpi_find_bus_speed(&pdev->dev);
+	if (acpi_speed)
+		dev->clk_freq = acpi_speed;
+
 	if (has_acpi_companion(&pdev->dev))
 		dw_i2c_acpi_configure(pdev);
 
-- 
2.8.1
