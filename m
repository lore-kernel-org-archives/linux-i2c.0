From: "Edelhaeuser, Frank" <Frank.Edelhaeuser-CBC/uQSf1AZWk0Htik3J/w@public.gmane.org>
Subject: [PATCH] Add driver for PCA954x I2C switch/multiplexer
Date: Thu, 31 Jan 2008 09:38:40 -0800
Message-ID: <A42C17A8FF150C4DB98BFD6497D1D00007C9743F@ussvlexmbpf1.spansion.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Content-class: urn:content-classes:message
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
List-Id: linux-i2c@vger.kernel.org

Driver support for NXP/Philips I2C bus multiplexers (PCA9540, PCA9542,
PCA9543, PCA9544, PCA9545, PCA9546, PCA9547, PCA9548). Chip definitions
were borrowed from an older version of pca954x.c by Kumar Gala. This
code supports the "new style" I2C driver model and, unlike older
versions of pca954x.c, doesn't require any changes to the exisiting I2C
core infrastructure.
 
Signed-off-by: Frank Edelhaeuser <frank.edelhaeuser-CBC/uQSf1AZWk0Htik3J/w@public.gmane.org>
---
diff -Nur a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
--- a/drivers/i2c/busses/Kconfig 2007-11-11 21:49:02.000000000 +0100
+++ b/drivers/i2c/busses/Kconfig 2008-01-31 10:38:34.000000000 +0100
@@ -63,6 +63,18 @@
    This driver can also be built as a module.  If so, the module
    will be called i2c-amd756-s4882.
 
+config I2C_PCA954X
+ tristate "PCA954x I2C switches/multiplexers"
+ depends on EXPERIMENTAL
+ help
+   Enabling this option will add support for Philips/NXP I2C switches
+   an multiplexers. The I2C is multiplexed over up to 8 different 
+   channels, where the I2C clients live.  Saying yes here will give 
+   you access to these in addition to the trunk.
+
+   This driver can also be built as a module.  If so, the module
+   will be called i2c-pca945x.
+
 config I2C_AMD8111
  tristate "AMD 8111"
  depends on PCI
diff -Nur a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
--- a/drivers/i2c/busses/Makefile 2007-11-11 21:49:02.000000000 +0100
+++ b/drivers/i2c/busses/Makefile 2008-01-31 10:37:58.000000000 +0100
@@ -30,6 +30,7 @@
 obj-$(CONFIG_I2C_PARPORT_LIGHT) += i2c-parport-light.o
 obj-$(CONFIG_I2C_PASEMI) += i2c-pasemi.o
 obj-$(CONFIG_I2C_PCA_ISA) += i2c-pca-isa.o
+obj-$(CONFIG_I2C_PCA954X) += i2c-pca954x.o
 obj-$(CONFIG_I2C_PIIX4)  += i2c-piix4.o
 obj-$(CONFIG_I2C_PMCMSP) += i2c-pmcmsp.o
 obj-$(CONFIG_I2C_PNX)  += i2c-pnx.o
