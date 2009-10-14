From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 1/3] i2c-powermac: Include the i2c_adpater in struct
 pmac_i2c_bus
Date: Wed, 14 Oct 2009 16:56:29 +0200
Message-ID: <20091014165629.2e4f6737@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Include the i2c_adapter in struct pmac_i2c_bus. This avoids memory
fragmentation and allows for several code cleanups.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
---
Ben, these 3 new i2c-powermac patches go on top of the 3 other patches
I sent earlier this month. I could build-test them but not tun-test,
please do and let me know what you think.

 arch/powerpc/include/asm/pmac_low_i2c.h   |    6 +-----
 arch/powerpc/platforms/powermac/low_i2c.c |   25 +++++--------------------
 drivers/i2c/busses/i2c-powermac.c         |   15 +++------------
 3 files changed, 9 insertions(+), 37 deletions(-)

--- linux-2.6.32-rc4.orig/arch/powerpc/include/asm/pmac_low_i2c.h	2009-06-10 05:05:27.000000000 +0200
+++ linux-2.6.32-rc4/arch/powerpc/include/asm/pmac_low_i2c.h	2009-10-14 15:56:23.000000000 +0200
@@ -72,11 +72,7 @@ extern int pmac_i2c_get_type(struct pmac
 extern int pmac_i2c_get_flags(struct pmac_i2c_bus *bus);
 extern int pmac_i2c_get_channel(struct pmac_i2c_bus *bus);
 
-/* i2c layer adapter attach/detach */
-extern void pmac_i2c_attach_adapter(struct pmac_i2c_bus *bus,
-				    struct i2c_adapter *adapter);
-extern void pmac_i2c_detach_adapter(struct pmac_i2c_bus *bus,
-				    struct i2c_adapter *adapter);
+/* i2c layer adapter helpers */
 extern struct i2c_adapter *pmac_i2c_get_adapter(struct pmac_i2c_bus *bus);
 extern struct pmac_i2c_bus *pmac_i2c_adapter_to_bus(struct i2c_adapter *adapter);
 
--- linux-2.6.32-rc4.orig/arch/powerpc/platforms/powermac/low_i2c.c	2009-06-10 05:05:27.000000000 +0200
+++ linux-2.6.32-rc4/arch/powerpc/platforms/powermac/low_i2c.c	2009-10-14 15:56:23.000000000 +0200
@@ -42,6 +42,7 @@
 #include <linux/interrupt.h>
 #include <linux/timer.h>
 #include <linux/mutex.h>
+#include <linux/i2c.h>
 #include <asm/keylargo.h>
 #include <asm/uninorth.h>
 #include <asm/io.h>
@@ -80,7 +81,7 @@ struct pmac_i2c_bus
 	struct device_node	*busnode;
 	int			type;
 	int			flags;
-	struct i2c_adapter	*adapter;
+	struct i2c_adapter	adapter;
 	void			*hostdata;
 	int			channel;	/* some hosts have multiple */
 	int			mode;		/* current mode */
@@ -1011,25 +1012,9 @@ int pmac_i2c_get_channel(struct pmac_i2c
 EXPORT_SYMBOL_GPL(pmac_i2c_get_channel);
 
 
-void pmac_i2c_attach_adapter(struct pmac_i2c_bus *bus,
-			     struct i2c_adapter *adapter)
-{
-	WARN_ON(bus->adapter != NULL);
-	bus->adapter = adapter;
-}
-EXPORT_SYMBOL_GPL(pmac_i2c_attach_adapter);
-
-void pmac_i2c_detach_adapter(struct pmac_i2c_bus *bus,
-			     struct i2c_adapter *adapter)
-{
-	WARN_ON(bus->adapter != adapter);
-	bus->adapter = NULL;
-}
-EXPORT_SYMBOL_GPL(pmac_i2c_detach_adapter);
-
 struct i2c_adapter *pmac_i2c_get_adapter(struct pmac_i2c_bus *bus)
 {
-	return bus->adapter;
+	return &bus->adapter;
 }
 EXPORT_SYMBOL_GPL(pmac_i2c_get_adapter);
 
@@ -1038,7 +1023,7 @@ struct pmac_i2c_bus *pmac_i2c_adapter_to
 	struct pmac_i2c_bus *bus;
 
 	list_for_each_entry(bus, &pmac_i2c_busses, link)
-		if (bus->adapter == adapter)
+		if (&bus->adapter == adapter)
 			return bus;
 	return NULL;
 }
@@ -1050,7 +1035,7 @@ int pmac_i2c_match_adapter(struct device
 
 	if (bus == NULL)
 		return 0;
-	return (bus->adapter == adapter);
+	return (&bus->adapter == adapter);
 }
 EXPORT_SYMBOL_GPL(pmac_i2c_match_adapter);
 
--- linux-2.6.32-rc4.orig/drivers/i2c/busses/i2c-powermac.c	2009-10-14 15:56:16.000000000 +0200
+++ linux-2.6.32-rc4/drivers/i2c/busses/i2c-powermac.c	2009-10-14 15:56:23.000000000 +0200
@@ -204,19 +204,16 @@ static const struct i2c_algorithm i2c_po
 static int __devexit i2c_powermac_remove(struct platform_device *dev)
 {
 	struct i2c_adapter	*adapter = platform_get_drvdata(dev);
-	struct pmac_i2c_bus	*bus = i2c_get_adapdata(adapter);
 	int			rc;
 
 	rc = i2c_del_adapter(adapter);
-	pmac_i2c_detach_adapter(bus, adapter);
-	i2c_set_adapdata(adapter, NULL);
 	/* We aren't that prepared to deal with this... */
 	if (rc)
 		printk(KERN_WARNING
 		       "i2c-powermac.c: Failed to remove bus %s !\n",
 		       adapter->name);
 	platform_set_drvdata(dev, NULL);
-	kfree(adapter);
+	memset(adapter, 0, sizeof(*adapter));
 
 	return 0;
 }
@@ -261,23 +258,17 @@ static int __devinit i2c_powermac_probe(
 	snprintf(name, 32, "%s %d", basename, pmac_i2c_get_channel(bus));
 	of_node_put(parent);
 
-	adapter = kzalloc(sizeof(struct i2c_adapter), GFP_KERNEL);
-	if (adapter == NULL) {
-		printk(KERN_ERR "i2c-powermac: can't allocate inteface !\n");
-		return -ENOMEM;
-	}
+	adapter = pmac_i2c_get_adapter(bus);
 	platform_set_drvdata(dev, adapter);
 	strcpy(adapter->name, name);
 	adapter->algo = &i2c_powermac_algorithm;
 	i2c_set_adapdata(adapter, bus);
 	adapter->dev.parent = &dev->dev;
-	pmac_i2c_attach_adapter(bus, adapter);
 	rc = i2c_add_adapter(adapter);
 	if (rc) {
 		printk(KERN_ERR "i2c-powermac: Adapter %s registration "
 		       "failed\n", name);
-		i2c_set_adapdata(adapter, NULL);
-		pmac_i2c_detach_adapter(bus, adapter);
+		memset(adapter, 0, sizeof(*adapter));
 	}
 
 	printk(KERN_INFO "PowerMac i2c bus %s registered\n", name);


-- 
Jean Delvare
