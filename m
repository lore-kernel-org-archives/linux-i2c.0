From: Dave Young <hidave.darkstar@gmail.com>
Subject: [PATCH 2/7] i2c : convert semaphore to mutex in struct class
Date: Thu, 3 Jan 2008 13:54:41 +0800
Message-ID: <20080103055441.GC4885@darkstar.te-china.tietoenator.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758794AbYACFvT@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: khali@linux-fr.org
Cc: linux-kernel@vger.kernel.org, i2c@lm-sensors.org
List-Id: linux-i2c@vger.kernel.org

Use mutex instead of semaphore in struct class.

Signed-off-by: Dave Young <hidave.darkstar@gmail.com> 
---
drivers/i2c/i2c-core.c |    9 ++++-----
1 file changed, 4 insertions(+), 5 deletions(-)

diff -upr linux/drivers/i2c/i2c-core.c linux.new/drivers/i2c/i2c-core.c
--- linux/drivers/i2c/i2c-core.c	2007-12-28 10:06:58.000000000 +0800
+++ linux.new/drivers/i2c/i2c-core.c	2008-01-03 09:31:38.000000000 +0800
@@ -34,7 +34,6 @@
 #include <linux/mutex.h>
 #include <linux/completion.h>
 #include <asm/uaccess.h>
-#include <asm/semaphore.h>
 
 #include "i2c-core.h"
 
@@ -597,12 +596,12 @@ int i2c_register_driver(struct module *o
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
@@ -631,7 +630,7 @@ void i2c_del_driver(struct i2c_driver *d
 	 * attached. If so, detach them to be able to kill the driver
 	 * afterwards.
 	 */
-	down(&i2c_adapter_class.sem);
+	mutex_lock(&i2c_adapter_class.mutex);
 	list_for_each_entry(adap, &i2c_adapter_class.devices, dev.node) {
 		if (driver->detach_adapter) {
 			if (driver->detach_adapter(adap)) {
@@ -656,7 +655,7 @@ void i2c_del_driver(struct i2c_driver *d
 			}
 		}
 	}
-	up(&i2c_adapter_class.sem);
+	mutex_unlock(&i2c_adapter_class.mutex);
 
  unregister:
 	driver_unregister(&driver->driver);
