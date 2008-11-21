From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [RFC] i2c-parport: Add SMBus alert support for ADM1032EB
Date: Fri, 21 Nov 2008 21:29:45 +0100
Message-ID: <20081121212945.14e14217@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi David,

Here is my attempt to add support for the SMBus alert mechanism to my
ADM1032 evaluation board (ADM1032 thermal sensor over parallel port.)
I'm not totally sure about the order in which things should be done in
i2c_parport_attach() and i2c_parport_detach() (in particular whether
irq should be enabled/disabled before/after registering/unregistering
the i2c adapter) but all in all it seems to work fine for me. Can you
please take a look and tell me if you see any mistake? Thanks.

* * * * *

Add support for the SMBus alert mechanism on the ADM1032 evaluation
board. At this point this is more of a proof-of-concept, we don't do
anything terribly useful on SMBus alert: we simply log the event. But
this could later evolve into libsensors signaling so that user-space
applications can take an appropriate action.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
 drivers/hwmon/lm90.c             |   28 ++++++++++++++++++++++++++++
 drivers/i2c/busses/i2c-parport.c |   26 ++++++++++++++++++++++----
 drivers/i2c/busses/i2c-parport.h |    4 +++-
 3 files changed, 53 insertions(+), 5 deletions(-)

--- linux-2.6.28-rc6.orig/drivers/i2c/busses/i2c-parport.c	2008-11-21 14:49:40.000000000 +0100
+++ linux-2.6.28-rc6/drivers/i2c/busses/i2c-parport.c	2008-11-21 15:23:38.000000000 +0100
@@ -1,7 +1,7 @@
 /* ------------------------------------------------------------------------ *
  * i2c-parport.c I2C bus over parallel port                                 *
  * ------------------------------------------------------------------------ *
-   Copyright (C) 2003-2007 Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
+   Copyright (C) 2003-2008 Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
    
    Based on older i2c-philips-par.c driver
    Copyright (C) 1995-2000 Simon G. Vogl
@@ -143,6 +143,14 @@ static struct i2c_algo_bit_data parport_
 
 /* ----- I2c and parallel port call-back functions and structures --------- */
 
