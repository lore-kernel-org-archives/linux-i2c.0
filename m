From: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Subject: [PATCH v2 2/2] i2c: Multiplexed I2C bus multiplexer driver pca954x
Date: Tue, 04 May 2010 14:48:21 +0200
Message-ID: <4BE01795.1090605@gmx.de>
References: <4BE01741.1010909@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010107030706080403030507"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4BE01741.1010909-Mmb7MZpHnFY@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: "Delvare, Jean " <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

This is a multi-part message in MIME format.
--------------010107030706080403030507
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit


--------------010107030706080403030507
Content-Type: text/plain;
 name="0002-pca954x-mux.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0002-pca954x-mux.patch"

Add multiplexed bus core support. I2C driver for PCA954x
I2C multiplexer series.

Signed-off-by: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>

---
Based on kernel 2.6.33 +
[PATCH] i2c-core: Use per-adapter userspace device lists
by Jean Delware <20100424201914.08b3f008-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
<http://article.gmane.org/gmane.linux.drivers.i2c/5994/>

 drivers/i2c/Kconfig         |    2 +
 drivers/i2c/Makefile        |    2 +-
 drivers/i2c/muxes/Kconfig   |   17 +++
 drivers/i2c/muxes/Makefile  |    8 +
 drivers/i2c/muxes/pca954x.c |  302 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/i2c/pca954x.h |   47 +++++++
 6 files changed, 377 insertions(+), 1 deletions(-)
 create mode 100755 drivers/i2c/muxes/Kconfig
 create mode 100755 drivers/i2c/muxes/Makefile
 create mode 100755 drivers/i2c/muxes/pca954x.c
 create mode 100755 include/linux/i2c/pca954x.h

diff --git a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig
index 2cd6d78..21b0ac0 100755
--- a/drivers/i2c/Kconfig
+++ b/drivers/i2c/Kconfig
@@ -44,6 +44,8 @@ config I2C_MUX
 	  handle multiplexed I2C bus topologies, by presenting each
 	  multiplexed segment as a I2C adapter.
 
+source drivers/i2c/muxes/Kconfig
+
 config I2C_CHARDEV
 	tristate "I2C device interface"
 	help
diff --git a/drivers/i2c/Makefile b/drivers/i2c/Makefile
index a488e8b..1769a16 100755
--- a/drivers/i2c/Makefile
+++ b/drivers/i2c/Makefile
@@ -6,7 +6,7 @@ obj-$(CONFIG_I2C_BOARDINFO)	+= i2c-boardinfo.o
 obj-$(CONFIG_I2C)		+= i2c-core.o
 obj-$(CONFIG_I2C_CHARDEV)	+= i2c-dev.o
 obj-$(CONFIG_I2C_MUX)		+= i2c-mux.o
-obj-y				+= busses/ chips/ algos/
+obj-y				+= busses/ chips/ muxes/ algos/
 
 ifeq ($(CONFIG_I2C_DEBUG_CORE),y)
 EXTRA_CFLAGS += -DDEBUG
