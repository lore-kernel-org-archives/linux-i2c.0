From: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Subject: [RFC] i2c-smbus: smbus alert revisited
Date: Wed, 20 Aug 2014 19:40:01 +0100
Message-ID: <20140820194001.24d9e67a@www.etchedpixels.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

This follows on from the discussion in late March before Srinivas got
busy on other things.

This is just an RFC for a next generation set of patches. The idea is as
follows

- If an adapter knows about its ARA and smbus alerts then the adapter
  creates its own interrupt handler as before

- If a client knows it needs smbus alerts it calls
  i2c_require_smbus_alert. This ensures that there is an ARA handler
  registered and tells the client whether the adapter is handling it
  anyway or not.

- When the client learns that an ARA event has occurred it calls
  i2c_smbus_alert_event which uses the existing ARA mechanism to kick
  things off.


Leaving it to the client and introducing that little bit of asymmetry
means

- we don't have to do expensive polling

- we cope with the case where there isn't a single smbalert line instead
  each device has a GPIO

- we cope with the case of devices that need to trigger an ARA in other
  ways (eg with no IRQ or GPIO but discovering a particular bit is set
  and needing an ARA to unwedge it)

It also gives us a hook from the client so that in future we can
address the case of adapters that can do SMB alert in hardware but are
sometimes wired to devices that use the same port and are not using ARA.

This is just an RFC, it compiles but thats all I can say for sure. Just
want to know if this is the right direction before actually doing any
more serious work on it.

Alan


---

diff --git a/drivers/i2c/i2c-smbus.c b/drivers/i2c/i2c-smbus.c
index fc99f0d..955352c 100644
--- a/drivers/i2c/i2c-smbus.c
+++ b/drivers/i2c/i2c-smbus.c
@@ -30,7 +30,7 @@
 #include <linux/slab.h>
 
 struct i2c_smbus_alert {
-	unsigned int		alert_edge_triggered:1;
+	unsigned int		alert_edge_triggered:1, client:1;
 	int			irq;
 	struct work_struct	alert;
 	struct i2c_client	*ara;		/* Alert response address */
@@ -123,6 +123,29 @@ static void smbus_alert(struct work_struct *work)
 		enable_irq(alert->irq);
 }
 
