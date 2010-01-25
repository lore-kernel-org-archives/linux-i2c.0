From: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Subject: [PATCH 1/2] i2c: Multiplexed I2C bus core support.
Date: Mon, 25 Jan 2010 13:13:48 +0100
Message-ID: <4B5D8AFC.5060209@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>, "Delvare, Jean " <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Subject: [PATCH 1/2] i2c: Multiplexed I2C bus core support.

Signed-off-by: Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>
Signed-off-by: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
---
 drivers/i2c/Kconfig        |   10 +++
 drivers/i2c/Makefile       |    3 +-
 drivers/i2c/i2c-core.c     |   73 +++++++++++++++++--
 drivers/i2c/i2c-dev.c      |   32 ++++++++-
 drivers/i2c/i2c-mux.c      |  167
++++++++++++++++++++++++++++++++++++++++++++
 drivers/i2c/muxes/Kconfig  |    8 ++
 drivers/i2c/muxes/Makefile |    6 ++
 include/linux/i2c.h        |   14 ++++
 8 files changed, 303 insertions(+), 10 deletions(-)
 create mode 100755 drivers/i2c/i2c-mux.c
 create mode 100755 drivers/i2c/muxes/Kconfig
 create mode 100755 drivers/i2c/muxes/Makefile

diff --git a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig
index d7ece13..0c2f86a 100755
--- a/drivers/i2c/Kconfig
+++ b/drivers/i2c/Kconfig
@@ -35,6 +35,16 @@ config I2C_COMPAT
 	  other user-space package which expects i2c adapters to be class
 	  devices. If you don't know, say Y.

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
index ba26e6c..281e2a7 100755
--- a/drivers/i2c/Makefile
+++ b/drivers/i2c/Makefile
@@ -4,8 +4,9 @@

 obj-$(CONFIG_I2C_BOARDINFO)	+=3D i2c-boardinfo.o
 obj-$(CONFIG_I2C)		+=3D i2c-core.o
+obj-$(CONFIG_I2C_MUX)		+=3D i2c-mux.o
 obj-$(CONFIG_I2C_CHARDEV)	+=3D i2c-dev.o
-obj-y				+=3D busses/ chips/ algos/
+obj-y				+=3D busses/ chips/ muxes/ algos/

 ifeq ($(CONFIG_I2C_DEBUG_CORE),y)
 EXTRA_CFLAGS +=3D -DDEBUG
diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 2965043..83119ae 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -20,7 +20,9 @@
 /* With some changes from Ky=C3=83=C2=B6sti M=C3=83=C2=A4lkki <kmalkki=
@cc.hut.fi>.
    All SMBus-related things are written by Frodo Looijaard <frodol@dds=
=2Enl>
    SMBus 2.0 support by Mark Studebaker <mdsxyz123-/E1597aS9LQAvxtiuMwx3w@public.gmane.org> and
-   Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> */
+      Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
+   Mux support by Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org> and
+      Michael Lawnick <michael.lawnick.ext-OYasijW0DpE@public.gmane.org>*/

 #include <linux/module.h>
 #include <linux/kernel.h>
@@ -937,9 +939,66 @@ static int __i2c_check_addr(struct device *dev,
void *addrp)
 	return 0;
 }

+static int i2c_check_clients(struct i2c_adapter *adapter, int addr)
+{
+	int result =3D 0;
+
+	result =3D device_for_each_child(&adapter->dev, &addr, __i2c_check_ad=
dr);
+
+	if (!result && (adapter->dev.parent->bus =3D=3D &i2c_bus_type))
+		result =3D i2c_check_clients(to_i2c_adapter(adapter->dev.parent), ad=
dr);
+=09
+	return result;
+}
+
 static int i2c_check_addr(struct i2c_adapter *adapter, int addr)
 {
-	return device_for_each_child(&adapter->dev, &addr, __i2c_check_addr);
+	int result =3D 0;
+
+	result =3D i2c_check_clients(adapter, addr);
+=09
+	if (!result && (adapter->dev.parent->bus =3D=3D &i2c_bus_type))
+	{
+		struct i2c_client dummy;
+		char buff;
+
+		dummy.adapter =3D to_i2c_adapter(adapter->dev.parent);
+		dummy.addr =3D addr;
+		dummy.flags =3D 0;
+
+		result =3D i2c_master_recv(&dummy, &buff, 1) =3D=3D 1;
+	}
+	=09
+	return result;
+}
+
+static void i2c_mux_tree_lock(struct i2c_adapter *adap)
+{
+	mutex_lock_nested(&adap->bus_lock, SINGLE_DEPTH_NESTING);
+	if(adap->dev.parent->bus =3D=3D &i2c_bus_type)
+		i2c_mux_tree_lock(to_i2c_adapter(adap->dev.parent));
+}
+
+static int i2c_mux_tree_trylock(struct i2c_adapter *adap)
+{
+	int ret;
+=09
+	ret =3D mutex_trylock(&adap->bus_lock);
+
+	if(ret && (adap->dev.parent->bus =3D=3D &i2c_bus_type)) {
+		ret =3D i2c_mux_tree_trylock(to_i2c_adapter(adap->dev.parent));
+		if (!ret)
+			mutex_unlock(&adap->bus_lock);
+	}
+
+	return ret;
+}
+
+static void i2c_mux_tree_unlock(struct i2c_adapter *adap)
+{
+	if(adap->dev.parent->bus =3D=3D &i2c_bus_type)
+		i2c_mux_tree_unlock(to_i2c_adapter(adap->dev.parent));
+	mutex_unlock(&adap->bus_lock);
 }

 /**
@@ -1092,12 +1151,12 @@ int i2c_transfer(struct i2c_adapter *adap,
struct i2c_msg *msgs, int num)
 #endif

 		if (in_atomic() || irqs_disabled()) {
-			ret =3D mutex_trylock(&adap->bus_lock);
+			ret =3D i2c_mux_tree_trylock(adap);
 			if (!ret)
 				/* I2C activity is ongoing. */
 				return -EAGAIN;
 		} else {
-			mutex_lock_nested(&adap->bus_lock, adap->level);
+			i2c_mux_tree_lock(adap);
 		}

 		/* Retry automatically on arbitration loss */
