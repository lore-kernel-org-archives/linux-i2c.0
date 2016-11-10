From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH] i2c: designware: Allow reduce bus speed by "clock-frequency" property
Date: Thu, 10 Nov 2016 13:37:20 +0200
Message-ID: <20161110113720.16464-1-jarkko.nikula@linux.intel.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:51179 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755338AbcKJLh3 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 10 Nov 2016 06:37:29 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>

Allow more flexibility to bus speed selection. Now if there are I2C
slave connections defined in ACPI the speed of slowest device on the bus
will define the bus speed. However if also "clock-frequency" device
property is defined we should use the slowest of these two.

This is targeted to maker boards where developer may want to connect
slower I2C slave devices to the bus than defined in existing ACPI I2C
slave connections.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 drivers/i2c/busses/i2c-designware-platdrv.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 0b42a12171f3..441dad6e8afa 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -176,9 +176,6 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 	dev->irq = irq;
 	platform_set_drvdata(pdev, dev);
 
-	/* fast mode by default because of legacy reasons */
-	dev->clk_freq = 400000;
-
 	if (pdata) {
 		dev->clk_freq = pdata->i2c_scl_freq;
 	} else {
@@ -193,8 +190,16 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 	}
 
 	acpi_speed = i2c_acpi_find_bus_speed(&pdev->dev);
-	if (acpi_speed)
-		dev->clk_freq = acpi_speed;
+	/*
+	 * Find bus speed from the "clock-frequency" device property, ACPI
+	 * or by using fast mode if neither is set.
+	 */
+	if (acpi_speed && dev->clk_freq)
+		dev->clk_freq = min(dev->clk_freq, acpi_speed);
+	else if (acpi_speed || dev->clk_freq)
+		dev->clk_freq = max(dev->clk_freq, acpi_speed);
+	else
+		dev->clk_freq = 400000;
 
 	if (has_acpi_companion(&pdev->dev))
 		dw_i2c_acpi_configure(pdev);
-- 
2.10.2