+/**
+ *	i2c_smbus_alert_event	-	possible ARA event
+ *	@client: client which thinks an ARA may have occurred
+ *
+ *	Called by i2c clients that have requested ARA support and been
+ *	advised there is no host adapter interrupt. This may be invoked
+ *	from a driver specific IRQ, from driver polling or when the 
+ *	driver discovers by other means that an ARA may be present
+ */
+void i2c_smbus_alert_event(struct i2c_client *client)
+{
+	struct i2c_adapter *adapter = client->adapter;
+	struct i2c_client *smbus_ara = adapter->smbus_ara;
+	struct i2c_smbus_alert *alert;
+
+	if (smbus_ara != NULL) {
+		alert = i2c_get_clientdata(smbus_ara);
+		if (alert->client)
+			schedule_work(&alert->alert);
+	}
+}
+EXPORT_SYMBOL_GPL(i2c_smbus_alert_event);
+
 static irqreturn_t smbalert_irq(int irq, void *d)
 {
 	struct i2c_smbus_alert *alert = d;
@@ -151,6 +174,7 @@ static int smbalert_probe(struct i2c_client *ara,
 
 	alert->alert_edge_triggered = setup->alert_edge_triggered;
 	alert->irq = setup->irq;
+	alert->client = setup->client;
 	INIT_WORK(&alert->alert, smbus_alert);
 	alert->ara = ara;
 
@@ -162,8 +186,9 @@ static int smbalert_probe(struct i2c_client *ara,
 	}
 
 	i2c_set_clientdata(ara, alert);
-	dev_info(&adapter->dev, "supports SMBALERT#, %s trigger\n",
-		 setup->alert_edge_triggered ? "edge" : "level");
+	if (setup->client == 0)
+		dev_info(&adapter->dev, "supports SMBALERT#, %s trigger\n",
+			 setup->alert_edge_triggered ? "edge" : "level");
 
 	return 0;
 }
@@ -201,7 +226,9 @@ static struct i2c_driver smbalert_driver = {
  * Setup handling of the SMBus alert protocol on a given I2C bus segment.
  *
  * Handling can be done either through our IRQ handler, or by the
- * adapter (from its handler, periodic polling, or whatever).
+ * adapter (from its handler, periodic polling, or whatever), or can
+ * be configured by a client for cases where we only learn the IRQ from
+ * later discovery.
  *
  * NOTE that if we manage the IRQ, we *MUST* know if it's level or
  * edge triggered in order to hand it to the workqueue correctly.
@@ -219,8 +246,11 @@ struct i2c_client *i2c_setup_smbus_alert(struct i2c_adapter *adapter,
 		I2C_BOARD_INFO("smbus_alert", 0x0c),
 		.platform_data = setup,
 	};
+	struct i2c_client *ret;
 
-	return i2c_new_device(adapter, &ara_board_info);
+	ret = i2c_new_device(adapter, &ara_board_info);
+	adapter->smbus_ara = ret;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(i2c_setup_smbus_alert);
 
@@ -246,6 +276,54 @@ EXPORT_SYMBOL_GPL(i2c_handle_smbus_alert);
 
 module_i2c_driver(smbalert_driver);
 
+/**
+ * i2c_require_smbus_alert - Client discovered SMBus alert
+ * @c: client requiring ARA
+ *
+ * When a client needs an ARA it calls this method. If the bus adapter
+ * supports ARA and already knows how to do so then it will already have
+ * configured for ARA and this is a no-op. If not then we set up an ARA
+ * on the adapter.
+ *
+ * We *cannot* simply register a new IRQ handler for this because we might
+ * have multiple GPIO interrupts to devices all of which trigger an ARA.
+ *
+ * Return:
+ *	0	- adapter is doing ARA, do nothing
+ *	1	- adapter is not doing ARA, call the i2c_smbus_alert_event
+ *		  helper on possible events
+ *	-1	- ARA handler set up failed (eg a device owns that address)
+ */
+
+int i2c_require_smbus_alert(struct i2c_client *c)
+{
+	struct i2c_adapter *adapter = c->adapter;
+	struct i2c_smbus_alert_setup setup;
+	struct i2c_client *ara;
+	struct i2c_smbus_alert *alert;
+
+	/* ARA is already known and handled by the adapter (ideal case)
+	   or another client has specified ARA is needed */
+	ara = adapter->smbus_ara;
+
+	if (ara) {
+		alert = i2c_get_clientdata(ara);
+		return alert->client;
+	}
+
+	/* Client driven, do not set up a new IRQ handler */
+	setup.client = 1;
+	setup.irq = 0;
+	setup.alert_edge_triggered = 0;
+
+	i2c_setup_smbus_alert(adapter, &setup);
+	/* Has it all gone horribly wrong ? */
+	if (adapter->smbus_ara == NULL)
+		return -1;
+	return 1;
+}
+EXPORT_SYMBOL_GPL(i2c_require_smbus_alert);
+
 MODULE_AUTHOR("Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>");
 MODULE_DESCRIPTION("SMBus protocol extensions support");
 MODULE_LICENSE("GPL");
diff --git a/include/linux/i2c-smbus.h b/include/linux/i2c-smbus.h
index 8f1b086..c9727b9 100644
--- a/include/linux/i2c-smbus.h
+++ b/include/linux/i2c-smbus.h
@@ -29,6 +29,7 @@
  * i2c_smbus_alert_setup - platform data for the smbus_alert i2c client
  * @alert_edge_triggered: whether the alert interrupt is edge (1) or level (0)
  *		triggered
+ * @client: true if the alert is client not adapter created
  * @irq: IRQ number, if the smbus_alert driver should take care of interrupt
  *		handling
  *
@@ -40,7 +41,7 @@
  * properly set.
  */
 struct i2c_smbus_alert_setup {
-	unsigned int		alert_edge_triggered:1;
+	unsigned int		alert_edge_triggered:1, client:1;
 	int			irq;
 };
 
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index ea50766..5c40a91 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -443,6 +443,8 @@ struct i2c_adapter {
 	struct list_head userspace_clients;
 
 	struct i2c_bus_recovery_info *bus_recovery_info;
+
+	struct i2c_client *smbus_ara;	/* ARA for SMBUS if present */
 };
 #define to_i2c_adapter(d) container_of(d, struct i2c_adapter, dev)
 
