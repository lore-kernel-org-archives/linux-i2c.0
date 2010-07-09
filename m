From: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Subject: [Patch v3] i2c: Multiplexed I2C bus core support
Date: Fri, 09 Jul 2010 11:07:46 +0200
Message-ID: <4C36E6E2.1070307@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Add multiplexed bus core support. I2C multiplexer and switches
like pca954x get instantiated as new adapters per port.

Signed-off-by: Michael Lawnick <demx1175@wbit01lx.(none)>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
Based on kernel 2.6.35.rc2 +
[PATCH] i2c: Move adapter locking helpers to i2c-core
by Jean Delware <20100615140218.07090c90-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
<http://article.gmane.org/gmane.linux.drivers.i2c/6226/match=3Di2c+move=
+adapter+locking+helpers+i2c+core>

 drivers/i2c/Kconfig         |   11 +++
 drivers/i2c/Makefile        |    1 +
 drivers/i2c/i2c-core.c      |   80 +++++++++++++++++----
 drivers/i2c/i2c-dev.c       |   44 +++++++++++-
 drivers/i2c/i2c-mux.c       |  165
+++++++++++++++++++++++++++++++++++++++++++
 include/linux/i2c-mux.h     |   46 ++++++++++++
 include/linux/i2c.h         |    8 ++
 7 files changed, 341 insertions(+), 14 deletions(-)
 create mode 100755 drivers/i2c/i2c-mux.c
 create mode 100755 include/linux/i2c-mux.h

diff --git a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig
index d06083f..efb48ad
--- a/drivers/i2c/Kconfig
+++ b/drivers/i2c/Kconfig
@@ -47,6 +47,17 @@ config I2C_CHARDEV
 	  This support is also available as a module.  If so, the module
 	  will be called i2c-dev.

+config I2C_MUX
+	tristate "I2C bus multiplexing support"
+	depends on EXPERIMENTAL
+	help
+	  Say Y here if you want the I2C core to support the ability to
+	  handle multiplexed I2C bus topologies, by presenting each
+	  multiplexed segment as a I2C adapter.
+
+	  This support is also available as a module.  If so, the module
+	  will be called i2c-mux.
+
 config I2C_HELPER_AUTO
 	bool "Autoselect pertinent helper modules"
 	default y
diff --git a/drivers/i2c/Makefile b/drivers/i2c/Makefile
index a7d9b4b..f363258
--- a/drivers/i2c/Makefile
+++ b/drivers/i2c/Makefile
@@ -6,6 +6,7 @@ obj-$(CONFIG_I2C_BOARDINFO)	+=3D i2c-boardinfo.o
 obj-$(CONFIG_I2C)		+=3D i2c-core.o
 obj-$(CONFIG_I2C_SMBUS)		+=3D i2c-smbus.o
 obj-$(CONFIG_I2C_CHARDEV)	+=3D i2c-dev.o
+obj-$(CONFIG_I2C_MUX)		+=3D i2c-mux.o
 obj-y				+=3D algos/ busses/

 ifeq ($(CONFIG_I2C_DEBUG_CORE),y)
diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 05a147a..d46fb3e
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -20,7 +20,9 @@
 /* With some changes from Ky=C3=83=C2=B6sti M=C3=83=C2=A4lkki <kmalkki=
@cc.hut.fi>.
    All SMBus-related things are written by Frodo Looijaard <frodol@dds=
=2Enl>
    SMBus 2.0 support by Mark Studebaker <mdsxyz123-/E1597aS9LQAvxtiuMwx3w@public.gmane.org> and
-   Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> */
+   Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
+   Mux support by Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org> and
+   Michael Lawnick <michael.lawnick.ext-OYasijW0DpE@public.gmane.org> */

 #include <linux/module.h>
 #include <linux/kernel.h>
@@ -417,10 +419,52 @@ static int __i2c_check_addr_busy(struct device
*dev, void *addrp)
 	return 0;
 }

+/* walk up mux tree */
+static int i2c_check_mux_parents(struct i2c_adapter *adapter, int addr=
)
+{
+	int	result;
+
+	result =3D device_for_each_child(&adapter->dev, &addr,
+					__i2c_check_addr_busy);
+
+	if (!result && i2c_parent_is_i2c_adapter(adapter))
+		result =3D i2c_check_mux_parents(
+				    to_i2c_adapter(adapter->dev.parent), addr);
+
+	return result;
+}
+
+/* recurse down mux tree */
+static int i2c_check_mux_children(struct device *dev, void *addrp)
+{
+	int result;
+
+	if (dev->type =3D=3D &i2c_adapter_type)
+		result =3D device_for_each_child(dev, addrp,
+						i2c_check_mux_children);
+	else
+		result =3D __i2c_check_addr_busy(dev, addrp);
+
+	return result;
+}
+
 static int i2c_check_addr_busy(struct i2c_adapter *adapter, int addr)
 {
-	return device_for_each_child(&adapter->dev, &addr,
-				     __i2c_check_addr_busy);
+	int	result =3D 0;
+
+	i2c_lock_adapter(adapter);
+
+	if (i2c_parent_is_i2c_adapter(adapter))
+		result =3D i2c_check_mux_parents(
+				    to_i2c_adapter(adapter->dev.parent), addr);
+
+	if (!result)
+		result =3D device_for_each_child(&adapter->dev, &addr,
+						i2c_check_mux_children);
+
+	i2c_unlock_adapter(adapter);
+
+	return result;
 }

 /**
@@ -429,7 +473,10 @@ static int i2c_check_addr_busy(struct i2c_adapter
*adapter, int addr)
  */
 void i2c_lock_adapter(struct i2c_adapter *adapter)
 {
-	rt_mutex_lock(&adapter->bus_lock);
+	if (i2c_parent_is_i2c_adapter(adapter))
+		i2c_lock_adapter(to_i2c_adapter(adapter->dev.parent));
+	else
+		rt_mutex_lock(&adapter->bus_lock);
 }
 EXPORT_SYMBOL_GPL(i2c_lock_adapter);

