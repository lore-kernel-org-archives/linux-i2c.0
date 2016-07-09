From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 7/7] i2c: use pr_fmt in the core
Date: Sat,  9 Jul 2016 13:35:04 +0900
Message-ID: <1468038904-2571-8-git-send-email-wsa@the-dreams.de>
References: <1468038904-2571-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:37723 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751931AbcGIEfy (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sat, 9 Jul 2016 00:35:54 -0400
In-Reply-To: <1468038904-2571-1-git-send-email-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>

Now that we revisited all error messages, we can use pr_fmt for the
remaining pr_* messages to ensure consistent output.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/i2c/i2c-core.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 7f376e9b007ba7..bd8be6b6c49246 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -27,6 +27,8 @@
    I2C slave support (c) 2014 by Wolfram Sang <wsa@sang-engineering.com>
  */
 
+#define pr_fmt(fmt) "i2c-core: " fmt
+
 #include <dt-bindings/i2c/i2c.h>
 #include <asm/uaccess.h>
 #include <linux/acpi.h>
@@ -1615,7 +1617,7 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 		goto out_list;
 
 	if (!adap->algo) {
-		pr_err("i2c-core: adapter '%s': no algo supplied!\n", adap->name);
+		pr_err("adapter '%s': no algo supplied!\n", adap->name);
 		goto out_list;
 	}
 
@@ -1639,8 +1641,7 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 	adap->dev.type = &i2c_adapter_type;
 	res = device_register(&adap->dev);
 	if (res) {
-		pr_err("i2c-core: adapter '%s': can't register device (%d)\n",
-			adap->name, res);
+		pr_err("adapter '%s': can't register device (%d)\n", adap->name, res);
 		goto out_list;
 	}
 
@@ -1831,8 +1832,7 @@ void i2c_del_adapter(struct i2c_adapter *adap)
 	found = idr_find(&i2c_adapter_idr, adap->nr);
 	mutex_unlock(&core_lock);
 	if (found != adap) {
-		pr_debug("i2c-core: attempting to delete unregistered "
-			 "adapter [%s]\n", adap->name);
+		pr_debug("attempting to delete unregistered adapter [%s]\n", adap->name);
 		return;
 	}
 
@@ -1992,7 +1992,7 @@ int i2c_register_driver(struct module *owner, struct i2c_driver *driver)
 	if (res)
 		return res;
 
-	pr_debug("i2c-core: driver [%s] registered\n", driver->driver.name);
+	pr_debug("driver [%s] registered\n", driver->driver.name);
 
 	INIT_LIST_HEAD(&driver->clients);
 	/* Walk the adapters that are already present */
@@ -2019,7 +2019,7 @@ void i2c_del_driver(struct i2c_driver *driver)
 	i2c_for_each_dev(driver, __process_removed_driver);
 
 	driver_unregister(&driver->driver);
-	pr_debug("i2c-core: driver [%s] unregistered\n", driver->driver.name);
+	pr_debug("driver [%s] unregistered\n", driver->driver.name);
 }
 EXPORT_SYMBOL(i2c_del_driver);
 
@@ -2728,7 +2728,7 @@ static int i2c_smbus_check_pec(u8 cpec, struct i2c_msg *msg)
 	cpec = i2c_smbus_msg_pec(cpec, msg);
 
 	if (rpec != cpec) {
-		pr_debug("i2c-core: Bad PEC 0x%02x vs. 0x%02x\n",
+		pr_debug("Bad PEC 0x%02x vs. 0x%02x\n",
 			rpec, cpec);
 		return -EBADMSG;
 	}
-- 
2.8.1
