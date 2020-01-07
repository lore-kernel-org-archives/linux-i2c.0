From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 09/12] i2c: i2c-core-base: convert to use i2c_new_client_device()
Date: Tue,  7 Jan 2020 18:47:43 +0100
Message-ID: <20200107174748.9616-10-wsa+renesas@sang-engineering.com>
References: <20200107174748.9616-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200107174748.9616-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Move away from the deprecated API and return the shiny new ERRPTR where
useful.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
Build tested only.

 drivers/i2c/i2c-core-base.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 9f8dcd3f8385..6c2007a015f2 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -824,8 +824,8 @@ EXPORT_SYMBOL_GPL(i2c_new_device);
 
 
 /**
- * i2c_unregister_device - reverse effect of i2c_new_device()
- * @client: value returned from i2c_new_device()
+ * i2c_unregister_device - reverse effect of i2c_new_*_device()
+ * @client: value returned from i2c_new_*_device()
  * Context: can sleep
  */
 void i2c_unregister_device(struct i2c_client *client)
@@ -1171,9 +1171,8 @@ static void i2c_scan_static_board_info(struct i2c_adapter *adapter)
 
 	down_read(&__i2c_board_lock);
 	list_for_each_entry(devinfo, &__i2c_board_list, list) {
-		if (devinfo->busnum == adapter->nr
-				&& !i2c_new_device(adapter,
-						&devinfo->board_info))
+		if (devinfo->busnum == adapter->nr &&
+		    IS_ERR(i2c_new_client_device(adapter, &devinfo->board_info)))
 			dev_err(&adapter->dev,
 				"Can't create device at 0x%02x\n",
 				devinfo->board_info.addr);
@@ -2160,8 +2159,8 @@ static int i2c_detect_address(struct i2c_client *temp_client,
 
 		dev_dbg(&adapter->dev, "Creating %s at 0x%02x\n",
 			info.type, info.addr);
-		client = i2c_new_device(adapter, &info);
-		if (client)
+		client = i2c_new_client_device(adapter, &info);
+		if (!IS_ERR(client))
 			list_add_tail(&client->detected, &driver->clients);
 		else
 			dev_err(&adapter->dev, "Failed creating %s at 0x%02x\n",
-- 
2.20.1