@@ -1109,7 +1168,7 @@ int i2c_transfer(struct i2c_adapter *adap, struct
i2c_msg *msgs, int num)
 			if (time_after(jiffies, orig_jiffies + adap->timeout))
 				break;
 		}
-		mutex_unlock(&adap->bus_lock);
+		i2c_mux_tree_unlock(adap);

 		return ret;
 	} else {
@@ -1913,7 +1972,7 @@ s32 i2c_smbus_xfer(struct i2c_adapter *adapter,
u16 addr, unsigned short flags,
 	flags &=3D I2C_M_TEN | I2C_CLIENT_PEC;

 	if (adapter->algo->smbus_xfer) {
-		mutex_lock(&adapter->bus_lock);
+		i2c_mux_tree_lock(adapter);

 		/* Retry automatically on arbitration loss */
 		orig_jiffies =3D jiffies;
@@ -1927,7 +1986,7 @@ s32 i2c_smbus_xfer(struct i2c_adapter *adapter,
u16 addr, unsigned short flags,
 				       orig_jiffies + adapter->timeout))
 				break;
 		}
-		mutex_unlock(&adapter->bus_lock);
+		i2c_mux_tree_unlock(adapter);
 	} else
 		res =3D i2c_smbus_xfer_emulated(adapter,addr,flags,read_write,
 					      command, protocol, data);
diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
index 7e13d2d..ce2f1a1 100644
--- a/drivers/i2c/i2c-dev.c
+++ b/drivers/i2c/i2c-dev.c
@@ -190,16 +190,44 @@ static int i2cdev_check(struct device *dev, void
*addrp)

 	if (!client || client->addr !=3D *(unsigned int *)addrp)
 		return 0;
-
+=09
 	return dev->driver ? -EBUSY : 0;
 }

