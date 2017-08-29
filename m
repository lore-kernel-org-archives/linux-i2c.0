From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] i2c: designware: Round down ACPI provided clk to nearest supported clk
Date: Tue, 29 Aug 2017 14:08:35 +0200
Message-ID: <20170829120835.17276-1-hdegoede@redhat.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37176 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753246AbdH2MIi (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 29 Aug 2017 08:08:38 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-i2c@vger.kernel.org

The Lenovo Miix2 8 DSDT contains an i2c clk / bus speed of 1700000 Hz
for one if its devices, which is not supported.

This is the second DSDT to show up with an unsupported clk in a short
time, remove the hardcoded fix for DSDTs with a 1 MiHz clock and simply
always round down the clk to the nearest supported value.

Reported-by: russianneuromancer@ya.ru
Fixes: 682c6c2188 ("i2c: designware: Some broken DSTDs use 1MiHz ...")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/i2c/busses/i2c-designware-platdrv.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 57248bccadbc..2b98a173136f 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -256,7 +256,8 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 	struct dw_i2c_dev *dev;
 	u32 acpi_speed, ht = 0;
 	struct resource *mem;
-	int irq, ret;
+	int i, irq, ret;
+	const int supported_speeds[] = { 0, 100000, 400000, 1000000, 3400000 };
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
@@ -297,9 +298,16 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 	}
 
 	acpi_speed = i2c_acpi_find_bus_speed(&pdev->dev);
-	/* Some broken DSTDs use 1MiHz instead of 1MHz */
-	if (acpi_speed == 1048576)
-		acpi_speed = 1000000;
+	/*
+	 * Some DSTDs use a non standard speed, round down to the lowest
+	 * standard speed.
+	 */
+	for (i = 1; i < ARRAY_SIZE(supported_speeds); i++) {
+		if (acpi_speed < supported_speeds[i])
+			break;
+	}
+	acpi_speed = supported_speeds[i - 1];
+
 	/*
 	 * Find bus speed from the "clock-frequency" device property, ACPI
 	 * or by using fast mode if neither is set.
-- 
2.13.4
