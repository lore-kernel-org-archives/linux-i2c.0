From: Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>
Subject: [PATCH] i2c: virtual i2c adapter support.
Date: Thu, 19 Jun 2008 19:14:59 +0200
Message-ID: <1213895701-9872-2-git-send-email-giometti@linux.it>
References: <>
 <1213895701-9872-1-git-send-email-giometti@linux.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <1213895701-9872-1-git-send-email-giometti-k2GhghHVRtY@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Cc: Ben Dooks <ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Simplifies access to complex multiplexed I2C bus topologies, by
presenting each multiplexed bus segment as a virtual I2C adapter. In
this manner I2C devices "after" the multiplexer can ba managed as
usual.

Signed-off-by: Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>
---
 drivers/i2c/Kconfig    |    9 +++
 drivers/i2c/Makefile   |    1 +
 drivers/i2c/i2c-core.c |   37 +++++++---
 drivers/i2c/i2c-virt.c |  189 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/i2c-id.h |    3 +
 include/linux/i2c.h    |   18 +++++
 6 files changed, 246 insertions(+), 11 deletions(-)
 create mode 100644 drivers/i2c/i2c-virt.c

diff --git a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig
index 9686734..053fe2f 100644
--- a/drivers/i2c/Kconfig
+++ b/drivers/i2c/Kconfig
@@ -27,6 +27,15 @@ config I2C_BOARDINFO
 	boolean
 	default y
 
+config I2C_VIRT
+	tristate "I2C virtual adapter support"
+	depends on I2C
+	help
+	  Say Y here if you want the I2C core to support the ability to have
+	  virtual adapters. Virtual adapters are useful to handle multiplexed
+	  I2C bus topologies, by presenting each multiplexed segment as a
+	  I2C adapter.
+
 config I2C_CHARDEV
 	tristate "I2C device interface"
 	help
diff --git a/drivers/i2c/Makefile b/drivers/i2c/Makefile
index ba26e6c..db72ed9 100644
--- a/drivers/i2c/Makefile
+++ b/drivers/i2c/Makefile
@@ -4,6 +4,7 @@
 
 obj-$(CONFIG_I2C_BOARDINFO)	+= i2c-boardinfo.o
 obj-$(CONFIG_I2C)		+= i2c-core.o
+obj-$(CONFIG_I2C_VIRT)		+= i2c-virt.o
 obj-$(CONFIG_I2C_CHARDEV)	+= i2c-dev.o
 obj-y				+= busses/ chips/ algos/
 
diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index d0175f4..a0261ea 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -573,34 +573,32 @@ static int i2c_do_del_adapter(struct device_driver *d, void *data)
 }
 
 /**
- * i2c_del_adapter - unregister I2C adapter
+ * i2c_del_adapter_nolock - unregister I2C adapter
  * @adap: the adapter being unregistered
  * Context: can sleep
  *
  * This unregisters an I2C adapter which was previously registered
- * by @i2c_add_adapter or @i2c_add_numbered_adapter.
+ * by @i2c_add_adapter or @i2c_add_numbered_adapter but without lock
+ * protection! For normal usage you may wish using @i2c_del_adapter.
  */
-int i2c_del_adapter(struct i2c_adapter *adap)
+int i2c_del_adapter_nolock(struct i2c_adapter *adap)
 {
 	struct list_head  *item, *_n;
 	struct i2c_client *client;
-	int res = 0;
-
-	mutex_lock(&core_lock);
+	int res;
 
 	/* First make sure that this adapter was ever added */
 	if (idr_find(&i2c_adapter_idr, adap->nr) != adap) {
 		pr_debug("i2c-core: attempting to delete unregistered "
 			 "adapter [%s]\n", adap->name);
-		res = -EINVAL;
-		goto out_unlock;
+		return -EINVAL;
 	}
 
 	/* Tell drivers about this removal */
 	res = bus_for_each_drv(&i2c_bus_type, NULL, adap,
 			       i2c_do_del_adapter);
 	if (res)
-		goto out_unlock;
+		return res;
 
 	/* detach any active clients. This must be done first, because
 	 * it can fail; in which case we give up. */
@@ -621,7 +619,7 @@ int i2c_del_adapter(struct i2c_adapter *adap)
 			dev_err(&adap->dev, "detach_client failed for client "
 				"[%s] at address 0x%02x\n", client->name,
 				client->addr);
-			goto out_unlock;
+			return res;
 		}
 	}
 
@@ -637,8 +635,25 @@ int i2c_del_adapter(struct i2c_adapter *adap)
 
 	dev_dbg(&adap->dev, "adapter [%s] unregistered\n", adap->name);
 
