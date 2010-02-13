From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 1/5] i2c: Add SMBus alert support
Date: Sat, 13 Feb 2010 23:06:56 +0100
Message-ID: <20100213230656.341ec091@hyperion.delvare>
References: <20100213230438.31fd0fd7@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100213230438.31fd0fd7-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Trent Piepho <tpiepho-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

SMBus alert support. The SMBus alert protocol allows several SMBus
slave devices to share a single interrupt pin on the SMBus master,
while still allowing the master to know which slave triggered the
interrupt.

This is based on preliminary work by David Brownell. The key
difference between David's implementation and mine is that his was
part of i2c-core, while mine is split into a separate, standalone
module named i2c-smbus. The i2c-smbus module is meant to include
support for all SMBus extensions to the I2C protocol in the future.

The benefit of this approach is a zero cost for I2C bus segments which
do not need SMBus alert support. Where David's implementation
increased the size of struct i2c_adapter by 7% (40 bytes on i386),
mine doesn't touch it. Where David's implementation added over 150
lines of code to i2c-core (+10%), mine doesn't touch it. The only
change that touches all the users of the i2c subsystem is a new
callback in struct i2c_driver (common to both implementations.) I seem
to remember Trent was worried about the footprint of David'd
implementation, hopefully mine addresses the issue.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: Trent Piepho <tpiepho-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
 Documentation/i2c/smbus-protocol |   16 ++
 drivers/i2c/Makefile             |    2 
 drivers/i2c/i2c-smbus.c          |  264 ++++++++++++++++++++++++++++++++++++++
 include/linux/i2c-smbus.h        |   50 +++++++
 include/linux/i2c.h              |    7 +
 5 files changed, 338 insertions(+), 1 deletion(-)

--- linux-2.6.33-rc7.orig/Documentation/i2c/smbus-protocol	2010-02-12 14:19:47.000000000 +0100
+++ linux-2.6.33-rc7/Documentation/i2c/smbus-protocol	2010-02-12 14:19:51.000000000 +0100
@@ -185,6 +185,22 @@ the protocol. All ARP communications use
 require PEC checksums.
 
 
+SMBus Alert
+===========
+
+SMBus Alert was introduced in Revision 1.0 of the specification.
+
+The SMBus alert protocol allows several SMBus slave devices to share a
+single interrupt pin on the SMBus master, while still allowing the master
+to know which slave triggered the interrupt.
+
+This is implemented the following way in the Linux kernel:
+* I2C bus drivers which support SMBus alert should call
+  i2c_setup_smbus_alert() to setup SMBus alert support.
+* I2C drivers for devices which can trigger SMBus alerts should implement
+  the optional alert() callback.
+
+
 I2C Block Transactions
 ======================
 
--- linux-2.6.33-rc7.orig/drivers/i2c/Makefile	2010-02-12 14:19:47.000000000 +0100
+++ linux-2.6.33-rc7/drivers/i2c/Makefile	2010-02-12 16:08:34.000000000 +0100
@@ -3,7 +3,7 @@
 #
 
 obj-$(CONFIG_I2C_BOARDINFO)	+= i2c-boardinfo.o
