From: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Subject: [PATCH v2 1/2] i2c: Multiplexed I2C bus core support
Date: Tue, 04 May 2010 14:29:21 +0200
Message-ID: <4BE01321.3060704@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: "Delvare, Jean " <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Add multiplexed bus core support. I2C multiplexer and switches
like pca954x instantiate new adapters per output.

Signed-off-by: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
---
Based on kernel 2.6.33 +
[PATCH] i2c-core: Use per-adapter userspace device lists
by Jean Delware <20100424201914.08b3f008-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
<http://article.gmane.org/gmane.linux.drivers.i2c/5994/>

=46rom 1d17617d8845f2268d4123ec0cf5310743303d45 Mon Sep 17 00:00:00 200=
1
=46rom: Michael Lawnick <demx1175@demmc3qc.(none)>
Date: Tue, 4 May 2010 13:34:52 +0200
Subject: [PATCH] mux_core_support

---
 drivers/i2c/Kconfig     |    8 ++
 drivers/i2c/Makefile    |    1 +
 drivers/i2c/i2c-core.c  |   93 ++++++++++++++++++++++--
 drivers/i2c/i2c-dev.c   |   46 ++++++++++++-
 drivers/i2c/i2c-mux.c   |  184
+++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/i2c-mux.h |   46 ++++++++++++
 include/linux/i2c.h     |   11 +++
 7 files changed, 381 insertions(+), 8 deletions(-)
 create mode 100755 drivers/i2c/i2c-mux.c
 create mode 100755 include/linux/i2c-mux.h

diff --git a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig
index 8d8a00e..2cd6d78 100755
--- a/drivers/i2c/Kconfig
+++ b/drivers/i2c/Kconfig
@@ -36,6 +36,14 @@ config I2C_COMPAT
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
 config I2C_CHARDEV
 	tristate "I2C device interface"
 	help
diff --git a/drivers/i2c/Makefile b/drivers/i2c/Makefile
index ba26e6c..a488e8b 100755
--- a/drivers/i2c/Makefile
+++ b/drivers/i2c/Makefile
@@ -5,6 +5,7 @@
 obj-$(CONFIG_I2C_BOARDINFO)	+=3D i2c-boardinfo.o
 obj-$(CONFIG_I2C)		+=3D i2c-core.o
 obj-$(CONFIG_I2C_CHARDEV)	+=3D i2c-dev.o
+obj-$(CONFIG_I2C_MUX)		+=3D i2c-mux.o
 obj-y				+=3D busses/ chips/ algos/

 ifeq ($(CONFIG_I2C_DEBUG_CORE),y)
diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index fc93e28..682966a 100755
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -20,7 +20,10 @@
 /* With some changes from Ky=C3=83=C2=B6sti M=C3=83=C2=A4lkki <kmalkki=
@cc.hut.fi>.
    All SMBus-related things are written by Frodo Looijaard <frodol@dds=
=2Enl>
    SMBus 2.0 support by Mark Studebaker <mdsxyz123-/E1597aS9LQAvxtiuMwx3w@public.gmane.org> and
-   Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> */
+   Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
+   Mux support by Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org> and
+   Michael Lawnick <michael.lawnick.ext-OYasijW0DpE@public.gmane.org> */
+

 #include <linux/module.h>
 #include <linux/kernel.h>
@@ -288,6 +291,12 @@ struct i2c_client *i2c_verify_client(struct device
*dev)
 }
 EXPORT_SYMBOL(i2c_verify_client);

+static int i2c_parent_is_i2c_adapter(const struct i2c_adapter *adapter=
)
+{
+	return adapter->dev.parent !=3D NULL
+		&& adapter->dev.parent->bus =3D=3D &i2c_bus_type;
+}
+

 /**
  * i2c_new_device - instantiate an i2c device
@@ -624,6 +633,7 @@ static int i2c_register_adapter(struct i2c_adapter
*adap)

 	rt_mutex_init(&adap->bus_lock);
 	INIT_LIST_HEAD(&adap->userspace_clients);
+	INIT_LIST_HEAD(&adap->mux_list_head);

 	/* Set default timeout to 1 second if not already set */
 	if (adap->timeout =3D=3D 0)
