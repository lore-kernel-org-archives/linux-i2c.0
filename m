From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 3/3] i2c: Deprecate i2c_driver.attach_adapter and
 .detach_adapter
Date: Sun, 20 Feb 2011 15:10:09 +0100
Message-ID: <20110220151009.758c6ed6@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The last legitimate user of i2c_driver.attach_adapter and
.detach_adapter is gone, so we can finally deprecate these callbacks.
The last few drivers which still use these will have to be updated to
make use of standard I2C device instantiation ways instead.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
 Documentation/feature-removal-schedule.txt |    9 +++++++++
 drivers/i2c/i2c-core.c                     |    4 ++++
 include/linux/i2c.h                        |   12 ++++++------
 3 files changed, 19 insertions(+), 6 deletions(-)

--- linux-2.6.38-rc5.orig/include/linux/i2c.h	2011-02-20 15:04:47.000000000 +0100
+++ linux-2.6.38-rc5/include/linux/i2c.h	2011-02-20 15:05:40.000000000 +0100
@@ -104,8 +104,8 @@ extern s32 i2c_smbus_write_i2c_block_dat
 /**
  * struct i2c_driver - represent an I2C device driver
  * @class: What kind of i2c device we instantiate (for detect)
- * @attach_adapter: Callback for bus addition (for legacy drivers)
- * @detach_adapter: Callback for bus removal (for legacy drivers)
+ * @attach_adapter: Callback for bus addition (deprecated)
+ * @detach_adapter: Callback for bus removal (deprecated)
  * @probe: Callback for device binding
  * @remove: Callback for device unbinding
  * @shutdown: Callback for device shutdown
@@ -143,11 +143,11 @@ struct i2c_driver {
 	unsigned int class;
 
 	/* Notifies the driver that a new bus has appeared or is about to be
-	 * removed. You should avoid using this if you can, it will probably
-	 * be removed in a near future.
+	 * removed. You should avoid using this, it will be removed in a
+	 * near future.
 	 */
-	int (*attach_adapter)(struct i2c_adapter *);
-	int (*detach_adapter)(struct i2c_adapter *);
+	int (*attach_adapter)(struct i2c_adapter *) __deprecated;
+	int (*detach_adapter)(struct i2c_adapter *) __deprecated;
 
 	/* Standard driver model interfaces */
 	int (*probe)(struct i2c_client *, const struct i2c_device_id *);
--- linux-2.6.38-rc5.orig/drivers/i2c/i2c-core.c	2011-02-20 15:04:47.000000000 +0100
+++ linux-2.6.38-rc5/drivers/i2c/i2c-core.c	2011-02-20 15:05:40.000000000 +0100
@@ -799,6 +799,9 @@ static int i2c_do_add_adapter(struct i2c
 
 	/* Let legacy drivers scan this bus for matching devices */
 	if (driver->attach_adapter) {
+		dev_warn(&adap->dev, "attach_adapter method is deprecated\n");
+		dev_warn(&adap->dev, "Please use another way to instantiate "
+			 "your i2c_client\n");
 		/* We ignore the return code; if it fails, too bad */
 		driver->attach_adapter(adap);
 	}
@@ -983,6 +986,7 @@ static int i2c_do_del_adapter(struct i2c
 
 	if (!driver->detach_adapter)
 		return 0;
+	dev_warn(&adapter->dev, "detach_adapter method is deprecated\n");
 	res = driver->detach_adapter(adapter);
 	if (res)
 		dev_err(&adapter->dev, "detach_adapter failed (%d) "
--- linux-2.6.38-rc5.orig/Documentation/feature-removal-schedule.txt	2011-02-20 15:01:32.000000000 +0100
+++ linux-2.6.38-rc5/Documentation/feature-removal-schedule.txt	2011-02-20 15:05:40.000000000 +0100
@@ -619,3 +619,12 @@ Why:	The original implementation of mems
 Who:	Michal Hocko <mhocko-AlSwsSmVLrQ@public.gmane.org>
 
 ----------------------------
+
+What:	i2c_driver.attach_adapter
+	i2c_driver.detach_adapter
+When:	September 2011
+Why:	These legacy callbacks should no longer be used as i2c-core offers
+	a variety of preferable alternative ways to instantiate I2C devices.
+Who:	Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
+
+----------------------------


-- 
Jean Delvare
