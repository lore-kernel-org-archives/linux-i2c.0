From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c: Move adapter locking helpers to i2c-core
Date: Tue, 15 Jun 2010 14:02:18 +0200
Message-ID: <20100615140218.07090c90@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Uninline i2c adapter locking helper functions, move them to i2c-core,
and use them in i2c-core itself. The functions are still exported for
external users. This makes future updates to the locking model (which
will be needed for multiplexing support) possible and transparent.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
---
Michael, I think this makes your multiplexing support integrate
smoothly?

 drivers/i2c/i2c-core.c |   39 ++++++++++++++++++++++++++++++++++-----
 include/linux/i2c.h    |   20 +++-----------------
 2 files changed, 37 insertions(+), 22 deletions(-)

--- linux-2.6.35-rc3.orig/drivers/i2c/i2c-core.c	2010-06-15 12:53:27.000000000 +0200
+++ linux-2.6.35-rc3/drivers/i2c/i2c-core.c	2010-06-15 13:01:25.000000000 +0200
@@ -424,6 +424,35 @@ static int i2c_check_addr_busy(struct i2
 }
 
 /**
+ * i2c_lock_adapter - Get exclusive access to an I2C bus segment
+ * @adapter: Target I2C bus segment
+ */
+void i2c_lock_adapter(struct i2c_adapter *adapter)
+{
+	rt_mutex_lock(&adapter->bus_lock);
+}
+EXPORT_SYMBOL_GPL(i2c_lock_adapter);
+
+/**
+ * i2c_trylock_adapter - Try to get exclusive access to an I2C bus segment
+ * @adapter: Target I2C bus segment
+ */
+static int i2c_trylock_adapter(struct i2c_adapter *adapter)
+{
+	return rt_mutex_trylock(&adapter->bus_lock);
+}
+
+/**
+ * i2c_unlock_adapter - Release exclusive access to an I2C bus segment
+ * @adapter: Target I2C bus segment
+ */
+void i2c_unlock_adapter(struct i2c_adapter *adapter)
+{
+	rt_mutex_unlock(&adapter->bus_lock);
+}
+EXPORT_SYMBOL_GPL(i2c_unlock_adapter);
+
+/**
  * i2c_new_device - instantiate an i2c device
  * @adap: the adapter managing the device
  * @info: describes one I2C device; bus_num is ignored
@@ -1229,12 +1258,12 @@ int i2c_transfer(struct i2c_adapter *ada
 #endif
 
 		if (in_atomic() || irqs_disabled()) {
-			ret = rt_mutex_trylock(&adap->bus_lock);
+			ret = i2c_trylock_adapter(adap);
 			if (!ret)
 				/* I2C activity is ongoing. */
 				return -EAGAIN;
 		} else {
-			rt_mutex_lock(&adap->bus_lock);
+			i2c_lock_adapter(adap);
 		}
 
 		/* Retry automatically on arbitration loss */
@@ -1246,7 +1275,7 @@ int i2c_transfer(struct i2c_adapter *ada
 			if (time_after(jiffies, orig_jiffies + adap->timeout))
 				break;
 		}
-		rt_mutex_unlock(&adap->bus_lock);
+		i2c_unlock_adapter(adap);
 
 		return ret;
 	} else {
@@ -2005,7 +2034,7 @@ s32 i2c_smbus_xfer(struct i2c_adapter *a
 	flags &= I2C_M_TEN | I2C_CLIENT_PEC;
 
 	if (adapter->algo->smbus_xfer) {
-		rt_mutex_lock(&adapter->bus_lock);
+		i2c_lock_adapter(adapter);
 
 		/* Retry automatically on arbitration loss */
 		orig_jiffies = jiffies;
@@ -2019,7 +2048,7 @@ s32 i2c_smbus_xfer(struct i2c_adapter *a
 				       orig_jiffies + adapter->timeout))
 				break;
 		}
-		rt_mutex_unlock(&adapter->bus_lock);
+		i2c_unlock_adapter(adapter);
 	} else
 		res = i2c_smbus_xfer_emulated(adapter, addr, flags, read_write,
 					      command, protocol, data);
--- linux-2.6.35-rc3.orig/include/linux/i2c.h	2010-06-15 12:53:27.000000000 +0200
+++ linux-2.6.35-rc3/include/linux/i2c.h	2010-06-15 12:59:22.000000000 +0200
@@ -380,23 +380,9 @@ static inline void i2c_set_adapdata(stru
 	dev_set_drvdata(&dev->dev, data);
 }
 
-/**
- * i2c_lock_adapter - Prevent access to an I2C bus segment
- * @adapter: Target I2C bus segment
- */
-static inline void i2c_lock_adapter(struct i2c_adapter *adapter)
-{
-	rt_mutex_lock(&adapter->bus_lock);
-}
-
-/**
- * i2c_unlock_adapter - Reauthorize access to an I2C bus segment
- * @adapter: Target I2C bus segment
- */
-static inline void i2c_unlock_adapter(struct i2c_adapter *adapter)
-{
-	rt_mutex_unlock(&adapter->bus_lock);
-}
+/* Adapter locking functions, exported for shared pin cases */
+void i2c_lock_adapter(struct i2c_adapter *);
+void i2c_unlock_adapter(struct i2c_adapter *);
 
 /*flags for the client struct: */
 #define I2C_CLIENT_PEC	0x04		/* Use Packet Error Checking */


-- 
Jean Delvare
