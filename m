From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3 2/2] i2c: designware: Some broken DSTDs use 1MiHz instead of 1MHz
Date: Thu, 13 Jul 2017 15:45:02 +0200
Message-ID: <20170713134502.10816-2-hdegoede@redhat.com>
References: <20170713134502.10816-1-hdegoede@redhat.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34152 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751157AbdGMNpJ (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 13 Jul 2017 09:45:09 -0400
In-Reply-To: <20170713134502.10816-1-hdegoede@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-i2c@vger.kernel.org, stable@vger.kernel.org

At least the Acer Iconia Tab8 / aka W1-810 uses 1MiHz instead of
1MHz for one of its busses, fix this up to 1MHz instead of failing
the probe of that bus.

This fixes the accelerometer on the Acer Iconia Tab8 not working.

Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/i2c/busses/i2c-designware-platdrv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index d139b156f9c9..143a8fd582b4 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -298,6 +298,9 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 	}
 
 	acpi_speed = i2c_acpi_find_bus_speed(&pdev->dev);
+	/* Some broken DSTDs use 1MiHz instead of 1MHz */
+	if (acpi_speed == 1048576)
+		acpi_speed = 1000000;
 	/*
 	 * Find bus speed from the "clock-frequency" device property, ACPI
 	 * or by using fast mode if neither is set.
-- 
2.13.0
