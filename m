From: Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>
Subject: [PATCH 5/6] i2c: Multiplexed I2C bus core support.
Date: Thu,  5 Feb 2009 14:36:12 +0100
Message-ID: <1233840973-13268-6-git-send-email-giometti@linux.it>
References: <1233840973-13268-1-git-send-email-giometti@linux.it>
 <1233840973-13268-2-git-send-email-giometti@linux.it>
 <1233840973-13268-3-git-send-email-giometti@linux.it>
 <1233840973-13268-4-git-send-email-giometti@linux.it>
 <1233840973-13268-5-git-send-email-giometti@linux.it>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1233840973-13268-5-git-send-email-giometti-k2GhghHVRtY@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>, Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Add to the I2C core the ability to handle multiplexed I2C bus
topologies by presenting each multiplexed segment as a I2C adapter.

Signed-off-by: Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>
---
 drivers/i2c/Kconfig        |   10 +++
 drivers/i2c/Makefile       |    3 +-
 drivers/i2c/i2c-mux.c      |  180 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/i2c/muxes/Kconfig  |    8 ++
 drivers/i2c/muxes/Makefile |    6 ++
 include/linux/i2c-id.h     |    3 +
 include/linux/i2c.h        |   14 ++++
 7 files changed, 223 insertions(+), 1 deletions(-)
 create mode 100644 drivers/i2c/i2c-mux.c
 create mode 100644 drivers/i2c/muxes/Kconfig
 create mode 100644 drivers/i2c/muxes/Makefile

diff --git a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig
index 711ca08..78dc245 100644
--- a/drivers/i2c/Kconfig
+++ b/drivers/i2c/Kconfig
@@ -27,6 +27,16 @@ config I2C_BOARDINFO
 	boolean
 	default y
 
+config I2C_MUX
+	tristate "I2C bus multiplexing support"
+	depends on I2C
+	help
+	  Say Y here if you want the I2C core to support the ability to
+	  handle multiplexed I2C bus topologies, by presenting each
+	  multiplexed segment as a I2C adapter.
+
+source drivers/i2c/muxes/Kconfig
+
 config I2C_CHARDEV
 	tristate "I2C device interface"
 	help
diff --git a/drivers/i2c/Makefile b/drivers/i2c/Makefile
index ba26e6c..281e2a7 100644
--- a/drivers/i2c/Makefile
+++ b/drivers/i2c/Makefile
@@ -4,8 +4,9 @@
 
 obj-$(CONFIG_I2C_BOARDINFO)	+= i2c-boardinfo.o
 obj-$(CONFIG_I2C)		+= i2c-core.o
+obj-$(CONFIG_I2C_MUX)		+= i2c-mux.o
 obj-$(CONFIG_I2C_CHARDEV)	+= i2c-dev.o
-obj-y				+= busses/ chips/ algos/
+obj-y				+= busses/ chips/ muxes/ algos/
 
 ifeq ($(CONFIG_I2C_DEBUG_CORE),y)
 EXTRA_CFLAGS += -DDEBUG
diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
new file mode 100644
index 0000000..390dbc3
--- /dev/null
+++ b/drivers/i2c/i2c-mux.c
@@ -0,0 +1,180 @@
+/*
+ * Multiplexed I2C bus driver.
+ *
+ * Copyright (c) 2008-2009 Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>
+ * Copyright (c) 2008-2009 Eurotech S.p.A. <info-ymFC7zkAqBI1GQ1Ptb7lUw@public.gmane.org>
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
+struct i2c_mux_priv {
+	struct i2c_adapter adap;
+	struct i2c_algorithm algo;
+
+	struct i2c_adapter *parent_adap;
+	void *client;			/* The mux chip/device */
+	u32 id;				/* the mux id */
+
+	int (*select)(struct i2c_adapter *, void *, u32);
+	int (*deselect)(struct i2c_adapter *, void *, u32);
+};
+
+#define VIRT_TIMEOUT		(HZ/2)
+#define VIRT_RETRIES		3
+
+static int i2c_mux_master_xfer(struct i2c_adapter *adap,
+				struct i2c_msg msgs[], int num)
+{
+	struct i2c_mux_priv *priv = adap->algo_data;
+	struct i2c_adapter *parent = priv->parent_adap;
+	int ret;
+
+	/* Grab the lock for the parent adapter. We already hold the lock for
+	 * the virtual adapter. Then select the right mux port and perform
+	 * the transfer.
+	 */
+
+	mutex_lock_nested(&parent->bus_lock, SINGLE_DEPTH_NESTING);
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
+static int i2c_mux_smbus_xfer(struct i2c_adapter *adap,
+				u16 addr, unsigned short flags,
+				char read_write, u8 command,
+				int size, union i2c_smbus_data *data)
+{
+	struct i2c_mux_priv *priv = adap->algo_data;
+	struct i2c_adapter *parent = priv->parent_adap;
+	int ret;
+
+	/* Grab the lock for the parent adapter.  We already hold the lock for
+	 * the virtual adapter.  Then select the right mux port and perform
+	 * the transfer.
+	 */
+
+	mutex_lock_nested(&parent->bus_lock, SINGLE_DEPTH_NESTING);
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
+static u32 i2c_mux_functionality(struct i2c_adapter *adap)
+{
+	struct i2c_mux_priv *priv = adap->algo_data;
+	struct i2c_adapter *parent = priv->parent_adap;
+
+	return parent->algo->functionality(parent);
+}
+
+struct i2c_adapter *i2c_add_mux_adapter(struct i2c_adapter *parent,
+				void *client, u32 force_nr, u32 mux_val,
+				int (*select_cb) (struct i2c_adapter *,
+						void *, u32),
+				int (*deselect_cb) (struct i2c_adapter *,
+						void *, u32))
+{
+	struct i2c_mux_priv *priv;
+	int ret;
+
+	priv = kzalloc(sizeof(struct i2c_mux_priv), GFP_KERNEL);
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
+		priv->algo.master_xfer = i2c_mux_master_xfer;
+	if (parent->algo->smbus_xfer)
+		priv->algo.smbus_xfer = i2c_mux_smbus_xfer;
+	priv->algo.functionality = i2c_mux_functionality;
+
+	/* Now fill out new adapter structure */
+	snprintf(priv->adap.name, sizeof(priv->adap.name),
+			"i2c-%d-mux (mux %02x)",
+			i2c_adapter_id(parent), mux_val);
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
+	dev_info(&parent->dev, "i2c-mux-%d: Virtual I2C bus - "
+		"physical bus i2c-%d, port %d\n",
+		i2c_adapter_id(&priv->adap), i2c_adapter_id(parent), mux_val);
+
+	return &priv->adap;
+}
+EXPORT_SYMBOL_GPL(i2c_add_mux_adapter);
+
+int i2c_del_mux_adapter(struct i2c_adapter *adap)
+{
+	struct i2c_mux_priv *priv = adap->algo_data;
+	int ret;
+
+	ret = i2c_del_adapter(adap);
+	if (ret < 0)
+		return ret;
+	kfree(priv);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(i2c_del_mux_adapter);
+
+MODULE_AUTHOR("Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>");
+MODULE_DESCRIPTION("Virtual I2C driver for multiplexed I2C busses");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/i2c/muxes/Kconfig b/drivers/i2c/muxes/Kconfig
new file mode 100644
index 0000000..95b9bde
--- /dev/null
+++ b/drivers/i2c/muxes/Kconfig
@@ -0,0 +1,8 @@
+#
+# Multiplexer I2C chip drivers configuration
+#
+
+menu "Multiplexer I2C Chip support"
+	depends on I2C && I2C_MUX && EXPERIMENTAL
+
+endmenu
diff --git a/drivers/i2c/muxes/Makefile b/drivers/i2c/muxes/Makefile
new file mode 100644
index 0000000..5e70bde
--- /dev/null
+++ b/drivers/i2c/muxes/Makefile
@@ -0,0 +1,6 @@
+#
+# Makefile for multiplexer I2C chip drivers.
+
+ifeq ($(CONFIG_I2C_DEBUG_CHIP),y)
+EXTRA_CFLAGS += -DDEBUG
+endif
diff --git a/include/linux/i2c-id.h b/include/linux/i2c-id.h
index 01d67ba..d4f97b6 100644
--- a/include/linux/i2c-id.h
+++ b/include/linux/i2c-id.h
@@ -162,4 +162,7 @@
 #define I2C_HW_SAA7146		0x060000 /* SAA7146 video decoder bus */
 #define I2C_HW_SAA7134		0x090000 /* SAA7134 video decoder bus */
 
+/* --- Virtual adapter mark */
+#define I2C_HW_VIRT            0x80000000
+
 #endif /* LINUX_I2C_ID_H */
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 20873d4..748fc22 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -588,6 +588,20 @@ union i2c_smbus_data {
 #define I2C_SMBUS_BLOCK_PROC_CALL   7		/* SMBus 2.0 */
 #define I2C_SMBUS_I2C_BLOCK_DATA    8
 
+/*
+ * Called to create a 'virtual' i2c bus which represents a multiplexed bus
+ * segment.  The client and mux_val are passed to the select and deselect
+ * callback functions to perform hardware-specific mux control.
+ */
+struct i2c_adapter *i2c_add_mux_adapter(struct i2c_adapter *parent,
+				void *client, u32 force_nr, u32 mux_val,
+				int (*select_cb) (struct i2c_adapter *,
+						void *, u32),
+				int (*deselect_cb) (struct i2c_adapter *,
+						void *, u32));
+
+int i2c_del_mux_adapter(struct i2c_adapter *adap);
+
 
 #ifdef __KERNEL__
 
-- 
1.5.6.3
