From: Octavian Purdila <octavian.purdila@intel.com>
Subject: [PATCH] i2c: dln2: set the device tree node of the adapter
Date: Fri, 27 Mar 2015 17:37:10 +0200
Message-ID: <1427470630-13378-1-git-send-email-octavian.purdila@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de
Cc: lee.jones@linaro.org, laurentiu.palcu@intel.com, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Octavian Purdila <octavian.purdila@intel.com>
List-Id: linux-i2c@vger.kernel.org

This patch makes sure the platform device tree node is inherited by
the adapter device. This allows the DLN2 bus to work with i2c devices
defined in the device tree.

Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
---
 drivers/i2c/busses/i2c-dln2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-dln2.c b/drivers/i2c/busses/i2c-dln2.c
index b3fb86a..db1e20a 100644
--- a/drivers/i2c/busses/i2c-dln2.c
+++ b/drivers/i2c/busses/i2c-dln2.c
@@ -210,6 +210,7 @@ static int dln2_i2c_probe(struct platform_device *pdev)
 	dln2->adapter.class = I2C_CLASS_HWMON;
 	dln2->adapter.algo = &dln2_i2c_usb_algorithm;
 	dln2->adapter.dev.parent = dev;
+	dln2->adapter.dev.of_node = dev->of_node;
 	i2c_set_adapdata(&dln2->adapter, dln2);
 	snprintf(dln2->adapter.name, sizeof(dln2->adapter.name), "%s-%s-%d",
 		 "dln2-i2c", dev_name(pdev->dev.parent), dln2->port);
-- 
1.9.1