@@ -949,9 +959,78 @@ static int __i2c_check_addr(struct device *dev,
void *addrp)
 	return 0;
 }

+/* walk up mux tree */
+static int i2c_check_mux_parents(struct i2c_adapter *adapter, int addr=
)
+{
+	int	result;
+
+	result =3D device_for_each_child(&adapter->dev, &addr, __i2c_check_ad=
dr);
+
+	if (!result && i2c_parent_is_i2c_adapter(adapter))
+		result =3D i2c_check_mux_parents(
+				    to_i2c_adapter(adapter->dev.parent), addr);
+
+	return result;
+}
+
+/* recurse down mux tree */
+static int i2c_check_mux_childs(struct i2c_adapter *adapter, int addr)
+{
+	int			result =3D 0;
+	struct i2c_adapter	*child, *next;
+
+	list_for_each_entry_safe(child, next, &adapter->mux_list_head,
+							 mux_list) {
+		result =3D device_for_each_child(&child->dev, &addr,
+							     __i2c_check_addr);
+		if (result)
+			break;
+		result =3D i2c_check_mux_childs(child, addr);
+	}
+	return result;
+}
+
 static int i2c_check_addr(struct i2c_adapter *adapter, int addr)
 {
-	return device_for_each_child(&adapter->dev, &addr, __i2c_check_addr);
+	int	result;
+
+	result =3D i2c_check_mux_parents(adapter, addr);
+
+	if (!result)
+		result =3D i2c_check_mux_childs(adapter, addr);
+
+	return result;
+}
+
+static void i2c_mux_tree_lock(struct i2c_adapter *adap)
+{
+	if (i2c_parent_is_i2c_adapter(adap))
+		i2c_mux_tree_lock(to_i2c_adapter(adap->dev.parent));
+	else
+		i2c_lock_adapter(adap);
+}
+
+static int i2c_mux_tree_trylock(struct i2c_adapter *adap)
+{
+	int			ret;
+	struct i2c_adapter	*parent;
+
+	if (i2c_parent_is_i2c_adapter(adap)) {
+		parent =3D to_i2c_adapter(adap->dev.parent);
+		ret =3D i2c_mux_tree_trylock(parent);
+	} else {
+		ret =3D i2c_trylock_adapter(adap);
+	}
+
+	return ret;
+}
+
+static void i2c_mux_tree_unlock(struct i2c_adapter *adap)
+{
+	if (i2c_parent_is_i2c_adapter(adap))
+		i2c_mux_tree_unlock(to_i2c_adapter(adap->dev.parent));
+	else
+		i2c_unlock_adapter(adap);
 }

 /**
@@ -1104,12 +1183,12 @@ int i2c_transfer(struct i2c_adapter *adap,
struct i2c_msg *msgs, int num)
 #endif

 		if (in_atomic() || irqs_disabled()) {
-			ret =3D rt_mutex_trylock(&adap->bus_lock);
+			ret =3D i2c_mux_tree_trylock(adap);
 			if (!ret)
 				/* I2C activity is ongoing. */
 				return -EAGAIN;
 		} else {
-			rt_mutex_lock(&adap->bus_lock);
+			i2c_mux_tree_lock(adap);
 		}

 		/* Retry automatically on arbitration loss */
@@ -1121,7 +1200,7 @@ int i2c_transfer(struct i2c_adapter *adap, struct
i2c_msg *msgs, int num)
 			if (time_after(jiffies, orig_jiffies + adap->timeout))
 				break;
 		}
