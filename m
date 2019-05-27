From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH v2 6/6] i2c: core: Tidy up handling of init_irq
Date: Mon, 27 May 2019 16:19:32 +0100
Message-ID: <20190527151932.14310-6-ckeepax@opensource.cirrus.com>
References: <20190527151932.14310-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190527151932.14310-1-ckeepax@opensource.cirrus.com>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de, mika.westerberg@linux.intel.com
Cc: jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, benjamin.tissoires@redhat.com, jbroadus@gmail.com, patches@opensource.cirrus.com
List-Id: linux-i2c@vger.kernel.org

Only set init_irq during i2c_device_new and only handle client->irq on
the probe/remove paths.

Suggested-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

No changes since v1.

Thanks,
Charles

 drivers/i2c/i2c-core-base.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 684ea2665d994..6d4904cdf58ac 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -322,6 +322,8 @@ static int i2c_device_probe(struct device *dev)
 
 	driver = to_i2c_driver(dev->driver);
 
+	client->irq = client->init_irq;
+
 	if (!client->irq && !driver->disable_i2c_core_irq_mapping) {
 		int irq = -ENOENT;
 
@@ -432,7 +434,7 @@ static int i2c_device_remove(struct device *dev)
 	dev_pm_clear_wake_irq(&client->dev);
 	device_init_wakeup(&client->dev, false);
 
-	client->irq = client->init_irq;
+	client->irq = 0;
 	if (client->flags & I2C_CLIENT_HOST_NOTIFY)
 		pm_runtime_put(&client->adapter->dev);
 
@@ -749,7 +751,6 @@ i2c_new_client_device(struct i2c_adapter *adap, struct i2c_board_info const *inf
 	if (!client->init_irq)
 		client->init_irq = i2c_dev_irq_from_resources(info->resources,
 							 info->num_resources);
-	client->irq = client->init_irq;
 
 	strlcpy(client->name, info->type, sizeof(client->name));
 
-- 
2.11.0