diff --git a/drivers/i2c/muxes/Kconfig b/drivers/i2c/muxes/Kconfig
new file mode 100755
index 0000000..ec22db0
--- /dev/null
+++ b/drivers/i2c/muxes/Kconfig
@@ -0,0 +1,17 @@
+#
+# Multiplexer I2C chip drivers configuration
+#
+
+menu "Multiplexer I2C Chip support"
+	depends on I2C_MUX && EXPERIMENTAL
+
+config I2C_MUX_PCA954x
+	tristate "Philips PCA954x I2C Mux/switches"
+	help
+	  If you say yes here you get support for the Philips PCA954x
+	  I2C mux/switch devices.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called pca954x.
+
+endmenu
diff --git a/drivers/i2c/muxes/Makefile b/drivers/i2c/muxes/Makefile
new file mode 100755
index 0000000..575c1ca
--- /dev/null
+++ b/drivers/i2c/muxes/Makefile
@@ -0,0 +1,8 @@
+#
+# Makefile for multiplexer I2C chip drivers.
+
+obj-$(CONFIG_I2C_MUX_PCA954x)	+= pca954x.o
+
+ifeq ($(I2C_DEBUG_BUS),y)
+EXTRA_CFLAGS += -DDEBUG
+endif
diff --git a/drivers/i2c/muxes/pca954x.c b/drivers/i2c/muxes/pca954x.c
new file mode 100755
index 0000000..12b5eb7
--- /dev/null
+++ b/drivers/i2c/muxes/pca954x.c
@@ -0,0 +1,302 @@
+/*
+ * I2C multiplexer
+ *
+ * Copyright (c) 2008-2009 Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>
+ * Copyright (c) 2008-2009 Eurotech S.p.A. <info-ymFC7zkAqBI1GQ1Ptb7lUw@public.gmane.org>
+ *
+ * This module supports the PCA954x series of I2C multiplexer/switch chips
+ * made by Philips Semiconductors.
+ * This includes the:
+ *	 PCA9540, PCA9542, PCA9543, PCA9544, PCA9545, PCA9546, PCA9547
+ *	 and PCA9548.
+ *
+ * These chips are all controlled via the I2C bus itself, and all have a
+ * single 8-bit register. The upstream "parent" bus fans out to two,
+ * four, or eight downstream busses or channels; which of these
+ * are selected is determined by the chip type and register contents. A
+ * mux can select only one sub-bus at a time; a switch can select any
+ * combination simultaneously.
+ *
+ * Based on:
+ *	pca954x.c from Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
+ * Copyright (C) 2006
+ *
+ * Based on:
+ *	pca954x.c from Ken Harrenstien
+ * Copyright (C) 2004 Google, Inc. (Ken Harrenstien)
+ *
+ * Based on:
+ *	i2c-virtual_cb.c from Brian Kuschak <bkuschak-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
+ * and
+ *	pca9540.c from Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>.
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/device.h>
+#include <linux/i2c.h>
+#include <linux/i2c-mux.h>
+
+#include <linux/i2c/pca954x.h>
+
+#define PCA954X_MAX_NCHANS 8
+
+enum pca_type {
+	pca_9540,
+	pca_9542,
+	pca_9543,
+	pca_9544,
+	pca_9545,
+	pca_9546,
+	pca_9547,
+	pca_9548,
+};
+
+struct pca954x {
+	enum	pca_type type;
+	struct	i2c_adapter *virt_adaps[PCA954X_MAX_NCHANS];
+
+	u8	last_chan;
+};
+
+struct chip_desc {
+	u8 nchans;
+	u8 enable;	/* used for muxes only */
+	enum muxtype {
+		pca954x_ismux = 0,
+		pca954x_isswi
+	} muxtype;
+};
+
+/* Provide specs for the PCA954x types we know about */
+static const struct chip_desc chips[] = {
+	[pca_9540] = {
+		.nchans = 2,
+		.enable = 0x4,
+		.muxtype = pca954x_ismux,
+	},
+	[pca_9543] = {
+		.nchans = 2,
+		.muxtype = pca954x_isswi,
+	},
+	[pca_9544] = {
+		.nchans = 4,
+		.enable = 0x4,
+		.muxtype = pca954x_ismux,
+	},
+	[pca_9545] = {
+		.nchans = 4,
+		.muxtype = pca954x_isswi,
+	},
+	[pca_9547] = {
+		.nchans = 8,
+		.enable = 0x8,
+		.muxtype = pca954x_ismux,
+	},
+	[pca_9548] = {
+		.nchans = 8,
+		.muxtype = pca954x_isswi,
+	},
+};
+
+static const struct i2c_device_id pca954x_id[] = {
+	{ "pca9540", pca_9540 },
+	{ "pca9542", pca_9540 },
+	{ "pca9543", pca_9543 },
+	{ "pca9544", pca_9544 },
+	{ "pca9545", pca_9545 },
+	{ "pca9546", pca_9545 },
+	{ "pca9547", pca_9547 },
+	{ "pca9548", pca_9548 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, pca954x_id);
+
+/* Write to mux register. Don't use i2c_transfer()/i2c_smbus_xfer()
+   for this as they will try to lock adapter a second time */
+static int pca954x_reg_write(struct i2c_adapter *adap,
+			     struct i2c_client *client, u8 val)
+{
+	int ret = -ENODEV;
+
+	if (adap->algo->master_xfer) {
+		struct i2c_msg msg;
+		char buf[1];
+
+		msg.addr = client->addr;
+		msg.flags = I2C_SMBUS_WRITE;
+		msg.len = 1;
+		buf[0] = val;
+		msg.buf = buf;
+		ret = adap->algo->master_xfer(adap, &msg, 1);
+	} else {
+		union i2c_smbus_data data;
+		ret = adap->algo->smbus_xfer(adap, client->addr,
+					     client->flags,
+					     I2C_SMBUS_WRITE,
+					     val, I2C_SMBUS_BYTE, &data);
+	}
+
+	return ret;
+}
+
+static int pca954x_select_chan(struct i2c_adapter *adap,
+			       void *client, u32 chan)
+{
+	struct pca954x *data = i2c_get_clientdata(client);
+	const struct chip_desc *chip = &chips[data->type];
+	u8 regval;
+	int ret = 0;
+
+	/* we make switches look like muxes, not sure how to be smarter */
+	if (chip->muxtype == pca954x_ismux)
+		regval = chan | chip->enable;
+	else
+		regval = 1 << chan;
+
+	/* Only select the channel if its different from the last channel */
+	if (data->last_chan != chan) {
+		ret = pca954x_reg_write(adap, client, regval);
+		data->last_chan = chan;
+	}
+
+	return ret;
+}
+
+static int pca954x_deselect_mux(struct i2c_adapter *adap,
+				void *client, u32 chan)
+{
+	struct pca954x *data = i2c_get_clientdata(client);
+
+	/* Deselect active channel */
+	data->last_chan = 0;
+	return pca954x_reg_write(adap, client, data->last_chan);
+}
+
+/*
+ * I2C init/probing/exit functions
+ */
+static int __devinit pca954x_probe(struct i2c_client *client,
+				   const struct i2c_device_id *id)
+{
+	struct i2c_adapter *adap = to_i2c_adapter(client->dev.parent);
+	struct pca954x_platform_data *pdata = client->dev.platform_data;
+	int num, force;
+	struct pca954x *data;
+	int ret = -ENODEV;
+
+	if (!i2c_check_functionality(adap, I2C_FUNC_SMBUS_BYTE))
+		goto err;
+
+	data = kzalloc(sizeof(struct pca954x), GFP_KERNEL);
+	if (!data) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	i2c_set_clientdata(client, data);
+
+	/* Read the mux register at addr to verify
+	 * that the mux is in fact present.
+	 */
+	if (i2c_smbus_read_byte(client) < 0) {
+		dev_warn(&client->dev, "probe failed\n");
+		goto exit_free;
+	}
+
+	data->type = id->driver_data;
+	data->last_chan = 0;		   /* force the first selection */
+
+	/* Now create an adapter for each channel */
+	for (num = 0; num < chips[data->type].nchans; num++) {
+		force = 0;			  /* dynamic adap number */
+		if (pdata) {
+			if (num < pdata->num_modes)
+				/* force static number */
+				force = pdata->modes[num].adap_id;
+			else
+				/* discard unconfigured channels */
+				break;
+		}
+
+		data->virt_adaps[num] =
+			i2c_add_mux_adapter(adap, client,
+				force, num, &pca954x_select_chan,
+				(pdata && pdata->modes[num].deselect_on_exit)
+					? &pca954x_deselect_mux : NULL);
+
+		if (data->virt_adaps[num] == NULL) {
+			ret = -ENODEV;
+			printk(KERN_ERR
+				"%s %s: failed to register multiplexed adapter"
+				" %d at bus %d\n", __FILE__, __func__, num,
+				force);
+			goto virt_reg_failed;
+		}
+	}
+
+	dev_info(&client->dev,
+		 "registered %d multiplexed busses for I2C %s %s\n",
+		 num, chips[data->type].muxtype == pca954x_ismux
+				? "mux" : "switch", client->name);
+
+	return 0;
+
+virt_reg_failed:
+	for (num--; num >= 0; num--)
+		i2c_del_mux_adapter(data->virt_adaps[num]);
+exit_free:
+	kfree(data);
+err:
+	return ret;
+}
+
+static int __devexit pca954x_remove(struct i2c_client *client)
+{
+	struct pca954x *data = i2c_get_clientdata(client);
+	const struct chip_desc *chip = &chips[data->type];
+	int i, err;
+
+	for (i = 0; i < chip->nchans; ++i)
+		if (data->virt_adaps[i]) {
+			err = i2c_del_mux_adapter(data->virt_adaps[i]);
+			if (err)
+				return err;
+			data->virt_adaps[i] = NULL;
+		}
+
+	kfree(data);
+	return 0;
+}
+
+static struct i2c_driver pca954x_driver = {
+	.driver		= {
+		.name	= "pca954x",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= pca954x_probe,
+	.remove		= __devexit_p(pca954x_remove),
+	.id_table	= pca954x_id,
+};
+
+static int __init pca954x_init(void)
+{
+	return i2c_add_driver(&pca954x_driver);
+}
+
+static void __exit pca954x_exit(void)
+{
+	i2c_del_driver(&pca954x_driver);
+}
+
+module_init(pca954x_init);
+module_exit(pca954x_exit);
+
+MODULE_AUTHOR("Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>");
+MODULE_DESCRIPTION("PCA954x I2C mux/switch driver");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/i2c/pca954x.h b/include/linux/i2c/pca954x.h
new file mode 100755
index 0000000..8032269
--- /dev/null
+++ b/include/linux/i2c/pca954x.h
@@ -0,0 +1,47 @@
+/*
+ *
+ * pca954x.h - I2C multiplexer/switch support
+ *
+ * Copyright (c) 2008-2009 Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>
+ * Copyright (c) 2008-2009 Eurotech S.p.A. <info-ymFC7zkAqBI1GQ1Ptb7lUw@public.gmane.org>
+ * Michael Lawnick <michael.lawnick.ext-OYasijW0DpE@public.gmane.org>
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
+
+#ifndef _I2C_PCA954X_H
+#define _I2C_PCA954X_H
+
+/* Platform data for the PCA954x I2C multiplexers */
+
+/* Per channel initialisation data:
+ * @adap_id: bus number for the adapter. 0 = don't care
+ * @deselect_on_exit: set this entry to 1, if your H/W needs deselection
+ *                    of this channel after transaction.
+ *
+ */
+struct pca954x_platform_mode {
+	int		adap_id;
+	unsigned int	deselect_on_exit:1;
+};
+
+/* Per mux/switch data, used with i2c_register_board_info */
+struct pca954x_platform_data {
+    struct pca954x_platform_mode *modes;
+    int num_modes;
+};
+
+#endif /*_I2C_PCA954X_H*/
-- 
1.6.2.1


--------------010107030706080403030507--
