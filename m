From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH 3/3] i2c: designware: Find bus speed from ACPI
Date: Mon,  6 Jun 2016 14:26:23 +0300
Message-ID: <1465212383-24639-4-git-send-email-jarkko.nikula@linux.intel.com>
References: <1465212383-24639-1-git-send-email-jarkko.nikula@linux.intel.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:45884 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752085AbcFFL0i (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 6 Jun 2016 07:26:38 -0400
In-Reply-To: <1465212383-24639-1-git-send-email-jarkko.nikula@linux.intel.com>
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
