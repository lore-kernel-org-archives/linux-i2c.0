From: Dave Young <hidave.darkstar@gmail.com>
Subject: [PATCH 04/12] i2c : Use mutex instead of semaphore in driver core
Date: Sat, 29 Dec 2007 09:07:51 +0800
Message-ID: <20071229010751.GE2883@darkstar.te-china.tietoenator.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754746AbXL2BEU@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: khali@linux-fr.org
Cc: linux-kernel@vger.kernel.org, i2c@lm-sensors.org
List-Id: linux-i2c@vger.kernel.org

Signed-off-by: Dave Young <hidave.darkstar@gmail.com> 

---
drivers/i2c/i2c-core.c |   10 +++++-----
1 file changed, 5 insertions(+), 5 deletions(-)

diff -upr linux/drivers/i2c/i2c-core.c linux.new/drivers/i2c/i2c-core.c
--- linux/drivers/i2c/i2c-core.c	2007-12-28 10:06:58.000000000 +0800
+++ linux.new/drivers/i2c/i2c-core.c	2007-12-28 10:08:58.000000000 +0800
@@ -33,8 +33,8 @@
 #include <linux/platform_device.h>
 #include <linux/mutex.h>
 #include <linux/completion.h>
+#include <linux/mutex.h>
 #include <asm/uaccess.h>
-#include <asm/semaphore.h>
 
 #include "i2c-core.h"
 
@@ -597,12 +597,12 @@ int i2c_register_driver(struct module *o
 	if (driver->attach_adapter) {
 		struct i2c_adapter *adapter;
 
-		down(&i2c_adapter_class.sem);
+		mutex_lock(&i2c_adapter_class.mutex);
 		list_for_each_entry(adapter, &i2c_adapter_class.devices,
 				    dev.node) {
 			driver->attach_adapter(adapter);
 		}
-		up(&i2c_adapter_class.sem);
+		mutex_unlock(&i2c_adapter_class.mutex);
 	}
 
 	mutex_unlock(&core_lock);
@@ -631,7 +631,7 @@ void i2c_del_driver(struct i2c_driver *d
 	 * attached. If so, detach them to be able to kill the driver
 	 * afterwards.
 	 */
-	down(&i2c_adapter_class.sem);
+	mutex_lock(&i2c_adapter_class.mutex);
 	list_for_each_entry(adap, &i2c_adapter_class.devices, dev.node) {
 		if (driver->detach_adapter) {
 			if (driver->detach_adapter(adap)) {
@@ -656,7 +656,7 @@ void i2c_del_driver(struct i2c_driver *d
 			}
 		}
 	}
-	up(&i2c_adapter_class.sem);
+	mutex_unlock(&i2c_adapter_class.mutex);
 
  unregister:
 	driver_unregister(&driver->driver);
