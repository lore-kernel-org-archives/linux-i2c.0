From: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c: driver for PCA954x I2C multiplexer series.
Date: Mon, 25 Jan 2010 13:15:25 +0100
Message-ID: <4B5D8B5D.9040108@gmx.de>
References: <4B5D8AFC.5060209@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4B5D8AFC.5060209-Mmb7MZpHnFY@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Subject: [PATCH 2/2] i2c: driver for PCA954x I2C multiplexer series.

Signed-off-by: Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>
Acked-by: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
---
 drivers/i2c/muxes/Kconfig   |    9 ++
 drivers/i2c/muxes/Makefile  |    2 +
 drivers/i2c/muxes/pca954x.c |  325
+++++++++++++++++++++++++++++++++++++++++++
 include/linux/i2c/pca954x.h |   13 ++
 4 files changed, 349 insertions(+), 0 deletions(-)
 create mode 100755 drivers/i2c/muxes/pca954x.c
 create mode 100755 include/linux/i2c/pca954x.h

diff --git a/drivers/i2c/muxes/Kconfig b/drivers/i2c/muxes/Kconfig
index 95b9bde..72c7055 100755
--- a/drivers/i2c/muxes/Kconfig
+++ b/drivers/i2c/muxes/Kconfig
@@ -5,4 +5,13 @@
 menu "Multiplexer I2C Chip support"
 	depends on I2C && I2C_MUX && EXPERIMENTAL

+config I2CMUX_PCA954x
+	tristate "Philips PCA953x I2C Mux/switches"
+	help
+	  If you say yes here you get support for the Philips PCA954x
+	  I2C mux/switch devices.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called pca954x.
+
 endmenu
diff --git a/drivers/i2c/muxes/Makefile b/drivers/i2c/muxes/Makefile
index 0416a52..2338d4c 100755
--- a/drivers/i2c/muxes/Makefile
+++ b/drivers/i2c/muxes/Makefile
@@ -1,6 +1,8 @@
 #
 # Makefile for multiplexer I2C chip drivers.

+obj-$(CONFIG_I2CMUX_PCA954x)	+= pca954x.o
+
 ifeq ($(CONFIG_I2C_DEBUG_CHIP),y)
 EXTRA_CFLAGS += -DDEBUG -DI2C_DEBUG_CORE
 endif