-		rt_mutex_unlock(&adap->bus_lock);
+		i2c_mux_tree_unlock(adap);

 		return ret;
 	} else {
@@ -1857,7 +1936,7 @@ s32 i2c_smbus_xfer(struct i2c_adapter *adapter,
u16 addr, unsigned short flags,
 	flags &=3D I2C_M_TEN | I2C_CLIENT_PEC;

 	if (adapter->algo->smbus_xfer) {
-		rt_mutex_lock(&adapter->bus_lock);
+		i2c_mux_tree_lock(adapter);

 		/* Retry automatically on arbitration loss */
 		orig_jiffies =3D jiffies;
@@ -1871,7 +1950,7 @@ s32 i2c_smbus_xfer(struct i2c_adapter *adapter,
u16 addr, unsigned short flags,
 				       orig_jiffies + adapter->timeout))
 				break;
 		}
-		rt_mutex_unlock(&adapter->bus_lock);
+		i2c_mux_tree_unlock(adapter);
 	} else
 		res =3D i2c_smbus_xfer_emulated(adapter,addr,flags,read_write,
 					      command, protocol, data);
diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
index f4110aa..da5327f 100755
--- a/drivers/i2c/i2c-dev.c
+++ b/drivers/i2c/i2c-dev.c
@@ -193,12 +193,56 @@ static int i2cdev_check(struct device *dev, void
*addrp)
 	return dev->driver ? -EBUSY : 0;
 }