@@ -439,7 +486,10 @@ EXPORT_SYMBOL_GPL(i2c_lock_adapter);
  */
 static int i2c_trylock_adapter(struct i2c_adapter *adapter)
 {
-	return rt_mutex_trylock(&adapter->bus_lock);
+	if (i2c_parent_is_i2c_adapter(adapter))
+		return i2c_trylock_adapter(to_i2c_adapter(adapter->dev.parent));
+	else
+		return rt_mutex_trylock(&adapter->bus_lock);
 }

 /**
@@ -448,7 +498,10 @@ static int i2c_trylock_adapter(struct i2c_adapter
*adapter)
  */
 void i2c_unlock_adapter(struct i2c_adapter *adapter)
 {
-	rt_mutex_unlock(&adapter->bus_lock);
+	if (i2c_parent_is_i2c_adapter(adapter))
+		i2c_unlock_adapter(to_i2c_adapter(adapter->dev.parent));
+	else
+		rt_mutex_unlock(&adapter->bus_lock);
 }
 EXPORT_SYMBOL_GPL(i2c_unlock_adapter);

@@ -656,9 +709,9 @@ i2c_sysfs_new_device(struct device *dev, struct
device_attribute *attr,
 		return -EINVAL;

 	/* Keep track of the added device */
-	i2c_lock_adapter(adap);
+	rt_mutex_lock(&adap->bus_lock);
 	list_add_tail(&client->detected, &adap->userspace_clients);
-	i2c_unlock_adapter(adap);
+	rt_mutex_unlock(&adap->bus_lock);
 	dev_info(dev, "%s: Instantiated device %s at 0x%02hx\n", "new_device"=
,
 		 info.type, info.addr);

@@ -697,7 +750,7 @@ i2c_sysfs_delete_device(struct device *dev, struct
device_attribute *attr,

 	/* Make sure the device was added through sysfs */
 	res =3D -ENOENT;
-	i2c_lock_adapter(adap);
+	rt_mutex_lock(&adap->bus_lock);
 	list_for_each_entry_safe(client, next, &adap->userspace_clients,
 				 detected) {
 		if (client->addr =3D=3D addr) {
@@ -710,7 +763,7 @@ i2c_sysfs_delete_device(struct device *dev, struct
device_attribute *attr,
 			break;
 		}
 	}
-	i2c_unlock_adapter(adap);
+	rt_mutex_unlock(&adap->bus_lock);

 	if (res < 0)
 		dev_err(dev, "%s: Can't find device in list\n",
@@ -737,10 +790,11 @@ static const struct attribute_group
*i2c_adapter_attr_groups[] =3D {
 	NULL
 };

-static struct device_type i2c_adapter_type =3D {
+struct device_type i2c_adapter_type =3D {
 	.groups		=3D i2c_adapter_attr_groups,
 	.release	=3D i2c_adapter_dev_release,
 };
+EXPORT_SYMBOL_GPL(i2c_adapter_type);

 #ifdef CONFIG_I2C_COMPAT
 static struct class_compat *i2c_adapter_compat_class;
@@ -995,7 +1049,7 @@ int i2c_del_adapter(struct i2c_adapter *adap)
 		return res;

 	/* Remove devices instantiated from sysfs */
-	i2c_lock_adapter(adap);
+	rt_mutex_lock(&adap->bus_lock);
 	list_for_each_entry_safe(client, next, &adap->userspace_clients,
 				 detected) {
 		dev_dbg(&adap->dev, "Removing %s at 0x%x\n", client->name,
@@ -1003,7 +1057,7 @@ int i2c_del_adapter(struct i2c_adapter *adap)
 		list_del(&client->detected);
 		i2c_unregister_device(client);
 	}
-	i2c_unlock_adapter(adap);
+	rt_mutex_unlock(&adap->bus_lock);

 	/* Detach any active clients. This can't fail, thus we do not
 	   checking the returned value. */
diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
index e0694e4..6717bba
--- a/drivers/i2c/i2c-dev.c
+++ b/drivers/i2c/i2c-dev.c
@@ -193,12 +193,54 @@ static int i2cdev_check(struct device *dev, void
*addrp)
 	return dev->driver ? -EBUSY : 0;
 }

+/* walk up mux tree */
+static int i2cdev_check_mux_parents(struct i2c_adapter *adapter, int a=
ddr)
+{
+	int	result;
+
+	result =3D device_for_each_child(&adapter->dev, &addr, i2cdev_check);
+
+	if (!result && i2c_parent_is_i2c_adapter(adapter))
+		result =3D i2cdev_check_mux_parents(
+				    to_i2c_adapter(adapter->dev.parent), addr);
+
+	return result;
+}
+
+/* recurse down mux tree */
+static int i2cdev_check_mux_children(struct device *dev, void *addrp)
+{
+	int result;
+
+	if (dev->type =3D=3D &i2c_adapter_type)
+		result =3D device_for_each_child(dev, addrp,
+						i2cdev_check_mux_children);
+	else
+		result =3D i2cdev_check(dev, addrp);
+
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
+	int	result =3D 0;
+
+	i2c_lock_adapter(adapter);
+
+	if (i2c_parent_is_i2c_adapter(adapter))
+		result =3D i2cdev_check_mux_parents(
+				    to_i2c_adapter(adapter->dev.parent), addr);
+
+	if (!result)
+		result =3D device_for_each_child(&adapter->dev, &addr,
+						i2cdev_check_mux_children);
+
+	i2c_unlock_adapter(adapter);
+
+	return result;
 }

 static noinline int i2cdev_ioctl_rdrw(struct i2c_client *client,
diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
new file mode 100755
index 0000000..d32a484
--- /dev/null
+++ b/drivers/i2c/i2c-mux.c
@@ -0,0 +1,165 @@
+/*
+ * Multiplexed I2C bus driver.
+ *
+ * Copyright (c) 2008-2009 Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>
+ * Copyright (c) 2008-2009 Eurotech S.p.A. <info-ymFC7zkAqBI1GQ1Ptb7lUw@public.gmane.org>
+ * Copyright (c) 2009-2010 NSN GmbH & Co KG <michael.lawnick.ext@nsn.c=
om>
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
+	int (*select)(struct i2c_adapter *, void *mux_dev, u32 chan_id);
+	int (*deselect)(struct i2c_adapter *, void *mux_dev, u32 chan_id);
+};
+
+static int i2c_mux_master_xfer(struct i2c_adapter *adap,
+			       struct i2c_msg msgs[], int num)
+{
+	struct i2c_mux_priv *priv =3D adap->algo_data;
+	struct i2c_adapter *parent =3D priv->parent;
+	int ret;
+
+	/* Switch to the right mux port and perform the transfer. */
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
+	/* Select the right mux port and perform the transfer. */
+
+	ret =3D priv->select(parent, priv->mux_dev, priv->chan_id);
+	if (ret >=3D 0)
+		ret =3D parent->algo->smbus_xfer(parent, addr, flags,
+					read_write, command, size, data);
+	if (priv->deselect)
+		priv->deselect(parent, priv->mux_dev, priv->chan_id);
+
+	return ret;
+}
+
+/* Return the parent's functionality */
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
+		dev_err(&parent->dev,
+			"failed to add mux-adapter (error=3D%d)\n",
+			ret);
+		kfree(priv);
+		return NULL;
+	}
+
+	dev_info(&parent->dev, "Added multiplexed i2c bus %d\n",
+		 i2c_adapter_id(&priv->adap));
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
+MODULE_DESCRIPTION("I2C driver for multiplexed I2C busses");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/i2c-mux.h b/include/linux/i2c-mux.h
new file mode 100755
index 0000000..4c52ee1
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
+				void *mux_dev, u32 chan_id),
+				int (*deselect) (struct i2c_adapter *,
+				void *mux_dev, u32 chan_id));
+
+int i2c_del_mux_adapter(struct i2c_adapter *adap);
+
+#endif /* __KERNEL__ */
+
+#endif /* _LINUX_I2C_MUX_H */
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index f2d36bd..8f2b83a
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -37,6 +37,7 @@
 #include <linux/of.h>		/* for struct device_node */

 extern struct bus_type i2c_bus_type;
+extern struct device_type i2c_adapter_type;

 /* --- General options -----------------------------------------------=
-	*/

@@ -374,6 +375,13 @@ static inline void i2c_set_adapdata(struct
i2c_adapter *dev, void *data)
 	dev_set_drvdata(&dev->dev, data);
 }

+static inline int i2c_parent_is_i2c_adapter(const struct i2c_adapter
*adapter)
+{
+	return adapter->dev.parent !=3D NULL
+		&& adapter->dev.parent->bus =3D=3D &i2c_bus_type
+		&& adapter->dev.parent->type =3D=3D &i2c_adapter_type;
+}
+
 /* Adapter locking functions, exported for shared pin cases */
 void i2c_lock_adapter(struct i2c_adapter *);
 void i2c_unlock_adapter(struct i2c_adapter *);
--=20
Michael Lawnick