+void i2c_parport_irq(void *data)
+{
+	struct i2c_par *adapter = data;
+
+	dev_dbg(&adapter->adapter.dev, "SMBus alert received\n");
+	schedule_work(&adapter->adapter.alert);
+}
+
 static void i2c_parport_attach (struct parport *port)
 {
 	struct i2c_par *adapter;
@@ -155,7 +163,7 @@ static void i2c_parport_attach (struct p
 
 	pr_debug("i2c-parport: attaching to %s\n", port->name);
 	adapter->pdev = parport_register_device(port, "i2c-parport",
-		NULL, NULL, NULL, PARPORT_FLAG_EXCL, NULL);
+		NULL, NULL, i2c_parport_irq, PARPORT_FLAG_EXCL, adapter);
 	if (!adapter->pdev) {
 		printk(KERN_ERR "i2c-parport: Unable to register with parport\n");
 		goto ERROR0;
@@ -177,7 +185,7 @@ static void i2c_parport_attach (struct p
 	adapter->adapter.algo_data = &adapter->algo_data;
 	adapter->adapter.dev.parent = port->physport->dev;
 
-	if (parport_claim_or_block(adapter->pdev) < 0) {
+	if (parport_claim(adapter->pdev) < 0) {
 		printk(KERN_ERR "i2c-parport: Could not claim parallel port\n");
 		goto ERROR1;
 	}
@@ -189,12 +197,18 @@ static void i2c_parport_attach (struct p
 	if (adapter_parm[type].init.val)
 		line_set(port, 1, &adapter_parm[type].init);
 
-	parport_release(adapter->pdev);
+	/* Setup SMBus alert if supported */
+	if (adapter_parm[type].smbus_alert) {
+		adapter->adapter.do_setup_alert = 1;
+		adapter->adapter.alert_edge_triggered = 1;
+	}
 
 	if (i2c_bit_add_bus(&adapter->adapter) < 0) {
 		printk(KERN_ERR "i2c-parport: Unable to register with I2C\n");
 		goto ERROR1;
 	}
+	if (adapter->adapter.do_setup_alert)
+		parport_enable_irq(port);
 
 	/* Add the new adapter to the list */
 	adapter->next = adapter_list;
@@ -202,6 +216,7 @@ static void i2c_parport_attach (struct p
         return;
 
 ERROR1:
+	parport_release(adapter->pdev);
 	parport_unregister_device(adapter->pdev);
 ERROR0:
 	kfree(adapter);
@@ -215,12 +230,15 @@ static void i2c_parport_detach (struct p
 	for (prev = NULL, adapter = adapter_list; adapter;
 	     prev = adapter, adapter = adapter->next) {
 		if (adapter->pdev->port == port) {
+			if (adapter->adapter.do_setup_alert)
+				parport_disable_irq(port);
 			i2c_del_adapter(&adapter->adapter);
 
 			/* Un-init if needed (power off...) */
 			if (adapter_parm[type].init.val)
 				line_set(port, 0, &adapter_parm[type].init);
 				
+			parport_release(adapter->pdev);
 			parport_unregister_device(adapter->pdev);
 			if (prev)
 				prev->next = adapter->next;
--- linux-2.6.28-rc6.orig/drivers/i2c/busses/i2c-parport.h	2008-11-21 14:49:40.000000000 +0100
+++ linux-2.6.28-rc6/drivers/i2c/busses/i2c-parport.h	2008-11-21 15:18:46.000000000 +0100
@@ -1,7 +1,7 @@
 /* ------------------------------------------------------------------------ *
  * i2c-parport.h I2C bus over parallel port                                 *
  * ------------------------------------------------------------------------ *
-   Copyright (C) 2003-2004 Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
+   Copyright (C) 2003-2008 Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
    
    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
@@ -38,6 +38,7 @@ struct adapter_parm {
 	struct lineop getsda;
 	struct lineop getscl;
 	struct lineop init;
+	int smbus_alert;
 };
 
 static struct adapter_parm adapter_parm[] = {
@@ -73,6 +74,7 @@ static struct adapter_parm adapter_parm[
 		.setscl	= { 0x01, DATA, 1 },
 		.getsda	= { 0x10, STAT, 1 },
 		.init	= { 0xf0, DATA, 0 },
+		.smbus_alert = 1,
 	},
 	/* type 5: ADM1025, ADM1030 and ADM1031 evaluation boards */
 	{
--- linux-2.6.28-rc6.orig/drivers/hwmon/lm90.c	2008-10-27 08:46:47.000000000 +0100
+++ linux-2.6.28-rc6/drivers/hwmon/lm90.c	2008-11-21 17:34:36.000000000 +0100
@@ -157,6 +157,7 @@ static int lm90_detect(struct i2c_client
 static int lm90_probe(struct i2c_client *client,
 		      const struct i2c_device_id *id);
 static void lm90_init_client(struct i2c_client *client);
+static void lm90_alert(struct i2c_client *client, bool flag);
 static int lm90_remove(struct i2c_client *client);
 static struct lm90_data *lm90_update_device(struct device *dev);
 
@@ -190,6 +191,7 @@ static struct i2c_driver lm90_driver = {
 	},
 	.probe		= lm90_probe,
 	.remove		= lm90_remove,
+	.alert		= lm90_alert,
 	.id_table	= lm90_id,
 	.detect		= lm90_detect,
 	.address_data	= &addr_data,
@@ -921,6 +923,18 @@ static int lm90_remove(struct i2c_client
 	return 0;
 }
 
+static void lm90_alert(struct i2c_client *client, bool flag)
+{
+	u8 config;
+
+	/* Disable ALERT# output */
+	lm90_read_reg(client, LM90_REG_R_CONFIG1, &config);
+	config |= 0x80;
+	i2c_smbus_write_byte_data(client, LM90_REG_W_CONFIG1, config);
+
+	dev_warn(&client->dev, "Temperature out of range, please check!\n");
+}
+
 static int lm90_read16(struct i2c_client *client, u8 regh, u8 regl, u16 *value)
 {
 	int err;
@@ -1008,6 +1022,20 @@ static struct lm90_data *lm90_update_dev
 		}
 		lm90_read_reg(client, LM90_REG_R_STATUS, &data->alarms);
 
+		/* Re-enable ALERT# output if alarms are all clear */
+		if ((data->alarms & 0x7c) == 0) {
+			u8 config;
+
+			lm90_read_reg(client, LM90_REG_R_CONFIG1, &config);
+			if (config & 0x80) {
+				dev_dbg(&client->dev, "Re-enabling ALERT#\n");
+				config &= ~0x80;
+				i2c_smbus_write_byte_data(client,
+							  LM90_REG_W_CONFIG1,
+							  config);
+			}
+		}
+
 		data->last_updated = jiffies;
 		data->valid = 1;
 	}


-- 
Jean Delvare
