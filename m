From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 4/4] i2c: Rename i2c_check_addr to i2c_check_addr_busy
Date: Fri, 9 Apr 2010 16:55:24 +0200
Message-ID: <20100409165524.366bb6fe@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Otherwise it's not clear what it is checking.

Also move the function to save a forward declaration.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
 drivers/i2c/i2c-core.c |   38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

--- linux-2.6.34-rc3.orig/drivers/i2c/i2c-core.c	2010-04-08 15:05:59.000000000 +0200
+++ linux-2.6.34-rc3/drivers/i2c/i2c-core.c	2010-04-08 15:07:21.000000000 +0200
@@ -48,7 +48,6 @@ static DEFINE_IDR(i2c_adapter_idr);
 static LIST_HEAD(userspace_devices);
 
 static struct device_type i2c_client_type;
-static int i2c_check_addr(struct i2c_adapter *adapter, int addr);
 static int i2c_detect(struct i2c_adapter *adapter, struct i2c_driver *driver);
 
 /* ------------------------------------------------------------------------- */
@@ -409,6 +408,22 @@ static int i2c_check_addr_validity(unsig
 	return 0;
 }
 
+static int __i2c_check_addr_busy(struct device *dev, void *addrp)
+{
+	struct i2c_client	*client = i2c_verify_client(dev);
+	int			addr = *(int *)addrp;
+
+	if (client && client->addr == addr)
+		return -EBUSY;
+	return 0;
+}
+
+static int i2c_check_addr_busy(struct i2c_adapter *adapter, int addr)
+{
+	return device_for_each_child(&adapter->dev, &addr,
+				     __i2c_check_addr_busy);
+}
+
 /**
  * i2c_new_device - instantiate an i2c device
  * @adap: the adapter managing the device
@@ -457,7 +472,7 @@ i2c_new_device(struct i2c_adapter *adap,
 	}
 
 	/* Check for address business */
-	status = i2c_check_addr(adap, client->addr);
+	status = i2c_check_addr_busy(adap, client->addr);
 	if (status)
 		goto out_err;
 
@@ -1059,21 +1074,6 @@ EXPORT_SYMBOL(i2c_del_driver);
 
 /* ------------------------------------------------------------------------- */
 
-static int __i2c_check_addr(struct device *dev, void *addrp)
-{
-	struct i2c_client	*client = i2c_verify_client(dev);
-	int			addr = *(int *)addrp;
-
-	if (client && client->addr == addr)
-		return -EBUSY;
-	return 0;
-}
-
-static int i2c_check_addr(struct i2c_adapter *adapter, int addr)
-{
-	return device_for_each_child(&adapter->dev, &addr, __i2c_check_addr);
-}
-
 /**
  * i2c_use_client - increments the reference count of the i2c client structure
  * @client: the client being referenced
@@ -1364,7 +1364,7 @@ static int i2c_detect_address(struct i2c
 	}
 
 	/* Skip if already in use */
-	if (i2c_check_addr(adapter, addr))
+	if (i2c_check_addr_busy(adapter, addr))
 		return 0;
 
 	/* Make sure there is something at this address */
@@ -1481,7 +1481,7 @@ i2c_new_probed_device(struct i2c_adapter
 		}
 
 		/* Check address availability */
-		if (i2c_check_addr(adap, addr_list[i])) {
+		if (i2c_check_addr_busy(adap, addr_list[i])) {
 			dev_dbg(&adap->dev, "Address 0x%02x already in "
 				"use, not probing\n", addr_list[i]);
 			continue;


-- 
Jean Delvare