- out_unlock:
+	return 0;
+}
+EXPORT_SYMBOL(i2c_del_adapter_nolock);
+
+/**
+ * i2c_del_adapter - unregister I2C adapter
+ * @adap: the adapter being unregistered
+ * Context: can sleep
+ *
+ * The same as @i2c_del_adapter_nolock but with lock protection.
+ */
+int i2c_del_adapter(struct i2c_adapter *adap)
+{
+	int res;
+
+	mutex_lock(&core_lock);
+	res = i2c_del_adapter_nolock(adap);
 	mutex_unlock(&core_lock);
+
 	return res;
 }
 EXPORT_SYMBOL(i2c_del_adapter);
diff --git a/drivers/i2c/i2c-virt.c b/drivers/i2c/i2c-virt.c
new file mode 100644
index 0000000..b057f68
--- /dev/null
+++ b/drivers/i2c/i2c-virt.c
@@ -0,0 +1,189 @@
+/*
+ * i2c-virt.c - Virtual I2C bus driver.
+ *
+ * Copyright (c) 2008 Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>
+ * Copyright (c) 2008 Eurotech S.p.A. <info-ymFC7zkAqBI1GQ1Ptb7lUw@public.gmane.org>
+ *
+ * Simplifies access to complex multiplexed I2C bus topologies, by presenting
+ * each multiplexed bus segment as a virtual I2C adapter.  Supports multi-level
+ * mux'ing (mux behind a mux).
+ *
+ * Based on:
+ *    i2c-virt.c from Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
+ *    i2c-virtual.c from Copyright (c) 2004 Google, Inc. (Ken Harrenstien)
+ *    i2c-virtual.c from Brian Kuschak <bkuschak-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
+ * which was:
+ *    Adapted from i2c-adap-ibm_ocp.c
+ *    Original file Copyright 2000-2002 MontaVista Software Inc.
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/i2c.h>
+#include <linux/i2c-id.h>
+
+struct i2c_virt_priv {
+	struct i2c_adapter adap;
+	struct i2c_algorithm algo;
+
+	struct i2c_adapter *parent_adap;
+	struct i2c_client *client;	/* The mux chip/device */
+
+	u32 id;				/* the mux id */
+
+	int (*select)(struct i2c_adapter *, struct i2c_client *, u32);
+					/* Enable the mux */
+	int (*deselect)(struct i2c_adapter *, struct i2c_client *, u32);
+					/* Disable the mux */
+};
+
+#define VIRT_TIMEOUT		(HZ/2)
+#define VIRT_RETRIES		3
+
+static int i2c_virt_master_xfer(struct i2c_adapter *adap,
+				struct i2c_msg msgs[], int num)
+{
+	struct i2c_virt_priv *priv = adap->algo_data;
+	struct i2c_adapter *parent = priv->parent_adap;
+	int ret;
+
+	/* Grab the lock for the parent adapter. We already hold the lock for
+	 * the virtual adapter. Then select the right mux port and perform
+	 * the transfer.
+	 */
+
+	mutex_lock(&parent->bus_lock);
+
+	ret = priv->select(parent, priv->client, priv->id);
+	if (ret >= 0)
+		ret = parent->algo->master_xfer(parent, msgs, num);
+	priv->deselect(parent, priv->client, priv->id);
+
+	mutex_unlock(&parent->bus_lock);
+
+	return ret;
+}
+
+static int i2c_virt_smbus_xfer(struct i2c_adapter *adap,
+				u16 addr, unsigned short flags,
+				char read_write, u8 command,
+				int size, union i2c_smbus_data *data)
+{
+	struct i2c_virt_priv *priv = adap->algo_data;
+	struct i2c_adapter *parent = priv->parent_adap;
+	int ret;
+
+	/* Grab the lock for the parent adapter.  We already hold the lock for
+	 * the virtual adapter.  Then select the right mux port and perform
+	 * the transfer.
+	 */
+
+	mutex_lock(&parent->bus_lock);
+
+	ret = priv->select(parent, priv->client, priv->id);
+	if (ret == 0)
+		ret = parent->algo->smbus_xfer(parent, addr, flags,
+					   read_write, command, size, data);
+	priv->deselect(parent, priv->client, priv->id);
+
+	mutex_unlock(&parent->bus_lock);
+
+	return ret;
+}
+
+/* Return the parent's functionality for the virtual adapter */
+static u32 i2c_virt_functionality(struct i2c_adapter *adap)
+{
+	struct i2c_virt_priv *priv = adap->algo_data;
+	struct i2c_adapter *parent = priv->parent_adap;
+
+	return parent->algo->functionality(parent);
+}
+
+struct i2c_adapter *i2c_add_virt_adapter(struct i2c_adapter *parent,
+				struct i2c_client *client,
+				u32 force_nr, u32 mux_val,
+				int (*select_cb) (struct i2c_adapter *,
+						struct i2c_client *, u32),
+				int (*deselect_cb) (struct i2c_adapter *,
+						struct i2c_client *, u32))
+{
+	struct i2c_virt_priv *priv;
+	int ret;
+
+	priv = kzalloc(sizeof(struct i2c_virt_priv), GFP_KERNEL);
+	if (!priv)
+		return NULL;
+
+	/* Set up private adapter data */
+	priv->parent_adap = parent;
+	priv->client = client;
+	priv->id = mux_val;
+	priv->select = select_cb;
+	priv->deselect = deselect_cb;
+
+	/* Need to do algo dynamically because we don't know ahead
+	 * of time what sort of physical adapter we'll be dealing with.
+	 */
+	if (parent->algo->master_xfer)
+		priv->algo.master_xfer = i2c_virt_master_xfer;
+	if (parent->algo->smbus_xfer)
+		priv->algo.smbus_xfer = i2c_virt_smbus_xfer;
+	priv->algo.functionality = i2c_virt_functionality;
+
+	/* Now fill out new adapter structure */
+	snprintf(priv->adap.name, sizeof(priv->adap.name),
+			"i2c-%d-virt (mux %02x:%02x)",
+			i2c_adapter_id(parent), client->addr, mux_val);
+	priv->adap.owner = THIS_MODULE;
+	priv->adap.id = I2C_HW_VIRT | i2c_adapter_id(parent);
+	priv->adap.algo = &priv->algo;
+	priv->adap.algo_data = priv;
+	priv->adap.timeout = VIRT_TIMEOUT;
+	priv->adap.retries = VIRT_RETRIES;
+	priv->adap.dev.parent = &parent->dev;
+
+	if (force_nr) {
+		priv->adap.nr = force_nr;
+		ret = i2c_add_numbered_adapter(&priv->adap);
+	} else
+		ret = i2c_add_adapter(&priv->adap);
+	if (ret < 0) {
+		kfree(priv);
+		return NULL;
+	}
+
+	dev_info(&parent->dev, "i2c-virt-%d: Virtual I2C bus - "
+		"physical bus i2c-%d, multiplexer 0x%02x port %d\n",
+		i2c_adapter_id(&priv->adap), i2c_adapter_id(parent),
+		client->addr, mux_val);
+
+	return &priv->adap;
+}
+EXPORT_SYMBOL_GPL(i2c_add_virt_adapter);
+
+int i2c_del_virt_adapter(struct i2c_adapter *adap)
+{
+	struct i2c_virt_priv *priv = adap->algo_data;
+	int ret;
+
+	/* Should use nolock version since I2C core_lock is hold by
+	 * @i2c_del_driver.
+	 */
+	ret = i2c_del_adapter_nolock(adap);
+	if (ret < 0)
+		return ret;
+	kfree(priv);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(i2c_del_virt_adapter);
+
+MODULE_AUTHOR("Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org, " \
+		"Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>");
+MODULE_DESCRIPTION("Virtual I2C driver for multiplexed I2C busses");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/i2c-id.h b/include/linux/i2c-id.h
index 580acc9..ba19ef9 100644
--- a/include/linux/i2c-id.h
+++ b/include/linux/i2c-id.h
@@ -176,4 +176,7 @@
 #define I2C_HW_SAA7146		0x060000 /* SAA7146 video decoder bus */
 #define I2C_HW_SAA7134		0x090000 /* SAA7134 video decoder bus */
 
+/* --- Virtual adapter mark */
+#define I2C_HW_VIRT		0x80000000
+
 #endif /* LINUX_I2C_ID_H */
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index fb9af6a..2ea8555 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -381,6 +381,7 @@ struct i2c_client_address_data {
 extern int i2c_add_adapter(struct i2c_adapter *);
 extern int i2c_del_adapter(struct i2c_adapter *);
 extern int i2c_add_numbered_adapter(struct i2c_adapter *);
+extern int i2c_del_adapter_nolock(struct i2c_adapter *);
 
 extern int i2c_register_driver(struct module *, struct i2c_driver *);
 extern void i2c_del_driver(struct i2c_driver *);
@@ -553,6 +554,23 @@ union i2c_smbus_data {
 #define I2C_SMBUS_BLOCK_PROC_CALL   7		/* SMBus 2.0 */
 #define I2C_SMBUS_I2C_BLOCK_DATA    8
 
+/*
+ * Called to create a 'virtual' i2c bus which represents a multiplexed bus
+ * segment.  The client and mux_val are passed to the select and deselect
+ * callback functions to perform hardware-specific mux control.
+ *
+ * The caller is expected to have the core_lists lock
+ */
+struct i2c_adapter *i2c_add_virt_adapter(struct i2c_adapter *parent,
+				struct i2c_client *client,
+				u32 force_nr, u32 mux_val,
+				int (*select_cb) (struct i2c_adapter *,
+						struct i2c_client *, u32),
+				int (*deselect_cb) (struct i2c_adapter *,
+						struct i2c_client *, u32));
+
+int i2c_del_virt_adapter(struct i2c_adapter *adap);
+
 
 #ifdef __KERNEL__
 
-- 
1.5.4.3


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
