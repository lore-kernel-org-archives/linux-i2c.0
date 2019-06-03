From: Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [RFC PATCH 06/57] drivers: i2c: i2c-core: Use bus_find_device_by_of_node helper
Date: Mon,  3 Jun 2019 16:49:32 +0100
Message-ID: <1559577023-558-7-git-send-email-suzuki.poulose@arm.com>
References: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, suzuki.poulose@arm.com, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Switch to using the bus_find_device_by_of_node helper.

Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/i2c/i2c-core-of.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/i2c/i2c-core-of.c b/drivers/i2c/i2c-core-of.c
index 406e5f6..b0b3fe1 100644
--- a/drivers/i2c/i2c-core-of.c
+++ b/drivers/i2c/i2c-core-of.c
@@ -112,11 +112,6 @@ void of_i2c_register_devices(struct i2c_adapter *adap)
 	of_node_put(bus);
 }
 
-static int of_dev_node_match(struct device *dev, void *data)
-{
-	return dev->of_node == data;
-}
-
 static int of_dev_or_parent_node_match(struct device *dev, void *data)
 {
 	if (dev->of_node == data)
@@ -134,7 +129,7 @@ struct i2c_client *of_find_i2c_device_by_node(struct device_node *node)
 	struct device *dev;
 	struct i2c_client *client;
 
-	dev = bus_find_device(&i2c_bus_type, NULL, node, of_dev_node_match);
+	dev = bus_find_device_by_of_node(&i2c_bus_type, NULL, node);
 	if (!dev)
 		return NULL;
 
-- 
2.7.4