diff -Nur a/drivers/i2c/busses/i2c-pca954x.c
b/drivers/i2c/busses/i2c-pca954x.c
--- a/drivers/i2c/busses/i2c-pca954x.c 1970-01-01 01:00:00.000000000
+0100
+++ b/drivers/i2c/busses/i2c-pca954x.c 2008-01-31 16:47:47.000000000
+0100
@@ -0,0 +1,333 @@
+/*
+ * i2c-pca954x.c
+ *
+ * Written by: Frank Edelhaeuser <frank.edelhaeuser-CBC/uQSf1AZWk0Htik3J/w@public.gmane.org>
+ *
+ * Copyright (C) 2008 Spansion Inc. (Frank Edelhaeuser)
+ *
+ * This module supports the PCA954x series of I2C multiplexers/switches
+ * made by NXP, formerly Philips Semiconductors. This includes the
+ * PCA9540, PCA9542, PCA9543, PCA9544, PCA9545, PCA9546, PCA9547,
PCA9548
+ * and derivatives.
+ *
+ * These chips are all controlled via the I2C bus itself, and all have
a
+ * single 8-bit register (normally at 0x70). The upstream "parent" bus
fans
+ * out to two, four, or eight downstream busses or channels; which of
these
+ * are selected is determined by the chip type and register contents.
+ * A mux can select only one sub-bus at a time; a switch can select any
+ * combination simultaneously. However, here we use switches like a
mux.
+ *
+ * Based on:
+ *   pca954x.c from Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
+ * which was based on
+ *   pca954x.c from Ken Harrenstien
+ *   Copyright (C) 2004 Google, Inc. (Ken Harrenstien)
+ * and
+ *   i2c-virtual_cb.c from Brian Kuschak <bkuschak-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
+ * and
+ *   pca9540.c from Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, which was
+ *   based on pcf8574.c from the same project by Frodo Looijaard,
+ *   Philip Edelbrock, Dan Eaton and Aurelien Jarno.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/init.h>
+#include <linux/i2c.h>
+#include <linux/mutex.h>
+
+
+struct i2c_pca954x_chipdef {
+ const char *name;
+ u8 nchans;
+ u8 enable; /* used for muxes only */
+ enum muxtype { pca954x_ismux = 0, pca954x_isswi } muxtype;
+};
+
+static struct i2c_pca954x_chipdef i2c_pca954x_chips[] = {
+ {
+  .name = "pca9540",
+  .nchans = 2,
+  .enable = 0x4,
+  .muxtype = pca954x_ismux,
+ },
+ {
+  .name = "pca9542",
+  .nchans = 2,
+  .enable = 0x4,
+  .muxtype = pca954x_ismux,
+ },
+ {
+  .name = "pca9543",
+  .nchans = 2,
+  .enable = 0x0,
+  .muxtype = pca954x_isswi,
+ },
+ {
+  .name = "pca9544",
+  .nchans = 4,
+  .enable = 0x4,
+  .muxtype = pca954x_ismux,
+ },
+ {
+  .name = "pca9545",
+  .nchans = 4,
+  .enable = 0x0,
+  .muxtype = pca954x_isswi,
+ },
+ {
+  .name = "pca9546",
+  .nchans = 4,
+  .enable = 0x0,
+  .muxtype = pca954x_isswi,
+ },
+ {
+  .name = "pca9547",
+  .nchans = 8,
+  .enable = 0x8,
+  .muxtype = pca954x_ismux,
+ },
+ {
+  .name = "pca9548",
+  .nchans = 8,
+  .enable = 0x0,
+  .muxtype = pca954x_isswi,
+ },
+};
+
+
+struct i2c_pca954x_data {
+ struct i2c_client *client;
+ struct i2c_pca954x_chipdef *chip;
+ int last_chan;
+ int adapter_nr_first;
+ struct i2c_adapter adapters[8];
+ struct mutex lock;
+};
+
+
+static struct i2c_algorithm i2c_pca954x_algo;
+
+static int i2c_pca954x_select_chan(struct i2c_client *client, int chan)
+{
+ struct i2c_pca954x_data *data = i2c_get_clientdata(client);
+ u8 regval = 0;
+ int ret = 0;
+
+ /* We make switches look like muxes */
+ if (data->chip->muxtype == pca954x_ismux)
+  regval = chan | data->chip->enable;
+ else
+  regval = 1 << chan;
+
+ /* Only select the channel if it's different from the last channel */
+ if (data->last_chan != chan) {
+  ret = i2c_smbus_write_byte(client, regval);
+  if (ret < 0) {
+   dev_err(&client->dev,
+    "cannot write to %s device at address %04X\n",
+    client->name,
+    client->addr);
+  }
+  data->last_chan = chan;
+ }
+
+ return ret;
+}
+
+
+static int i2c_pca954x_master_xfer(struct i2c_adapter *adapter,
+ struct i2c_msg *msgs,
+ int num)
+{
+ struct i2c_pca954x_data *data = i2c_get_adapdata(adapter);
+ struct i2c_adapter *parent;
+ int chan;
+ int rc;
+
+ mutex_lock(&data->lock);
+ chan = i2c_adapter_id(adapter) - data->adapter_nr_first;
+ rc = i2c_pca954x_select_chan(data->client, chan);
+ if (rc >= 0) {
+  parent = data->client->adapter;
+  rc = parent->algo->master_xfer(parent, msgs, num);
+ }
+ mutex_unlock(&data->lock);
+
+ return rc;
+}
+
+
+static int i2c_pca954x_smbus_xfer(struct i2c_adapter *adapter, u16
addr,
+ unsigned short flags, char read_write,
+ u8 command, int size,
+ union i2c_smbus_data *data)
+{
+ struct i2c_pca954x_data *dat = i2c_get_adapdata(adapter);
+ struct i2c_adapter *parent;
+ int chan;
+ int rc;
+
+ mutex_lock(&dat->lock);
+ chan = i2c_adapter_id(adapter) - dat->adapter_nr_first;
+ rc = i2c_pca954x_select_chan(dat->client, chan);
+ if (rc >= 0) {
+  parent = dat->client->adapter;
+  rc = parent->algo->smbus_xfer(parent, addr, flags, read_write,
+   command, size, data);
+ }
+ mutex_unlock(&dat->lock);
+
+ return rc;
+}
+
+
+static int i2c_pca954x_remove(struct i2c_client *client)
+{
+ struct i2c_pca954x_data *data = i2c_get_clientdata(client);
+ int i;
+
+ if (data) {
+  /* Destroy all virtual I2C bus adapters we created */
+  i = 0;
+  while (i < ARRAY_SIZE(data->adapters)) {
+   if ((i2c_get_adapdata(&data->adapters[i])) &&
+       (i2c_del_adapter(&data->adapters[i]) < 0))
+    dev_err(&client->dev,
+     "cannot destroy adapter %i\n",
+     i);
+   i++;
+  }
+
+  /* Free client data structure */
+  i2c_set_clientdata(client, 0);
+  kfree(data);
+ }
+
+ return 0;
+}
+
+
+static int i2c_pca954x_probe(struct i2c_client *client)
+{
+ struct i2c_pca954x_chipdef *chip;
+ struct i2c_pca954x_data *data;
+ struct i2c_adapter *adapter;
+ char *name;
+ int rc;
+ int i;
+
+
+ /* Make sure parent adapter has I2C byte read/write functionality */
+ if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_BYTE)) {
+  dev_err(&client->dev,
+   "i2c bus does not support byte read/write\n");
+  return -ENODEV;
+ }
+
+ /* Look up chip type in table */
+ if (!client->name) {
+  dev_err(&client->dev,
+   "chip type must be specified in board info\n");
+  return -ENODEV;
+ }
+ chip = i2c_pca954x_chips;
+ while (strncmp(chip->name, client->name, strlen(chip->name))) {
+  chip++;
+  if (chip >= &i2c_pca954x_chips[ARRAY_SIZE(i2c_pca954x_chips)]) {
+   dev_err(&client->dev,
+    "unknown chip type (%s)\n",
+    client->name);
+   return -ENODEV;
+  }
+ }
+
+ /* Allocate client data structure */
+ data = kzalloc(sizeof(*data), GFP_KERNEL);
+ if (!data) {
+  dev_err(&client->dev, "cannot allocate client device data\n");
+  return -ENOMEM;
+ }
+ i2c_set_clientdata(client, data);
+ mutex_init(&data->lock);
+ data->client    = client;
+ data->chip      = chip;
+ data->last_chan = -1;
+
+ /* Check if local bus number was specified with i2c_board_info.type */
+ name = strchr(client->name, ',');
+ if (name) {
+  /* Bus number given e.g. "pxa9544,5" use bus 5 through 8 */
+  data->adapter_nr_first = (int) simple_strtol(name+1, NULL, 0);
+ } else {
+  /* Bus number not given. Start at parent's number + 1 */
+  data->adapter_nr_first = i2c_adapter_id(client->adapter) + 1;
+ }
+
+ /* Hook transfer proc's, copy other parent's proc */
+ i2c_pca954x_algo.functionality = client->adapter->algo->functionality;
+ if (client->adapter->algo->master_xfer)
+  i2c_pca954x_algo.master_xfer = i2c_pca954x_master_xfer;
+ if (client->adapter->algo->smbus_xfer)
+  i2c_pca954x_algo.smbus_xfer = i2c_pca954x_smbus_xfer;
+
+ /* Register virtual adapters for all local bus segments */
+ i = 0;
+ rc = 0;
+ while (i < chip->nchans) {
+  adapter = &data->adapters[i];
+  i2c_set_adapdata(adapter, data);
+  adapter->owner      = THIS_MODULE;
+  adapter->class      = I2C_CLASS_HWMON;
+  adapter->algo       = &i2c_pca954x_algo;
+  adapter->dev.parent = &client->dev;
+  adapter->nr         = data->adapter_nr_first + i;
+  strncpy(adapter->name,
+    "PCA954X virtual I2C adapter",
+    sizeof(adapter->name));
+  rc = i2c_add_numbered_adapter(adapter);
+  if (rc < 0) {
+   i2c_set_adapdata(adapter, 0);
+   dev_err(&client->dev,
+    "cannot create adapter for sub-channel %i\n",
+    i);
+  }
+  i++;
+ }
+
+ /* Cleanup on error */
+ if (rc < 0)
+  i2c_pca954x_remove(client);
+
+ return rc;
+}
+
+
+static struct i2c_driver i2c_pca954x_driver = {
+ .driver = {
+  .name = "i2c-pca954x",
+  },
+ .probe  = i2c_pca954x_probe,
+ .remove = i2c_pca954x_remove,
+};
+
+static int __init i2c_pca954x_init(void)
+{
+ return i2c_add_driver(&i2c_pca954x_driver);
+}
+
+static void __exit i2c_pca954x_exit(void)
+{
+ i2c_del_driver(&i2c_pca954x_driver);
+}
+
+module_init(i2c_pca954x_init);
+module_exit(i2c_pca954x_exit);
+
+MODULE_AUTHOR("Frank Edelhaeuser <frank.edelhaeuser-CBC/uQSf1AZWk0Htik3J/w@public.gmane.org>");
+MODULE_DESCRIPTION("PCA954X I2C bus multiplexing");
+MODULE_LICENSE("GPL");

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
