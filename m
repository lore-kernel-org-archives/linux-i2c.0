From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] i2c: core: put literals on one line in dev_*() calls
Date: Thu, 25 Aug 2016 17:42:10 +0300
Message-ID: <1472136130-98421-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:38719 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755129AbcHYOm2 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 25 Aug 2016 10:42:28 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

It's better to have strings in the code like they appeared in the output.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/i2c/i2c-core.c | 43 +++++++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 20 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index da3a02e..787fa7d 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -853,7 +853,7 @@ static int i2c_device_probe(struct device *dev)
 			status = 0;
 
 		if (status)
-			dev_warn(&client->dev, "failed to set up wakeup irq");
+			dev_warn(&client->dev, "failed to set up wakeup irq\n");
 	}
 
 	dev_dbg(dev, "probe\n");
@@ -1208,8 +1208,9 @@ i2c_new_device(struct i2c_adapter *adap, struct i2c_board_info const *info)
 	return client;
 
 out_err:
-	dev_err(&adap->dev, "Failed to register i2c client %s at 0x%02x "
-		"(%d)\n", client->name, client->addr, status);
+	dev_err(&adap->dev,
+		"Failed to register i2c client %s at 0x%02x (%d)\n",
+		client->name, client->addr, status);
 out_err_silent:
 	kfree(client);
 	return NULL;
@@ -1678,8 +1679,8 @@ static int i2c_do_add_adapter(struct i2c_driver *driver,
 	if (driver->attach_adapter) {
 		dev_warn(&adap->dev, "%s: attach_adapter method is deprecated\n",
 			 driver->driver.name);
-		dev_warn(&adap->dev, "Please use another way to instantiate "
-			 "your i2c_client\n");
+		dev_warn(&adap->dev,
+			 "Please use another way to instantiate your i2c_client\n");
 		/* We ignore the return code; if it fails, too bad */
 		driver->attach_adapter(adap);
 	}
@@ -2451,9 +2452,10 @@ int i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 	if (adap->algo->master_xfer) {
 #ifdef DEBUG
 		for (ret = 0; ret < num; ret++) {
-			dev_dbg(&adap->dev, "master_xfer[%d] %c, addr=0x%02x, "
-				"len=%d%s\n", ret, (msgs[ret].flags & I2C_M_RD)
-				? 'R' : 'W', msgs[ret].addr, msgs[ret].len,
+			dev_dbg(&adap->dev,
+				"master_xfer[%d] %c, addr=0x%02x, len=%d%s\n",
+				ret, (msgs[ret].flags & I2C_M_RD) ? 'R' : 'W',
+				msgs[ret].addr, msgs[ret].len,
 				(msgs[ret].flags & I2C_M_RECV_LEN) ? "+" : "");
 		}
 #endif
@@ -2619,9 +2621,9 @@ static int i2c_detect_address(struct i2c_client *temp_client,
 
 	/* Consistency check */
 	if (info.type[0] == '\0') {
-		dev_err(&adapter->dev, "%s detection function provided "
-			"no name for 0x%x\n", driver->driver.name,
-			addr);
+		dev_err(&adapter->dev,
+			"%s detection function provided no name for 0x%x\n",
+			driver->driver.name, addr);
 	} else {
 		struct i2c_client *client;
 
@@ -2659,9 +2661,8 @@ static int i2c_detect(struct i2c_adapter *adapter, struct i2c_driver *driver)
 	/* Warn that the adapter lost class based instantiation */
 	if (adapter->class == I2C_CLASS_DEPRECATED) {
 		dev_dbg(&adapter->dev,
-			"This adapter dropped support for I2C classes and "
-			"won't auto-detect %s devices anymore. If you need it, check "
-			"'Documentation/i2c/instantiating-devices' for alternatives.\n",
+			"This adapter dropped support for I2C classes and won't auto-detect %s devices anymore. "
+			"If you need it, check 'Documentation/i2c/instantiating-devices' for alternatives.\n",
 			driver->driver.name);
 		return 0;
 	}
@@ -2677,8 +2678,9 @@ static int i2c_detect(struct i2c_adapter *adapter, struct i2c_driver *driver)
 	temp_client->adapter = adapter;
 
 	for (i = 0; address_list[i] != I2C_CLIENT_END; i += 1) {
-		dev_dbg(&adapter->dev, "found normal entry for adapter %d, "
-			"addr 0x%02x\n", adap_id, address_list[i]);
+		dev_dbg(&adapter->dev,
+			"found normal entry for adapter %d, addr 0x%02x\n",
+			adap_id, address_list[i]);
 		temp_client->addr = address_list[i];
 		err = i2c_detect_address(temp_client, driver);
 		if (unlikely(err))
@@ -2710,15 +2712,16 @@ i2c_new_probed_device(struct i2c_adapter *adap,
 	for (i = 0; addr_list[i] != I2C_CLIENT_END; i++) {
 		/* Check address validity */
 		if (i2c_check_7bit_addr_validity_strict(addr_list[i]) < 0) {
-			dev_warn(&adap->dev, "Invalid 7-bit address "
-				 "0x%02x\n", addr_list[i]);
+			dev_warn(&adap->dev, "Invalid 7-bit address 0x%02x\n",
+				 addr_list[i]);
 			continue;
 		}
 
 		/* Check address availability (7 bit, no need to encode flags) */
 		if (i2c_check_addr_busy(adap, addr_list[i])) {
-			dev_dbg(&adap->dev, "Address 0x%02x already in "
-				"use, not probing\n", addr_list[i]);
+			dev_dbg(&adap->dev,
+				"Address 0x%02x already in use, not probing\n",
+				addr_list[i]);
 			continue;
 		}
 
-- 
2.8.1
