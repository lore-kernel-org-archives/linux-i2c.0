From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH v6 7/7] i2c: core: Tidy up handling of init_irq
Date: Fri, 21 Jun 2019 11:08:15 +0100
Message-ID: <20190621100815.12417-8-ckeepax@opensource.cirrus.com>
References: <20190621100815.12417-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190621100815.12417-1-ckeepax@opensource.cirrus.com>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de, mika.westerberg@linux.intel.com
Cc: jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, benjamin.tissoires@redhat.com, jbroadus@gmail.com, patches@opensource.cirrus.com
List-Id: linux-i2c@vger.kernel.org

Only set init_irq during i2c_device_new and only handle client->irq on
the probe/remove paths.

Suggested-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

No changes since v5.

Thanks,
Charles

 drivers/i2c/i2c-core-base.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 87a2ad8f41a76..b3cc581f6465b 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -314,6 +314,8 @@ static int i2c_device_probe(struct device *dev)
 
 	driver = to_i2c_driver(dev->driver);
 
+	client->irq = client->init_irq;
+
 	if (!client->irq && !driver->disable_i2c_core_irq_mapping) {
 		int irq = -ENOENT;
 
@@ -424,7 +426,7 @@ static int i2c_device_remove(struct device *dev)
 	dev_pm_clear_wake_irq(&client->dev);
 	device_init_wakeup(&client->dev, false);
 
-	client->irq = client->init_irq;
+	client->irq = 0;
 	if (client->flags & I2C_CLIENT_HOST_NOTIFY)
 		pm_runtime_put(&client->adapter->dev);
 
@@ -741,7 +743,6 @@ i2c_new_client_device(struct i2c_adapter *adap, struct i2c_board_info const *inf
 	if (!client->init_irq)
 		client->init_irq = i2c_dev_irq_from_resources(info->resources,
 							 info->num_resources);
-	client->irq = client->init_irq;
 
 	strlcpy(client->name, info->type, sizeof(client->name));
 
-- 
2.11.0
