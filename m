From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 2/2] i2c: designware: Some broken DSTDs use 1MiHz instead of 1MHz
Date: Mon, 10 Jul 2017 20:45:40 +0200
Message-ID: <20170710184540.15119-2-hdegoede@redhat.com>
References: <20170710184540.15119-1-hdegoede@redhat.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48510 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753245AbdGJSpp (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 10 Jul 2017 14:45:45 -0400
In-Reply-To: <20170710184540.15119-1-hdegoede@redhat.com>
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
index 4a3a7eda978b..dc47eb1f18a6 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -254,6 +254,9 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
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
