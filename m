From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 2/2] i2c: Let i2c_parent_is_i2c_adapter return the parent
 adapter
Date: Mon, 23 Aug 2010 12:53:54 +0200
Message-ID: <20100823125354.38563c3d@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

This makes the calling site's code clearer IMHO.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
---
Michael, what do you think? Admittedly this makes the code (very)
slightly larger, but think the improvement in code clarity justifies it.

 drivers/i2c/i2c-core.c |   30 ++++++++++++++++++------------
 drivers/i2c/i2c-dev.c  |   13 ++++++-------
 include/linux/i2c.h    |   11 ++++++++---
 3 files changed, 32 insertions(+), 22 deletions(-)

--- linux-2.6.36-rc1.orig/drivers/i2c/i2c-core.c	2010-08-23 08:32:39.000000000 +0200
+++ linux-2.6.36-rc1/drivers/i2c/i2c-core.c	2010-08-23 11:39:37.000000000 +0200
@@ -428,14 +428,14 @@ static int __i2c_check_addr_busy(struct
 /* walk up mux tree */
 static int i2c_check_mux_parents(struct i2c_adapter *adapter, int addr)
 {
+	struct i2c_adapter *parent = i2c_parent_is_i2c_adapter(adapter);
 	int result;
 
 	result = device_for_each_child(&adapter->dev, &addr,
 					__i2c_check_addr_busy);
 
-	if (!result && i2c_parent_is_i2c_adapter(adapter))
-		result = i2c_check_mux_parents(
-				    to_i2c_adapter(adapter->dev.parent), addr);
+	if (!result && parent)
+		result = i2c_check_mux_parents(parent, addr);
 
 	return result;
 }
@@ -456,11 +456,11 @@ static int i2c_check_mux_children(struct
 
 static int i2c_check_addr_busy(struct i2c_adapter *adapter, int addr)
 {
+	struct i2c_adapter *parent = i2c_parent_is_i2c_adapter(adapter);
 	int result = 0;
 
-	if (i2c_parent_is_i2c_adapter(adapter))
-		result = i2c_check_mux_parents(
-				    to_i2c_adapter(adapter->dev.parent), addr);
+	if (parent)
+		result = i2c_check_mux_parents(parent, addr);
 
 	if (!result)
 		result = device_for_each_child(&adapter->dev, &addr,
@@ -475,8 +475,10 @@ static int i2c_check_addr_busy(struct i2
  */
 void i2c_lock_adapter(struct i2c_adapter *adapter)
 {
-	if (i2c_parent_is_i2c_adapter(adapter))
-		i2c_lock_adapter(to_i2c_adapter(adapter->dev.parent));
+	struct i2c_adapter *parent = i2c_parent_is_i2c_adapter(adapter);
+
+	if (parent)
+		i2c_lock_adapter(parent);
 	else
 		rt_mutex_lock(&adapter->bus_lock);
 }
@@ -488,8 +490,10 @@ EXPORT_SYMBOL_GPL(i2c_lock_adapter);
  */
 static int i2c_trylock_adapter(struct i2c_adapter *adapter)
 {
-	if (i2c_parent_is_i2c_adapter(adapter))
-		return i2c_trylock_adapter(to_i2c_adapter(adapter->dev.parent));
+	struct i2c_adapter *parent = i2c_parent_is_i2c_adapter(adapter);
+
+	if (parent)
+		return i2c_trylock_adapter(parent);
 	else
 		return rt_mutex_trylock(&adapter->bus_lock);
 }
@@ -500,8 +504,10 @@ static int i2c_trylock_adapter(struct i2
  */
 void i2c_unlock_adapter(struct i2c_adapter *adapter)
 {
-	if (i2c_parent_is_i2c_adapter(adapter))
-		i2c_unlock_adapter(to_i2c_adapter(adapter->dev.parent));
+	struct i2c_adapter *parent = i2c_parent_is_i2c_adapter(adapter);
+
+	if (parent)
+		i2c_unlock_adapter(parent);
 	else
 		rt_mutex_unlock(&adapter->bus_lock);
 }
--- linux-2.6.36-rc1.orig/drivers/i2c/i2c-dev.c	2010-08-23 08:32:39.000000000 +0200
+++ linux-2.6.36-rc1/drivers/i2c/i2c-dev.c	2010-08-23 11:42:38.000000000 +0200
@@ -192,13 +192,12 @@ static int i2cdev_check(struct device *d
 /* walk up mux tree */
 static int i2cdev_check_mux_parents(struct i2c_adapter *adapter, int addr)
 {
+	struct i2c_adapter *parent = i2c_parent_is_i2c_adapter(adapter);
 	int result;
 
 	result = device_for_each_child(&adapter->dev, &addr, i2cdev_check);
-
-	if (!result && i2c_parent_is_i2c_adapter(adapter))
-		result = i2cdev_check_mux_parents(
-				    to_i2c_adapter(adapter->dev.parent), addr);
+	if (!result && parent)
+		result = i2cdev_check_mux_parents(parent, addr);
 
 	return result;
 }
@@ -222,11 +221,11 @@ static int i2cdev_check_mux_children(str
    driver bound to it, as NOT busy. */
 static int i2cdev_check_addr(struct i2c_adapter *adapter, unsigned int addr)
 {
+	struct i2c_adapter *parent = i2c_parent_is_i2c_adapter(adapter);
 	int result = 0;
 
-	if (i2c_parent_is_i2c_adapter(adapter))
-		result = i2cdev_check_mux_parents(
-				    to_i2c_adapter(adapter->dev.parent), addr);
+	if (parent)
+		result = i2cdev_check_mux_parents(parent, addr);
 
 	if (!result)
 		result = device_for_each_child(&adapter->dev, &addr,
--- linux-2.6.36-rc1.orig/include/linux/i2c.h	2010-08-23 10:10:33.000000000 +0200
+++ linux-2.6.36-rc1/include/linux/i2c.h	2010-08-23 10:39:12.000000000 +0200
@@ -384,10 +384,15 @@ static inline void i2c_set_adapdata(stru
 	dev_set_drvdata(&dev->dev, data);
 }
 
-static inline int i2c_parent_is_i2c_adapter(const struct i2c_adapter *adapter)
+static inline struct i2c_adapter *
+i2c_parent_is_i2c_adapter(const struct i2c_adapter *adapter)
 {
-	return adapter->dev.parent != NULL
-		&& adapter->dev.parent->type == &i2c_adapter_type;
+	struct device *parent = adapter->dev.parent;
+
+	if (parent != NULL && parent->type == &i2c_adapter_type)
+		return to_i2c_adapter(parent);
+	else
+		return NULL;
 }
 
 /* Adapter locking functions, exported for shared pin cases */

-- 
Jean Delvare