+static int i2cdev_check_clients(struct i2c_adapter *adapter, int addr)
+{
+	int result =3D 0;
+
+	result =3D device_for_each_child(&adapter->dev, &addr, i2cdev_check);
+
+	if (!result && (adapter->dev.parent->bus =3D=3D &i2c_bus_type))
+		result =3D i2cdev_check_clients(to_i2c_adapter(adapter->dev.parent),=
 addr);
+=09
+	return result;
+}
+
 /* This address checking function differs from the one in i2c-core
    in that it considers an address with a registered device, but no
    driver bound to it, as NOT busy. */
 static int i2cdev_check_addr(struct i2c_adapter *adapter, unsigned int
addr)
 {
-	return device_for_each_child(&adapter->dev, &addr, i2cdev_check);
+	int result =3D 0;
+
+	result =3D i2cdev_check_clients(adapter, addr);
+=09
+	if (!result && (adapter->dev.parent->bus =3D=3D &i2c_bus_type))
+	{
+		struct i2c_client dummy;
+		char buff;
+
+		dummy.adapter =3D to_i2c_adapter(adapter->dev.parent);
+		dummy.addr =3D addr;
+		dummy.flags =3D 0;
+
+		result =3D i2c_master_recv(&dummy, &buff, 1) =3D=3D 1;
+	}
+	=09
+	return result;
 }

 static noinline int i2cdev_ioctl_rdrw(struct i2c_client *client,
diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
new file mode 100755
index 0000000..014d488
--- /dev/null
+++ b/drivers/i2c/i2c-mux.c
@@ -0,0 +1,167 @@
+/*
+ * Multiplexed I2C bus driver.
+ *
+ * Copyright (c) 2008-2009 Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>
+ * Copyright (c) 2008-2009 Eurotech S.p.A. <info-ymFC7zkAqBI1GQ1Ptb7lUw@public.gmane.org>
+ *
+ * Simplifies access to complex multiplexed I2C bus topologies, by
presenting
+ * each multiplexed bus segment as a virtual I2C adapter.  Supports
multi-level
+ * mux'ing (mux behind a mux).
+ *
+ * Based on:
+ *    i2c-virt.c from Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
+ *    i2c-virtual.c from Copyright (c) 2004 Google, Inc. (Ken Harrenst=
ien)
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
+	struct i2c_mux_priv *priv =3D adap->algo_data;
+	struct i2c_adapter *parent =3D priv->parent_adap;
+	int ret;
+
+	/* Select the right mux port and perform the transfer. */=09
+
+	ret =3D priv->select(parent, priv->client, priv->id);
+	if (ret >=3D 0)
+		ret =3D parent->algo->master_xfer(parent, msgs, num);
+	priv->deselect(parent, priv->client, priv->id);
+
+	return ret;
+}
+
+static int i2c_mux_smbus_xfer(struct i2c_adapter *adap,
+				u16 addr, unsigned short flags,
+				char read_write, u8 command,
+				int size, union i2c_smbus_data *data)
+{
+	struct i2c_mux_priv *priv =3D adap->algo_data;
+	struct i2c_adapter *parent =3D priv->parent_adap;
+	int ret;
+
+	/* Select the right mux port and perform the transfer. */=09
+
+	ret =3D priv->select(parent, priv->client, priv->id);
+	if (ret =3D=3D 0)
+		ret =3D parent->algo->smbus_xfer(parent, addr, flags,
+					   read_write, command, size, data);
+	priv->deselect(parent, priv->client, priv->id);
+
+	return ret;
+}
+
+/* Return the parent's functionality for the virtual adapter */
+static u32 i2c_mux_functionality(struct i2c_adapter *adap)
+{
+	struct i2c_mux_priv *priv =3D adap->algo_data;
+	struct i2c_adapter *parent =3D priv->parent_adap;
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
+	priv =3D kzalloc(sizeof(struct i2c_mux_priv), GFP_KERNEL);
+	if (!priv)
+		return NULL;
+
+	/* Set up private adapter data */
+	priv->parent_adap =3D parent;
+	priv->client =3D client;
+	priv->id =3D mux_val;
+	priv->select =3D select_cb;
+	priv->deselect =3D deselect_cb;
+
+	/* Need to do algo dynamically because we don't know ahead
+	 * of time what sort of physical adapter we'll be dealing with.
+	 */
+	if (parent->algo->master_xfer)
+		priv->algo.master_xfer =3D i2c_mux_master_xfer;
+	if (parent->algo->smbus_xfer)
+		priv->algo.smbus_xfer =3D i2c_mux_smbus_xfer;
+	priv->algo.functionality =3D i2c_mux_functionality;
+
+	/* Now fill out new adapter structure */
+	snprintf(priv->adap.name, sizeof(priv->adap.name),
+			"i2c-%d-mux (mux %02x)",
+			i2c_adapter_id(parent), mux_val);
+	priv->adap.owner =3D THIS_MODULE;
+	priv->adap.id =3D i2c_adapter_id(parent);
+	priv->adap.algo =3D &priv->algo;
+	priv->adap.algo_data =3D priv;
+	priv->adap.timeout =3D VIRT_TIMEOUT;
+	priv->adap.retries =3D VIRT_RETRIES;
+	priv->adap.dev.parent =3D &parent->dev;
+=09
+	if (force_nr) {
+		priv->adap.nr =3D force_nr;
+		ret =3D i2c_add_numbered_adapter(&priv->adap);
+	} else {
+		ret =3D i2c_add_adapter(&priv->adap);
+	}
+	if (ret < 0) {
+		kfree(priv);
+		return NULL;
+	}
+
+	dev_info(&parent->dev, "i2c-mux-%d: Virtual I2C bus - "
+		"physical bus i2c-%d, client %02x, port %d\n",
+		i2c_adapter_id(&priv->adap), i2c_adapter_id(parent), ((struct
i2c_client*)priv->client)->addr, mux_val);
+
+	return &priv->adap;
+}
+EXPORT_SYMBOL_GPL(i2c_add_mux_adapter);
+
+int i2c_del_mux_adapter(struct i2c_adapter *adap)
+{
+	struct i2c_mux_priv *priv =3D adap->algo_data;
+	int ret;
+
+	ret =3D i2c_del_adapter(adap);
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
new file mode 100755
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
new file mode 100755
index 0000000..0416a52
--- /dev/null
+++ b/drivers/i2c/muxes/Makefile
@@ -0,0 +1,6 @@
+#
+# Makefile for multiplexer I2C chip drivers.
+
+ifeq ($(CONFIG_I2C_DEBUG_CHIP),y)
+EXTRA_CFLAGS +=3D -DDEBUG -DI2C_DEBUG_CORE
+endif
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 7b40cda..24ff2e5 100755
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -580,6 +580,20 @@ union i2c_smbus_data {
 #define I2C_SMBUS_BLOCK_PROC_CALL   7		/* SMBus 2.0 */
 #define I2C_SMBUS_I2C_BLOCK_DATA    8

+/*
+ * Called to create a 'virtual' i2c bus which represents a multiplexed=
 bus
+ * segment.  The client and mux_val are passed to the select and desel=
ect
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

--=20
1.6.1.2