diff --git a/drivers/i2c/muxes/pca954x.c b/drivers/i2c/muxes/pca954x.c
new file mode 100755
index 0000000..0440a69
--- /dev/null
+++ b/drivers/i2c/muxes/pca954x.c
@@ -0,0 +1,325 @@
+/*
+ * I2C multiplexer
+ *
+ * Copyright (c) 2008-2009 Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>
+ * Copyright (c) 2008-2009 Eurotech S.p.A. <info-ymFC7zkAqBI1GQ1Ptb7lUw@public.gmane.org>
+ *
+ * This module supports the PCA954x series of I2C multiplexer/switch chips
+ * made by Philips Semiconductors.
+ * This includes the:
+ *     PCA9540, PCA9542, PCA9543, PCA9544, PCA9545, PCA9546, PCA9547
+ *     and PCA9548.
+ *
+ * These chips are all controlled via the I2C bus itself, and all have a
+ * single 8-bit register (normally at 0x70).  The upstream "parent" bus
fans
+ * out to two, four, or eight downstream busses or channels; which of these
+ * are selected is determined by the chip type and register contents.  A
+ * mux can select only one sub-bus at a time; a switch can select any
+ * combination simultaneously.
+ *
+ * Based on:
+ *    pca954x.c from Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
+ * Copyright (C) 2006
+ *
+ * Based on:
+ *    pca954x.c from Ken Harrenstien
+ * Copyright (C) 2004 Google, Inc. (Ken Harrenstien)
+ *
+ * Based on:
+ *    i2c-virtual_cb.c from Brian Kuschak <bkuschak-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
+ * and
+ *    pca9540.c from Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, which was
+ *    based on pcf8574.c from the same project by Frodo Looijaard,
+ *    Philip Edelbrock, Dan Eaton and Aurelien Jarno.
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+#include <linux/module.h>
+#include <linux/i2c.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
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
+	struct i2c_client *client;
+	struct i2c_client dev;
+	unsigned int type;
+	struct i2c_adapter *virt_adaps[PCA954X_MAX_NCHANS];
+
+	u8 last_chan;
+	unsigned int deselect_on_exit:1;
+	int (*is_chan_connected)(struct i2c_adapter *adap,
+			struct i2c_client *client, u32 chan);
+};
+
+struct chip_desc {
+	u8 nchans;
+	u8 enable;		/* used for muxes only */
+	enum muxtype {
+		pca954x_ismux = 0,
+		pca954x_isswi
+	} muxtype;
+};
+
+/* Provide specs for the PCA954x types we know about */
+static struct chip_desc chips[] = {
+	[pca_9540] = {
+		.nchans = 2,
+		.enable = 0x4,
+		.muxtype = pca954x_ismux,
+	},
+	[pca_9542] = {
+		.nchans = 2,
+		.enable = 0x4,
+		.muxtype = pca954x_ismux,
+	},
+	[pca_9543] = {
+		.nchans = 2,
+		.enable = 0x0,
+		.muxtype = pca954x_isswi,
+	},
+	[pca_9544] = {
+		.nchans = 4,
+		.enable = 0x4,
+		.muxtype = pca954x_ismux,
+	},
+	[pca_9545] = {
+		.nchans = 4,
+		.enable = 0x0,
+		.muxtype = pca954x_isswi,
+	},
+	[pca_9546] = {
+		.nchans = 4,
+		.enable = 0x0,
+		.muxtype = pca954x_isswi,
+	},
+	[pca_9547] = {
+		.nchans = 8,
+		.enable = 0x8,
+		.muxtype = pca954x_ismux,
+	},
+	[pca_9548] = {
+		.nchans = 8,
+		.enable = 0x0,
+		.muxtype = pca954x_isswi,
+	},
+};
+
+static const struct i2c_device_id pca954x_id[] = {
+	{ "pca9540", pca_9540 },
+	{ "pca9542", pca_9542 },
+	{ "pca9543", pca_9543 },
+	{ "pca9544", pca_9544 },
+	{ "pca9545", pca_9545 },
+	{ "pca9546", pca_9546 },
+	{ "pca9547", pca_9547 },
+	{ "pca9548", pca_9548 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, pca954x_id);
+
+static int pca954x_xfer(struct i2c_adapter *adap,
+			struct i2c_client *client, int read_write, u8 *val)
+{
+	int ret = -ENODEV;
+
+	if (adap->algo->master_xfer) {
+		struct i2c_msg msg;
+		char buf[1];
+
+		msg.addr = client->addr;
+		msg.flags = (read_write == I2C_SMBUS_READ ? I2C_M_RD : 0);
+		msg.len = 1;
+		buf[0] = *val;
+		msg.buf = buf;
+		ret = adap->algo->master_xfer(adap, &msg, 1);
+	} else if (adap->algo->smbus_xfer) {
+		union i2c_smbus_data data;
+		ret = adap->algo->smbus_xfer(adap, client->addr,
+						client->flags & I2C_M_TEN,
+						read_write,
+						*val, I2C_SMBUS_BYTE, &data);
+	}
+
+	return ret;
+}
+
+static int pca954x_select_chan(struct i2c_adapter *adap,
+				void *client, u32 chan)
+{
+	struct pca954x *data = i2c_get_clientdata((struct i2c_client *) client);
+	struct chip_desc *chip = &chips[data->type];
+	u8 regval = 0;
+	int ret = 0;
+
+	/* Callback to check for bus connection */
+	if (data->is_chan_connected) {
+		ret = data->is_chan_connected(adap, client, chan);
+		if (!ret)
+			return -EBUSY;
+	}
+
+	/* we make switches look like muxes, not sure how to be smarter */
+	if (chip->muxtype == pca954x_ismux)
+		regval = chan | chip->enable;
+	else
+		regval = 1 << chan;
+
+	/* Only select the channel if its different from the last channel */
+	if (data->last_chan != chan) {
+		ret = pca954x_xfer(adap, client, I2C_SMBUS_WRITE, &regval);
+		data->last_chan = chan;
+	}
+
+	return ret;
+}
+
+static int pca954x_deselect_mux(struct i2c_adapter *adap,
+				void *client, u32 chan)
+{
+	struct pca954x *data = i2c_get_clientdata((struct i2c_client *) client);
+	struct chip_desc *chip = &chips[data->type];
+	u8 regval = 0;
+
+	/* Check if we have to stay on the last channel we selected */
+	if (!data->deselect_on_exit && (chip->muxtype == pca954x_ismux))
+		return 0;
+
+	/* Signal we are deselecting active channel */
+	data->last_chan = -1;
+
+	regval = chan | ~chip->enable;
+	return pca954x_xfer(adap, client, I2C_SMBUS_WRITE, &regval);
+}
+
+/*
+ * I2C init/probing/exit functions
+ */
+static int pca954x_probe(struct i2c_client *client,
+				const struct i2c_device_id *id)
+{
+	struct i2c_adapter *adap = to_i2c_adapter(client->dev.parent);
+	struct pca954x_platform_data *pdata = client->dev.platform_data;
+	int i, n, f;
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
+	/* Read the mux register at addr.  This does two things: it verifies
+	 * that the mux is in fact present, and fetches its current
+	 * contents for possible use with a future deselect algorithm.
+	 */
+	i = i2c_smbus_read_byte(client);
+	if (i < 0) {
+		dev_warn(&client->dev, "probe failed\n");
+		goto exit_free;
+	}
+
+	data->type = id->driver_data;
+	data->last_chan = -1;			/* force the first selection */
+
+	/* Now create virtual busses and adapters for them */
+	for (i = 0; i < chips[data->type].nchans; i++) {
+		f = 0;				/* dynamic adap number */
+		if (pdata && (i < pdata->num_modes))
+			f = pdata->modes[i].adap_id; /* force static number */
+
+		data->virt_adaps[i] = i2c_add_mux_adapter(adap, client, f, i,
+						&pca954x_select_chan,
+						&pca954x_deselect_mux);
+		if (data->virt_adaps[i] == NULL) {
+			ret = -ENODEV;
+			goto virt_reg_failed;
+		}
+
+		data->deselect_on_exit = pdata ?
+				pdata->modes[i].deselect_on_exit : 1;
+		data->is_chan_connected = pdata ?
+				pdata->modes[i].is_chan_connected : NULL;
+	}
+
+	dev_info(&client->dev, "registered %d virtual busses for I2C %s %s\n",
+			i, chips[data->type].muxtype == pca954x_ismux ?
+					"mux" : "switch", client->name);
+
+	return 0;
+
+virt_reg_failed:
+	for (n = 0; n < i; n++)
+		i2c_del_mux_adapter(data->virt_adaps[n]);
+exit_free:
+	kfree(data);
+err:
+	return ret;
+}
+
+static int __devexit pca954x_remove(struct i2c_client *client)
+{
+	struct pca954x *data = i2c_get_clientdata(client);
+	struct chip_desc *chip = &chips[data->type];
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
+	.driver = {
+		.name	= "pca954x",
+		.owner	= THIS_MODULE,
+	},
+	.probe	= pca954x_probe,
+	.remove	= __devexit_p(pca954x_remove),
+	.id_table = pca954x_id,
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
index 0000000..18d5e79
--- /dev/null
+++ b/include/linux/i2c/pca954x.h
@@ -0,0 +1,13 @@
+/* Platform data for the PCA954x I2C multiplexers */
+
+struct pca954x_platform_mode {
+	int		adap_id;
+	unsigned int	deselect_on_exit:1;
+	int		(*is_chan_connected)(struct i2c_adapter *adap,
+					struct i2c_client *client, u32 chan);
+};
+
+struct pca954x_platform_data {
+	struct pca954x_platform_mode *modes;
+	int num_modes;
+};
-- 
1.6.1.2
