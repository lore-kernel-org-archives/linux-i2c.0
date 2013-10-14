From: RAGHAVENDRA GANIGA <ravi23ganiga@gmail.com>
Subject: [PATCH 2/3] i2c: i2c-core: fix coding style issues in i2c-core.c
Date: Mon, 14 Oct 2013 20:53:07 +0530
Message-ID: <525C0C5B.6040703@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, ravi23ganiga@gmail.com
List-Id: linux-i2c@vger.kernel.org

>From b21e6a52aa9c36e8c01173cff13bbfd2a380d0bd Mon Sep 17 00:00:00 2001
From: Raghavendra Ganiga <ravi23ganiga@gmail.com>
Date: Mon, 14 Oct 2013 00:29:08 +0530
Subject: [PATCH 2/3] i2c: i2c-core: fix coding style issues in i2c-core.c

This is a patch to the i2c-core.c file that fixes up warnings and
the code indent error reported by the checkpatch.pl tool

Signed-off-by: Raghavendra Chandra Ganiga <ravi23ganiga@gmail.com>
---
 drivers/i2c/i2c-core.c |   48 +++++++++++++++++++++++++-----------------------
 1 file changed, 25 insertions(+), 23 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index b1197bb..66e38a9 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -48,7 +48,7 @@
 #include <linux/rwsem.h>
 #include <linux/pm_runtime.h>
 #include <linux/acpi.h>
-#include <asm/uaccess.h>
+#include <linux/uaccess.h>
 
 #include "i2c-core.h"
 
@@ -687,8 +687,8 @@ i2c_new_device(struct i2c_adapter *adap, struct i2c_board_info const *info)
 	return client;
 
 out_err:
-	dev_err(&adap->dev, "Failed to register i2c client %s at 0x%02x "
-		"(%d)\n", client->name, client->addr, status);
+	dev_err(&adap->dev, "Failed to register i2c client %s at 0x%02x (%d)\n",
+		 client->name, client->addr, status);
 out_err_silent:
 	kfree(client);
 	return NULL;
@@ -1158,8 +1158,7 @@ static int i2c_do_add_adapter(struct i2c_driver *driver,
 	if (driver->attach_adapter) {
 		dev_warn(&adap->dev, "%s: attach_adapter method is deprecated\n",
 			 driver->driver.name);
-		dev_warn(&adap->dev, "Please use another way to instantiate "
-			 "your i2c_client\n");
+		dev_warn(&adap->dev, "Please use another way to instantiate your i2c_client\n");
 		/* We ignore the return code; if it fails, too bad */
 		driver->attach_adapter(adap);
 	}
@@ -1183,13 +1182,12 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 
 	/* Sanity checks */
 	if (unlikely(adap->name[0] == '\0')) {
-		pr_err("i2c-core: Attempt to register an adapter with "
-		       "no name!\n");
+		pr_err("i2c-core: Attempt to register an adapter with no name!\n");
 		return -EINVAL;
 	}
 	if (unlikely(!adap->algo)) {
-		pr_err("i2c-core: Attempt to register adapter '%s' with "
-		       "no algo!\n", adap->name);
+		pr_err("i2c-core: Attempt to register adapter '%s' with no algo!\n",
+			 adap->name);
 		return -EINVAL;
 	}
 
@@ -1422,8 +1420,8 @@ void i2c_del_adapter(struct i2c_adapter *adap)
 	found = idr_find(&i2c_adapter_idr, adap->nr);
 	mutex_unlock(&core_lock);
 	if (found != adap) {
-		pr_debug("i2c-core: attempting to delete unregistered "
-			 "adapter [%s]\n", adap->name);
+		pr_debug("i2c-core: attempting to delete unregistered adapter [%s]\n",
+				adap->name);
 		return;
 	}
 
@@ -1737,9 +1735,10 @@ int i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 	if (adap->algo->master_xfer) {
 #ifdef DEBUG
 		for (ret = 0; ret < num; ret++) {
-			dev_dbg(&adap->dev, "master_xfer[%d] %c, addr=0x%02x, "
-				"len=%d%s\n", ret, (msgs[ret].flags & I2C_M_RD)
-				? 'R' : 'W', msgs[ret].addr, msgs[ret].len,
+			dev_dbg(&adap->dev, "master_xfer[%d] %c, addr=0x%02x, len=%d%s\n",
+				ret,
+				((msgs[ret].flags & I2C_M_RD) ? 'R' : 'W'),
+				msgs[ret].addr, msgs[ret].len,
 				(msgs[ret].flags & I2C_M_RECV_LEN) ? "+" : "");
 		}
 #endif
@@ -1905,8 +1904,9 @@ static int i2c_detect_address(struct i2c_client *temp_client,
 
 	/* Consistency check */
 	if (info.type[0] == '\0') {
-		dev_err(&adapter->dev, "%s detection function provided "
-			"no name for 0x%x\n", driver->driver.name,
+		dev_err(&adapter->dev,
+			"%s detection function provided no name for 0x%x\n",
+			driver->driver.name,
 			addr);
 	} else {
 		struct i2c_client *client;
@@ -1946,8 +1946,9 @@ static int i2c_detect(struct i2c_adapter *adapter, struct i2c_driver *driver)
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
@@ -1979,15 +1980,16 @@ i2c_new_probed_device(struct i2c_adapter *adap,
 	for (i = 0; addr_list[i] != I2C_CLIENT_END; i++) {
 		/* Check address validity */
 		if (i2c_check_addr_validity(addr_list[i]) < 0) {
-			dev_warn(&adap->dev, "Invalid 7-bit address "
-				 "0x%02x\n", addr_list[i]);
+			dev_warn(&adap->dev, "Invalid 7-bit address 0x%02x\n",
+				addr_list[i]);
 			continue;
 		}
 
 		/* Check address availability */
 		if (i2c_check_addr_busy(adap, addr_list[i])) {
-			dev_dbg(&adap->dev, "Address 0x%02x already in "
-				"use, not probing\n", addr_list[i]);
+			dev_dbg(&adap->dev,
+				"Address 0x%02x already in use, not probing\n",
+				addr_list[i]);
 			continue;
 		}
 
@@ -2118,7 +2120,7 @@ EXPORT_SYMBOL(i2c_smbus_read_byte);
 s32 i2c_smbus_write_byte(const struct i2c_client *client, u8 value)
 {
 	return i2c_smbus_xfer(client->adapter, client->addr, client->flags,
-	                      I2C_SMBUS_WRITE, value, I2C_SMBUS_BYTE, NULL);
+				I2C_SMBUS_WRITE, value, I2C_SMBUS_BYTE, NULL);
 }
 EXPORT_SYMBOL(i2c_smbus_write_byte);
 
-- 
1.7.10.4
