From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c: Improve deprecation warnings
Date: Wed, 30 Mar 2011 14:19:13 +0200
Message-ID: <20110330141913.6871adb4@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

When warning on the use of deprecated i2c_driver methods
attach_adapter and detach_adapter, mention the name of the driver
which needs to be updated.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
---
 drivers/i2c/i2c-core.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- linux-2.6.39-rc1.orig/drivers/i2c/i2c-core.c	2011-03-30 11:55:38.000000000 +0200
+++ linux-2.6.39-rc1/drivers/i2c/i2c-core.c	2011-03-30 11:55:39.000000000 +0200
@@ -797,7 +797,8 @@ static int i2c_do_add_adapter(struct i2c
 
 	/* Let legacy drivers scan this bus for matching devices */
 	if (driver->attach_adapter) {
-		dev_warn(&adap->dev, "attach_adapter method is deprecated\n");
+		dev_warn(&adap->dev, "%s: attach_adapter method is deprecated\n",
+			 driver->driver.name);
 		dev_warn(&adap->dev, "Please use another way to instantiate "
 			 "your i2c_client\n");
 		/* We ignore the return code; if it fails, too bad */
@@ -984,7 +985,8 @@ static int i2c_do_del_adapter(struct i2c
 
 	if (!driver->detach_adapter)
 		return 0;
-	dev_warn(&adapter->dev, "detach_adapter method is deprecated\n");
+	dev_warn(&adapter->dev, "%s: detach_adapter method is deprecated\n",
+		 driver->driver.name);
 	res = driver->detach_adapter(adapter);
 	if (res)
 		dev_err(&adapter->dev, "detach_adapter failed (%d) "


-- 
Jean Delvare
