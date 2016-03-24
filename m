From: Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH 1/1] i2c: dln2: Pass forward ACPI companion
Date: Thu, 24 Mar 2016 20:59:16 +0200
Message-ID: <1458845956-30991-1-git-send-email-irina.tirdea@intel.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:27719 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750820AbcCXTAh (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 24 Mar 2016 15:00:37 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Octavian Purdila <octavian.purdila@intel.com>, Laurentiu Palcu <laurentiu.palcu@intel.com>, Irina Tirdea <irina.tirdea@intel.com>

Share the ACPI companion for the platform device with the
i2c adapter, so that the adapter has access to the properties
defined in ACPI tables.

Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
---
 drivers/i2c/busses/i2c-dln2.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/i2c/busses/i2c-dln2.c b/drivers/i2c/busses/i2c-dln2.c
index 1600edd..f2eb4f7 100644
--- a/drivers/i2c/busses/i2c-dln2.c
+++ b/drivers/i2c/busses/i2c-dln2.c
@@ -19,6 +19,7 @@
 #include <linux/i2c.h>
 #include <linux/platform_device.h>
 #include <linux/mfd/dln2.h>
+#include <linux/acpi.h>
 
 #define DLN2_I2C_MODULE_ID		0x03
 #define DLN2_I2C_CMD(cmd)		DLN2_CMD(cmd, DLN2_I2C_MODULE_ID)
@@ -210,6 +211,7 @@ static int dln2_i2c_probe(struct platform_device *pdev)
 	dln2->adapter.algo = &dln2_i2c_usb_algorithm;
 	dln2->adapter.quirks = &dln2_i2c_quirks;
 	dln2->adapter.dev.parent = dev;
+	ACPI_COMPANION_SET(&dln2->adapter.dev, ACPI_COMPANION(&pdev->dev));
 	dln2->adapter.dev.of_node = dev->of_node;
 	i2c_set_adapdata(&dln2->adapter, dln2);
 	snprintf(dln2->adapter.name, sizeof(dln2->adapter.name), "%s-%s-%d",
-- 
1.9.1