+static int i2cdev_parent_is_i2c_adapter(const struct i2c_adapter *adap=
ter)
+{
+	return adapter->dev.parent !=3D NULL
+		&& adapter->dev.parent->bus =3D=3D &i2c_bus_type;
+}
+
+/* walk up mux tree */
+static int i2cdev_check_mux_parents(struct i2c_adapter *adapter, int a=
ddr)
+{
+	int result;
+
+	result =3D device_for_each_child(&adapter->dev, &addr, i2cdev_check);
+
+	if (!result && i2cdev_parent_is_i2c_adapter(adapter))
+		result =3D i2cdev_check_mux_parents(
+				    to_i2c_adapter(adapter->dev.parent), addr);
+
+	return result;
+}
+
+/* recurse down mux tree */
+static int i2cdev_check_mux_childs(struct i2c_adapter *adapter, int ad=
dr)
+{
+	int result =3D 0;
+	struct i2c_adapter *child, *next;
+
+	list_for_each_entry_safe(child, next, &adapter->mux_list_head,
+				 mux_list) {
+		result =3D device_for_each_child(&child->dev, &addr,
+					       i2cdev_check);
+		if (result)
+			break;
+		result =3D i2cdev_check_mux_childs(child, addr);
+	}
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
+	int result;
+
+	result =3D i2cdev_check_mux_parents(adapter, addr);
+
+	if (!result)
+		result =3D i2cdev_check_mux_childs(adapter, addr);
+
+	return result;
 }

 static noinline int i2cdev_ioctl_rdrw(struct i2c_client *client,
diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
new file mode 100755
index 0000000..f88d29a
--- /dev/null
+++ b/drivers/i2c/i2c-mux.c
@@ -0,0 +1,184 @@
+/*
+ * Multiplexed I2C bus driver.
+ *
+ * Copyright (c) 2008-2009 Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>
+ * Copyright (c) 2008-2009 Eurotech S.p.A. <info-ymFC7zkAqBI1GQ1Ptb7lUw@public.gmane.org>
+ *
+ * Simplifies access to complex multiplexed I2C bus topologies, by
presenting
+ * each multiplexed bus segment as an additional I2C adapter.
+ * Supports multi-level mux'ing (mux behind a mux).
+ *
+ * Based on:
+ *	i2c-virt.c from Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
+ *	i2c-virtual.c from Ken Harrenstien, Copyright (c) 2004 Google, Inc.
+ *	i2c-virtual.c from Brian Kuschak <bkuschak-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+/* Adapted to kernel 2.6.33 by Michael Lawnick
<michael.lawnick.ext-OYasijW0DpE@public.gmane.org> */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/i2c.h>
+#include <linux/i2c-mux.h>
+
+/* multiplexer per channel data */
+struct i2c_mux_priv {
+	struct i2c_adapter adap;
+	struct i2c_algorithm algo;
+
+	struct i2c_adapter *parent;
+	void *mux_dev;	/* the mux chip/device */
+	u32  chan_id;	/* the channel id */
+
+	int (*select)(struct i2c_adapter *adap, void *mux_dev, u32 chan_id);
+	int (*deselect)(struct i2c_adapter *adap, void *mux_dev, u32 chan_id)=
;
+};
+
+#define VIRT_TIMEOUT		(HZ/2)
+#define VIRT_RETRIES		3
+
+static int i2c_mux_master_xfer(struct i2c_adapter *adap,
+			       struct i2c_msg msgs[], int num)
+{
+	struct i2c_mux_priv *priv =3D adap->algo_data;
+	struct i2c_adapter *parent =3D priv->parent;
+	int ret;
+
+	/* Switch to the right mux port and perform the transfer.*/
+
+	ret =3D priv->select(parent, priv->mux_dev, priv->chan_id);
+	if (ret >=3D 0)
+		ret =3D parent->algo->master_xfer(parent, msgs, num);
+	if (priv->deselect)
+		priv->deselect(parent, priv->mux_dev, priv->chan_id);
+
+	return ret;
+}
+
+static int i2c_mux_smbus_xfer(struct i2c_adapter *adap,
+			      u16 addr, unsigned short flags,
+			      char read_write, u8 command,
+			      int size, union i2c_smbus_data *data)
+{
+	struct i2c_mux_priv *priv =3D adap->algo_data;
+	struct i2c_adapter *parent =3D priv->parent;
+	int ret;
+
+	/* Select the right mux port and perform the transfer.*/
+
+	ret =3D priv->select(parent, priv->mux_dev, priv->chan_id);
+	if (ret >=3D 0)
+		ret =3D parent->algo->smbus_xfer(parent, addr, flags,
+					   read_write, command, size, data);
+	if (priv->deselect)
+		priv->deselect(parent, priv->mux_dev, priv->chan_id);
+
+	return ret;
+}
+
+/* Return the parent's functionality for the virtual adapter */
+static u32 i2c_mux_functionality(struct i2c_adapter *adap)
+{
+	struct i2c_mux_priv *priv =3D adap->algo_data;
+	struct i2c_adapter *parent =3D priv->parent;
+
+	return parent->algo->functionality(parent);
+}
+
+struct i2c_adapter *i2c_add_mux_adapter(struct i2c_adapter *parent,
+				void *mux_dev, u32 force_nr, u32 chan_id,
+				int (*select) (struct i2c_adapter *,
+					       void *, u32),
+				int (*deselect) (struct i2c_adapter *,
+						 void *, u32))
+{
+	struct i2c_mux_priv *priv;
+	int ret;
+
+	priv =3D kzalloc(sizeof(struct i2c_mux_priv), GFP_KERNEL);
+	if (!priv)
+		return NULL;
+
+	/* Set up private adapter data */
+	priv->parent =3D parent;
+	priv->mux_dev =3D mux_dev;
+	priv->chan_id =3D chan_id;
+	priv->select =3D select;
+	priv->deselect =3D deselect;
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
+		 "i2c-%d-mux (chan_id %d)", i2c_adapter_id(parent), chan_id);
+	priv->adap.owner =3D THIS_MODULE;
+	priv->adap.id =3D parent->id;
+	priv->adap.algo =3D &priv->algo;
+	priv->adap.algo_data =3D priv;
+	priv->adap.dev.parent =3D &parent->dev;
+
+	if (force_nr) {
+		priv->adap.nr =3D force_nr;
+		ret =3D i2c_add_numbered_adapter(&priv->adap);
+	} else {
+		ret =3D i2c_add_adapter(&priv->adap);
+	}
+	if (ret < 0) {
+		dev_err(&parent->dev, "failed to add mux-adapter (error=3D%d)\n",
+			ret);
+		kfree(priv);
+		return NULL;
+	}
+
+	list_add_tail(&priv->adap.mux_list, &parent->mux_list_head);
+
+	dev_info(&parent->dev, "i2c-mux-%d: Multiplexed I2C bus on "
+		"parent bus i2c-%d, chan_id %d\n",
+		i2c_adapter_id(&priv->adap), i2c_adapter_id(parent), chan_id);
+
+	return &priv->adap;
+}
+EXPORT_SYMBOL_GPL(i2c_add_mux_adapter);
+
+int i2c_del_mux_adapter(struct i2c_adapter *adap)
+{
+	struct i2c_mux_priv *priv =3D adap->algo_data;
+	int ret;
+	struct i2c_adapter *child, *next, *parent;
+
+	if (adap->dev.parent !=3D NULL
+		&& adap->dev.parent->bus =3D=3D &i2c_bus_type) {
+		parent =3D to_i2c_adapter(adap->dev.parent);
+		list_for_each_entry_safe(child, next, &parent->mux_list_head,
+					 mux_list) {
+			if (child =3D=3D adap) {
+				list_del(&child->mux_list);
+				break;
+			}
+		}
+	}
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
+MODULE_DESCRIPTION("I2C driver for multiplexed I2C busses");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/i2c-mux.h b/include/linux/i2c-mux.h
new file mode 100755
index 0000000..0d5d6c8
--- /dev/null
+++ b/include/linux/i2c-mux.h
@@ -0,0 +1,46 @@
+/*
+ *
+ * i2c-mux.h - functions for the i2c-bus mux support
+ *
+ * Copyright (c) 2008-2009 Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>
+ * Copyright (c) 2008-2009 Eurotech S.p.A. <info-ymFC7zkAqBI1GQ1Ptb7lUw@public.gmane.org>
+ * Michael Lawnick <michael.lawnick.ext-OYasijW0DpE@public.gmane.org>
+ *
+ * This program is free software; you can redistribute it and/or modif=
y
+ * it under the terms of the GNU General Public License as published b=
y
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
+#ifndef _LINUX_I2C_MUX_H
+#define _LINUX_I2C_MUX_H
+
+#ifdef __KERNEL__
+
+/*
+ * Called to create a i2c bus on a multiplexed bus segment.
+ * The mux_dev and chan_id parameters are passed to the select
+ * and deselect callback functions to perform hardware-specific
+ * mux control.
+ */
+struct i2c_adapter *i2c_add_mux_adapter(struct i2c_adapter *parent,
+				void *mux_dev, u32 force_nr, u32 chan_id,
+				int (*select) (struct i2c_adapter *adap,
+					       void *mux_dev, u32 chan_id),
+				int (*deselect) (struct i2c_adapter *,
+						 void *mux_dev, u32 chan_id));
+
+int i2c_del_mux_adapter(struct i2c_adapter *adap);
+
+#endif /* __KERNEL__ */
+
+#endif /* _LINUX_I2C_H */
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 1fd7b12..898a8c1 100755
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -349,6 +349,8 @@ struct i2c_adapter {
 	struct completion dev_released;

 	struct list_head userspace_clients;
+	struct list_head mux_list_head;
+	struct list_head mux_list;
 };
 #define to_i2c_adapter(d) container_of(d, struct i2c_adapter, dev)

@@ -380,6 +382,15 @@ static inline void i2c_unlock_adapter(struct
i2c_adapter *adapter)
 	rt_mutex_unlock(&adapter->bus_lock);
 }

+/**
+ * i2c_trylock_adapter - Try to prevent access to an I2C bus segment
+ * @adapter: Target I2C bus segment
+ */
+static inline int i2c_trylock_adapter(struct i2c_adapter *adapter)
+{
+	return rt_mutex_trylock(&adapter->bus_lock);
+}
+
 /*flags for the client struct: */
 #define I2C_CLIENT_PEC	0x04		/* Use Packet Error Checking */
 #define I2C_CLIENT_TEN	0x10		/* we have a ten bit chip address */
