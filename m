From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 3/3] i2c-powermac: Drop temporary name buffer
Date: Wed, 14 Oct 2009 16:59:50 +0200
Message-ID: <20091014165950.020458b4@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

We no longer need to write the adapter name to a temporary buffer.
We can write it directly to the i2c_adapter's name field. This is
more efficient.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
---
 drivers/i2c/busses/i2c-powermac.c |   11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

--- linux-2.6.32-rc4.orig/drivers/i2c/busses/i2c-powermac.c	2009-10-14 15:56:23.000000000 +0200
+++ linux-2.6.32-rc4/drivers/i2c/busses/i2c-powermac.c	2009-10-14 16:02:26.000000000 +0200
@@ -224,12 +224,12 @@ static int __devinit i2c_powermac_probe(
 	struct pmac_i2c_bus *bus = dev->dev.platform_data;
 	struct device_node *parent = NULL;
 	struct i2c_adapter *adapter;
-	char name[32];
 	const char *basename;
 	int rc;
 
 	if (bus == NULL)
 		return -EINVAL;
+	adapter = pmac_i2c_get_adapter(bus);
 
 	/* Ok, now we need to make up a name for the interface that will
 	 * match what we used to do in the past, that is basically the
@@ -255,23 +255,22 @@ static int __devinit i2c_powermac_probe(
 	default:
 		return -EINVAL;
 	}
-	snprintf(name, 32, "%s %d", basename, pmac_i2c_get_channel(bus));
+	snprintf(adapter->name, sizeof(adapter->name), "%s %d", basename,
+		 pmac_i2c_get_channel(bus));
 	of_node_put(parent);
 
-	adapter = pmac_i2c_get_adapter(bus);
 	platform_set_drvdata(dev, adapter);
-	strcpy(adapter->name, name);
 	adapter->algo = &i2c_powermac_algorithm;
 	i2c_set_adapdata(adapter, bus);
 	adapter->dev.parent = &dev->dev;
 	rc = i2c_add_adapter(adapter);
 	if (rc) {
 		printk(KERN_ERR "i2c-powermac: Adapter %s registration "
-		       "failed\n", name);
+		       "failed\n", adapter->name);
 		memset(adapter, 0, sizeof(*adapter));
 	}
 
-	printk(KERN_INFO "PowerMac i2c bus %s registered\n", name);
+	printk(KERN_INFO "PowerMac i2c bus %s registered\n", adapter->name);
 
 	if (!strncmp(basename, "uni-n", 5)) {
 		struct device_node *np;

-- 
Jean Delvare
