From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v5 3/4] i2c: core: Allow drivers to disable i2c-core irq mapping
Date: Wed,  5 Apr 2017 00:03:34 +0200
Message-ID: <20170404220335.9815-4-hdegoede@redhat.com>
References: <20170404220335.9815-1-hdegoede@redhat.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59316 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754251AbdDDWDs (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 4 Apr 2017 18:03:48 -0400
In-Reply-To: <20170404220335.9815-1-hdegoede@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Darren Hart <dvhart@infradead.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, linux-i2c@vger.kernel.org, platform-driver-x86@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

By default the i2c-core will try to get an irq with index 0 on ACPI / of
instantiated devices. This is troublesome on some ACPI systems where the
irq info at index 0 in the CRS table may contain nonsense and/or point
to an irqchip for which there is no Linux driver.

If this happens then before this commit the driver's probe method would
never get called because i2c_device_probe will try to get an irq by
calling acpi_dev_gpio_irq_get which will always return -EPROBE in this
case, as it waits for a matching irqchip driver to load. Thus causing
the driver to not get a chance to bind.

This commit adds a new disable_i2c_core_irq_mapping flag to struct
i2c_driver which a driver can set to tell the core to skip irq mapping.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Actually also use the irq_index for of interrupts
Changes in v3:
-Add kernel doc for new i2c_driver irq_index member
-Remove duplicate assignment of driver in i2c_device_probe
Changes in v4:
-Add a disable_i2c_core_irq_mapping flag to i2c_driver instead of
 an irq_index member (effectively a rewrite of the patch, dropped
 the Reviewed-by-s)
---
 drivers/i2c/i2c-core.c | 6 +++---
 include/linux/i2c.h    | 3 +++
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 00c4cef..7a065c4 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -985,7 +985,9 @@ static int i2c_device_probe(struct device *dev)
 	if (!client)
 		return 0;
 
-	if (!client->irq) {
+	driver = to_i2c_driver(dev->driver);
+
+	if (!client->irq && !driver->disable_i2c_core_irq_mapping) {
 		int irq = -ENOENT;
 
 		if (client->flags & I2C_CLIENT_HOST_NOTIFY) {
@@ -1007,8 +1009,6 @@ static int i2c_device_probe(struct device *dev)
 		client->irq = irq;
 	}
 
-	driver = to_i2c_driver(dev->driver);
-
 	/*
 	 * An I2C ID table is not mandatory, if and only if, a suitable Device
 	 * Tree match table entry is supplied for the probing device.
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 53fa50f..3a57e3d 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -149,6 +149,7 @@ enum i2c_alert_protocol {
  * @detect: Callback for device detection
  * @address_list: The I2C addresses to probe (for detect)
  * @clients: List of detected clients we created (for i2c-core use only)
+ * @disable_i2c_core_irq_mapping: Tell the i2c-core to not do irq-mapping
  *
  * The driver.owner field should be set to the module owner of this driver.
  * The driver.name field should be set to the name of this driver.
@@ -212,6 +213,8 @@ struct i2c_driver {
 	int (*detect)(struct i2c_client *, struct i2c_board_info *);
 	const unsigned short *address_list;
 	struct list_head clients;
+
+	bool disable_i2c_core_irq_mapping;
 };
 #define to_i2c_driver(d) container_of(d, struct i2c_driver, driver)
 
-- 
2.9.3
