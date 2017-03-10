From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 3/3] i2c: core: Allow drivers to specify index for irq to get from of / acpi
Date: Fri, 10 Mar 2017 22:16:07 +0100
Message-ID: <20170310211607.16998-3-hdegoede@redhat.com>
References: <20170310211607.16998-1-hdegoede@redhat.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43554 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754391AbdCJVQP (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 10 Mar 2017 16:16:15 -0500
In-Reply-To: <20170310211607.16998-1-hdegoede@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

Some of or acpi declared / enumerated devices may have multiple irq
resources declared and the driver may want to use a different irq then
the one with index 0.

This commit adds a new irq_index field to struct i2c_driver and makes
the i2c-core pass this to of_irq_get / acpi_dev_gpio_irq_get.

This is esp. useful for acpi declared devices where the irq with
index 0 may be entirely useless and cause i2c_device_probe to fail with
-EPROBE_DEFER.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/i2c/i2c-core.c | 5 ++++-
 include/linux/i2c.h    | 3 +++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 8ddd55b..ee59a04 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -984,6 +984,8 @@ static int i2c_device_probe(struct device *dev)
 	if (!client)
 		return 0;
 
+	driver = to_i2c_driver(dev->driver);
+
 	if (!client->irq) {
 		int irq = -ENOENT;
 
@@ -995,7 +997,8 @@ static int i2c_device_probe(struct device *dev)
 			if (irq == -EINVAL || irq == -ENODATA)
 				irq = of_irq_get(dev->of_node, 0);
 		} else if (ACPI_COMPANION(dev)) {
-			irq = acpi_dev_gpio_irq_get(ACPI_COMPANION(dev), 0);
+			irq = acpi_dev_gpio_irq_get(ACPI_COMPANION(dev),
+						    driver->irq_index);
 		}
 		if (irq == -EPROBE_DEFER)
 			return irq;
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 369ebfa..a5ffe29 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -212,6 +212,9 @@ struct i2c_driver {
 	int (*detect)(struct i2c_client *, struct i2c_board_info *);
 	const unsigned short *address_list;
 	struct list_head clients;
+
+	/* IRQ index for retreiving irq from ACPI resources */
+	int irq_index;
 };
 #define to_i2c_driver(d) container_of(d, struct i2c_driver, driver)
 
-- 
2.9.3
