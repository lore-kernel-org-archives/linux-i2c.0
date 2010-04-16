From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c: Don't assume i2c adapters have a parent
Date: Fri, 16 Apr 2010 18:09:03 +0200
Message-ID: <20100416180903.412b36be@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>, Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: i2c: Don't assume i2c adapters have a parent

Virtual adapters such as i2c-stub do not have a parent.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Cc: Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>
---
Michael, feel free to merge this into your i2c mux patch.

 drivers/i2c/i2c-core.c |   16 +++++++++++-----
 drivers/i2c/i2c-dev.c  |   10 ++++++++--
 2 files changed, 19 insertions(+), 7 deletions(-)

--- linux-2.6.34-rc4.orig/drivers/i2c/i2c-dev.c	2010-04-16 12:57:44.000000000 +0200
+++ linux-2.6.34-rc4/drivers/i2c/i2c-dev.c	2010-04-16 17:43:51.000000000 +0200
@@ -193,13 +193,19 @@ static int i2cdev_check(struct device *d
 	return dev->driver ? -EBUSY : 0;
 }
 
+static int i2cdev_parent_is_i2c_adapter(const struct i2c_adapter *adapter)
+{
+	return adapter->dev.parent != NULL
+	    && adapter->dev.parent->bus == &i2c_bus_type;
+}
+
 static int i2cdev_check_clients(struct i2c_adapter *adapter, int addr)
 {
 	int result = 0;
 
 	result = device_for_each_child(&adapter->dev, &addr, i2cdev_check);
 
-	if (!result && (adapter->dev.parent->bus == &i2c_bus_type))
+	if (!result && i2cdev_parent_is_i2c_adapter(adapter))
 		result = i2cdev_check_clients(to_i2c_adapter(adapter->dev.parent), addr);
 
 	return result;
@@ -214,7 +220,7 @@ static int i2cdev_check_addr(struct i2c_
 
 	result = i2cdev_check_clients(adapter, addr);
 
-	if (!result && (adapter->dev.parent->bus == &i2c_bus_type))
+	if (!result && i2cdev_parent_is_i2c_adapter(adapter))
 	{
 		struct i2c_client dummy;
 		char buff;
--- linux-2.6.34-rc4.orig/drivers/i2c/i2c-core.c	2010-04-16 12:57:44.000000000 +0200
+++ linux-2.6.34-rc4/drivers/i2c/i2c-core.c	2010-04-16 17:52:37.000000000 +0200
@@ -373,6 +373,12 @@ struct i2c_client *i2c_verify_client(str
 EXPORT_SYMBOL(i2c_verify_client);
 
 
+static int i2c_parent_is_i2c_adapter(const struct i2c_adapter *adapter)
+{
+	return adapter->dev.parent != NULL
+	    && adapter->dev.parent->bus == &i2c_bus_type;
+}
+
 /* This is a permissive address validity check, I2C address map constraints
  * are purposedly not enforced, except for the general call address. */
 static int i2c_check_client_addr_validity(const struct i2c_client *client)
@@ -426,7 +432,7 @@ static int i2c_check_clients(struct i2c_
 
 	result = device_for_each_child(&adapter->dev, &addr, __i2c_check_addr_busy);
 
-	if (!result && (adapter->dev.parent->bus == &i2c_bus_type))
+	if (!result && i2c_parent_is_i2c_adapter(adapter))
 		result = i2c_check_clients(to_i2c_adapter(adapter->dev.parent), addr);
 
 	return result;
@@ -438,7 +444,7 @@ static int i2c_check_addr_busy(struct i2
 
 	result = i2c_check_clients(adapter, addr);
 
-	if (!result && (adapter->dev.parent->bus == &i2c_bus_type))
+	if (!result && i2c_parent_is_i2c_adapter(adapter))
 	{
 		struct i2c_client dummy;
 		char buff;
@@ -456,7 +462,7 @@ static int i2c_check_addr_busy(struct i2
 static void i2c_mux_tree_lock(struct i2c_adapter *adap)
 {
 	rt_mutex_lock(&adap->bus_lock);
-	if(adap->dev.parent->bus == &i2c_bus_type)
+	if (i2c_parent_is_i2c_adapter(adap))
 		i2c_mux_tree_lock(to_i2c_adapter(adap->dev.parent));
 }
 
@@ -466,7 +472,7 @@ static int i2c_mux_tree_trylock(struct i
 
 	ret = rt_mutex_trylock(&adap->bus_lock);
 
-	if(ret && (adap->dev.parent->bus == &i2c_bus_type)) {
+	if (ret && i2c_parent_is_i2c_adapter(adap)) {
 		ret = i2c_mux_tree_trylock(to_i2c_adapter(adap->dev.parent));
 		if (!ret)
 			rt_mutex_unlock(&adap->bus_lock);
@@ -477,7 +483,7 @@ static int i2c_mux_tree_trylock(struct i
 
 static void i2c_mux_tree_unlock(struct i2c_adapter *adap)
 {
-	if(adap->dev.parent->bus == &i2c_bus_type)
+	if (i2c_parent_is_i2c_adapter(adap))
 		i2c_mux_tree_unlock(to_i2c_adapter(adap->dev.parent));
 	rt_mutex_unlock(&adap->bus_lock);
 }


-- 
Jean Delvare