-obj-$(CONFIG_I2C)		+= i2c-core.o
+obj-$(CONFIG_I2C)		+= i2c-core.o i2c-smbus.o
 obj-$(CONFIG_I2C_CHARDEV)	+= i2c-dev.o
 obj-y				+= busses/ chips/ algos/
 
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.33-rc7/drivers/i2c/i2c-smbus.c	2010-02-12 16:11:34.000000000 +0100
@@ -0,0 +1,264 @@
+/*
+ * i2c-smbus.c - SMBus extensions to the I2C protocol
+ *
+ * Copyright (C) 2010 Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
+ *
+ * SMBus alert support based on earlier work by David Brownell (2008).
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/semaphore.h>
+#include <linux/interrupt.h>
+#include <linux/workqueue.h>
+#include <linux/i2c.h>
+#include <linux/i2c-smbus.h>
+
+struct i2c_smbus_alert {
+	unsigned int		alert_edge_triggered:1;
+	int			irq;
+	struct work_struct	alert;
+	struct i2c_client	*ara;
+};
+
+struct alert_data {
+	unsigned short		addr;
+	u8			flag:1;
+};
+
+/* If this is the alerting device, notify its driver */
+static int smbus_do_alert(struct device *dev, void *addrp)
+{
+	struct i2c_client *client = i2c_verify_client(dev);
+	struct alert_data *data = addrp;
+
+	if (!client || client->addr != data->addr)
+		return 0;
+	if (client->flags & I2C_CLIENT_TEN)
+		return 0;
+
+	/*
+	 * Drivers should either disable alerts, or provide at least
+	 * a minimal handler.  Lock so client->driver won't change.
+	 */
+	down(&dev->sem);
+	if (client->driver) {
+		if (client->driver->alert)
+			client->driver->alert(client, data->flag);
+		else
+			dev_warn(&client->dev, "no driver alert()!\n");
+	} else
+		dev_dbg(&client->dev, "alert with no driver\n");
+	up(&dev->sem);
+
+	/* Stop iterating after we find the device */
+	return -EBUSY;
+}
+
+/*
+ * The alert IRQ handler needs to hand work off to a task which can issue
+ * SMBus calls, because those sleeping calls can't be made in IRQ context.
+ */
+static void smbus_alert(struct work_struct *work)
+{
+	struct i2c_smbus_alert *data;
+	struct i2c_client *ara;
+	unsigned short prev_addr = 0;	/* Not a valid address */
+
+	data = container_of(work, struct i2c_smbus_alert, alert);
+	ara = data->ara;
+
+	for (;;) {
+		s32 status;
+		struct alert_data data;
+
+		/*
+		 * Devices with pending alerts reply in address order, low
+		 * to high, because of slave transmit arbitration.  After
+		 * responding, an SMBus device stops asserting SMBALERT#.
+		 *
+		 * Note that SMBus 2.0 reserves 10-bit addresess for future
+		 * use.  We neither handle them, nor try to use PEC here.
+		 */
+		status = i2c_smbus_read_byte(ara);
+		if (status < 0)
+			break;
+
+		data.flag = status & 1;
+		data.addr = status >> 1;
+
+		if (data.addr == prev_addr) {
+			dev_warn(&ara->dev, "Duplicate SMBALERT# from dev "
+				"0x%02x, skipping\n", data.addr);
+			break;
+		}
+		dev_dbg(&ara->dev, "SMBALERT# from dev 0x%02x, flag %d\n",
+			data.addr, data.flag);
+
+		/* Notify driver for the device which issued the alert */
+		device_for_each_child(&ara->adapter->dev, &data,
+				      smbus_do_alert);
+		prev_addr = data.addr;
+	}
+
+	/* We handled all alerts; re-enable level-triggered IRQs */
+	if (!data->alert_edge_triggered)
+		enable_irq(data->irq);
+}
+
+static irqreturn_t smbalert_irq(int irq, void *d)
+{
+	struct i2c_smbus_alert *data = d;
+
+	/* Disable level-triggered IRQs until we handle them */
+	if (!data->alert_edge_triggered)
+		disable_irq_nosync(irq);
+
+	schedule_work(&data->alert);
+	return IRQ_HANDLED;
+}
+
+/* Setup SMBALERT# infrastructure */
+static int smbalert_probe(struct i2c_client *ara,
+			  const struct i2c_device_id *id)
+{
+	struct i2c_smbus_alert_setup *setup = ara->dev.platform_data;
+	struct i2c_smbus_alert *data;
+	struct i2c_adapter *adapter = ara->adapter;
+	int res;
+
+	data = kzalloc(sizeof(struct i2c_smbus_alert), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->alert_edge_triggered = setup->alert_edge_triggered;
+	data->irq = setup->irq;
+	INIT_WORK(&data->alert, smbus_alert);
+	data->ara = ara;
+
+	if (setup->irq > 0) {
+		res = devm_request_irq(&ara->dev, setup->irq, smbalert_irq,
+				       0, "smbus_alert", data);
+		if (res) {
+			kfree(data);
+			return res;
+		}
+	}
+
+	i2c_set_clientdata(ara, data);
+	dev_info(&adapter->dev, "supports SMBALERT#, %s trigger\n",
+		 setup->alert_edge_triggered ? "edge" : "level");
+
+	return 0;
+}
+
+/* IRQ resource is managed so it is freed automatically */
+static int smbalert_remove(struct i2c_client *ara)
+{
+	struct i2c_smbus_alert *data = i2c_get_clientdata(ara);
+
+	cancel_work_sync(&data->alert);
+
+	i2c_set_clientdata(ara, NULL);
+	kfree(data);
+	return 0;
+}
+
+static const struct i2c_device_id smbalert_ids[] = {
+	{ "smbus_alert", 0 },
+	{ /* LIST END */ }
+};
+MODULE_DEVICE_TABLE(i2c, smbalert_ids);
+
+static struct i2c_driver smbalert_driver = {
+	.driver = {
+		.name	= "smbus_alert",
+	},
+	.probe		= smbalert_probe,
+	.remove		= smbalert_remove,
+	.id_table	= smbalert_ids,
+};
+
+/**
+ * i2c_setup_smbus_alert - Setup SMBus alert support
+ * @adapter: the target adapter
+ * @setup: setup data for the SMBus alert handler
+ * Context: can sleep
+ *
+ * Setup handling of the SMBus alert protocol on a given I2C bus segment.
+ *
+ * Handling can be done either through our IRQ handler, or by the
+ * adapter (from its handler, periodic polling, or whatever).
+ *
+ * NOTE that if we manage the IRQ, we *MUST* know if it's level or
+ * edge triggered in order to hand it to the workqueue correctly.
+ * If triggering the alert seems to wedge the system, you probably
+ * should have said it's level triggered.
+ *
+ * This returns the ara client, which should be saved for later use with
+ * i2c_handle_smbus_alert() and ultimately i2c_unregister_device(); or NULL
+ * to indicate an error.
+ */
+struct i2c_client *i2c_setup_smbus_alert(struct i2c_adapter *adapter,
+					 struct i2c_smbus_alert_setup *setup)
+{
+	struct i2c_board_info ara_board_info = {
+		I2C_BOARD_INFO("smbus_alert", 0x0c),
+		.platform_data = setup,
+	};
+
+	return i2c_new_device(adapter, &ara_board_info);
+}
+EXPORT_SYMBOL_GPL(i2c_setup_smbus_alert);
+
+/**
+ * i2c_handle_smbus_alert - Handle an SMBus alert
+ * @ara: the ARA client on the relevant adapter
+ * Context: can't sleep
+ *
+ * Helper function to be called from an I2C bus driver's interrupt
+ * handler. It will schedule the alert work, in turn calling the
+ * corresponding I2C device driver's alert function.
+ *
+ * It is assumed that ara is a valid i2c client previously returned by
+ * i2c_setup_smbus_alert().
+ */
+int i2c_handle_smbus_alert(struct i2c_client *ara)
+{
+	struct i2c_smbus_alert *data = i2c_get_clientdata(ara);
+
+	return schedule_work(&data->alert);
+}
+EXPORT_SYMBOL_GPL(i2c_handle_smbus_alert);
+
+static int __init i2c_smbus_init(void)
+{
+	return i2c_add_driver(&smbalert_driver);
+}
+
+static void __exit i2c_smbus_exit(void)
+{
+	i2c_del_driver(&smbalert_driver);
+}
+
+module_init(i2c_smbus_init);
+module_exit(i2c_smbus_exit);
+
+MODULE_AUTHOR("Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>");
+MODULE_DESCRIPTION("SMBus protocol extensions support");
+MODULE_LICENSE("GPL");
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.33-rc7/include/linux/i2c-smbus.h	2010-02-12 16:08:43.000000000 +0100
@@ -0,0 +1,50 @@
+/*
+ * i2c-smbus.h - SMBus extensions to the I2C protocol
+ *
+ * Copyright (C) 2010 Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#ifndef _LINUX_I2C_SMBUS_H
+#define _LINUX_I2C_SMBUS_H
+
+#include <linux/i2c.h>
+
+
+/**
+ * i2c_smbus_alert_setup - platform data for the smbus_alert i2c client
+ * @alert_edge_triggered: whether the alert interrupt is edge (1) or level (0)
+ *		triggered
+ * @irq: IRQ number, if the smbus_alert driver should take care of interrupt
+ *		handling
+ *
+ * If irq is not specified, the smbus_alert driver doesn't take care of
+ * interrupt handling. In that case it is up to the I2C bus driver to either
+ * handle the interrupts or to poll for alerts.
+ *
+ * If irq is specified then it it crucial that alert_edge_triggered is
+ * properly set.
+ */
+struct i2c_smbus_alert_setup {
+	unsigned int		alert_edge_triggered:1;
+	int			irq;
+};
+
+struct i2c_client *i2c_setup_smbus_alert(struct i2c_adapter *adapter,
+					 struct i2c_smbus_alert_setup *setup);
+int i2c_handle_smbus_alert(struct i2c_client *ara);
+
+#endif /* _LINUX_I2C_SMBUS_H */
--- linux-2.6.33-rc7.orig/include/linux/i2c.h	2010-02-12 14:19:47.000000000 +0100
+++ linux-2.6.33-rc7/include/linux/i2c.h	2010-02-12 14:19:51.000000000 +0100
@@ -152,6 +152,13 @@ struct i2c_driver {
 	int (*suspend)(struct i2c_client *, pm_message_t mesg);
 	int (*resume)(struct i2c_client *);
 
+	/* Alert callback, for example for the SMBus alert protocol.
+	 * The format and meaning of the data value depends on the protocol.
+	 * For the SMBus alert protocol, there is a single bit of data passed
+	 * as the alert response's low bit ("event flag").
+	 */
+	void (*alert)(struct i2c_client *, unsigned int data);
+
 	/* a ioctl like command that can be used to perform specific functions
 	 * with the device.
 	 */

-- 
Jean Delvare
