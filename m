From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c-nforce2: Add support for multiplexing on the Tyan
	S4985
Date: Tue, 6 May 2008 14:25:22 +0200
Message-ID: <20080506142522.01f65981@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Cc: Ulrich Drepper <drepper-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Just like the Tyan S4882, the S4985 uses a multiplexer to give access
to all 16 memory module SPD EEPROMs. This specific i2c-nforce2-s4985
driver adds support for this. It is heavily based on the older
i2c-amd756-s4882 driver.

As more mainboards will use multiplexer chips, we will have to find a
way to support them without having to write a new specfic driver for
each. The recent changes to the i2c subsystem should help us, and the
new gpio subsystem might help, too.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
 drivers/i2c/busses/Kconfig             |   13 +
 drivers/i2c/busses/Makefile            |    1 
 drivers/i2c/busses/i2c-nforce2-s4985.c |  261 ++++++++++++++++++++++++++++++++
 drivers/i2c/busses/i2c-nforce2.c       |   16 +
 4 files changed, 291 insertions(+)

--- linux-2.6.26-rc1.orig/drivers/i2c/busses/Kconfig	2008-05-06 14:19:06.000000000 +0200
+++ linux-2.6.26-rc1/drivers/i2c/busses/Kconfig	2008-05-06 14:19:15.000000000 +0200
@@ -315,6 +315,19 @@ config I2C_NFORCE2
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-nforce2.
 
+config I2C_NFORCE2_S4985
+	tristate "SMBus multiplexing on the Tyan S4985"
+	depends on I2C_NFORCE2 && EXPERIMENTAL
+	help
+	  Enabling this option will add specific SMBus support for the Tyan
+	  S4985 motherboard.  On this 4-CPU board, the SMBus is multiplexed
+	  over 4 different channels, where the various memory module EEPROMs
+	  live.  Saying yes here will give you access to these in addition
+	  to the trunk.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called i2c-nforce2-s4985.
+
 config I2C_OCORES
 	tristate "OpenCores I2C Controller"
 	depends on EXPERIMENTAL
--- linux-2.6.26-rc1.orig/drivers/i2c/busses/Makefile	2008-05-06 14:19:06.000000000 +0200
+++ linux-2.6.26-rc1/drivers/i2c/busses/Makefile	2008-05-06 14:19:15.000000000 +0200
@@ -24,6 +24,7 @@ obj-$(CONFIG_I2C_POWERMAC)	+= i2c-powerm
 obj-$(CONFIG_I2C_MPC)		+= i2c-mpc.o
 obj-$(CONFIG_I2C_MV64XXX)	+= i2c-mv64xxx.o
 obj-$(CONFIG_I2C_NFORCE2)	+= i2c-nforce2.o
+obj-$(CONFIG_I2C_NFORCE2_S4985)	+= i2c-nforce2-s4985.o
 obj-$(CONFIG_I2C_OCORES)	+= i2c-ocores.o
 obj-$(CONFIG_I2C_OMAP)		+= i2c-omap.o
 obj-$(CONFIG_I2C_PARPORT)	+= i2c-parport.o
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.26-rc1/drivers/i2c/busses/i2c-nforce2-s4985.c	2008-05-06 14:23:59.000000000 +0200
@@ -0,0 +1,261 @@
+/*
+ * i2c-nforce2-s4985.c - i2c-nforce2 extras for the Tyan S4985 motherboard
+ *
+ * Copyright (C) 2008 Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
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
+/*
+ * We select the channels by sending commands to the Philips
+ * PCA9556 chip at I2C address 0x18. The main adapter is used for
+ * the non-multiplexed part of the bus, and 4 virtual adapters
+ * are defined for the multiplexed addresses: 0x50-0x53 (memory
+ * module EEPROM) located on channels 1-4. We define one virtual
+ * adapter per CPU, which corresponds to one multiplexed channel:
+ *   CPU0: virtual adapter 1, channel 1
+ *   CPU1: virtual adapter 2, channel 2
+ *   CPU2: virtual adapter 3, channel 3
+ *   CPU3: virtual adapter 4, channel 4
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/init.h>
+#include <linux/i2c.h>
+#include <linux/mutex.h>
+
+extern struct i2c_adapter *nforce2_smbus;
+
+static struct i2c_adapter *s4985_adapter;
+static struct i2c_algorithm *s4985_algo;
+
+/* Wrapper access functions for multiplexed SMBus */
+static DEFINE_MUTEX(nforce2_lock);
+
+static s32 nforce2_access_virt0(struct i2c_adapter *adap, u16 addr,
+				unsigned short flags, char read_write,
+				u8 command, int size,
+				union i2c_smbus_data *data)
+{
+	int error;
+
+	/* We exclude the multiplexed addresses */
+	if ((addr & 0xfc) == 0x50 || (addr & 0xfc) == 0x30
+	 || addr == 0x18)
+		return -ENODEV;
+
+	mutex_lock(&nforce2_lock);
+	error = nforce2_smbus->algo->smbus_xfer(adap, addr, flags, read_write,
+						command, size, data);
+	mutex_unlock(&nforce2_lock);
+
+	return error;
+}
+
+/* We remember the last used channels combination so as to only switch
+   channels when it is really needed. This greatly reduces the SMBus
+   overhead, but also assumes that nobody will be writing to the PCA9556
+   in our back. */
+static u8 last_channels;
+
+static inline s32 nforce2_access_channel(struct i2c_adapter *adap, u16 addr,
+					 unsigned short flags, char read_write,
+					 u8 command, int size,
+					 union i2c_smbus_data *data,
+					 u8 channels)
+{
+	int error;
+
+	/* We exclude the non-multiplexed addresses */
+	if ((addr & 0xfc) != 0x50 && (addr & 0xfc) != 0x30)
+		return -ENODEV;
+
+	mutex_lock(&nforce2_lock);
+	if (last_channels != channels) {
+		union i2c_smbus_data mplxdata;
+		mplxdata.byte = channels;
+
+		error = nforce2_smbus->algo->smbus_xfer(adap, 0x18, 0,
+							I2C_SMBUS_WRITE, 0x01,
+							I2C_SMBUS_BYTE_DATA,
+							&mplxdata);
+		if (error)
+			goto UNLOCK;
+		last_channels = channels;
+	}
+	error = nforce2_smbus->algo->smbus_xfer(adap, addr, flags, read_write,
+						command, size, data);
+
+UNLOCK:
+	mutex_unlock(&nforce2_lock);
+	return error;
+}
+
+static s32 nforce2_access_virt1(struct i2c_adapter *adap, u16 addr,
+				unsigned short flags, char read_write,
+				u8 command, int size,
+				union i2c_smbus_data *data)
+{
+	/* CPU0: channel 1 enabled */
+	return nforce2_access_channel(adap, addr, flags, read_write, command,
+				      size, data, 0x02);
+}
+
+static s32 nforce2_access_virt2(struct i2c_adapter *adap, u16 addr,
+				unsigned short flags, char read_write,
+				u8 command, int size,
+				union i2c_smbus_data *data)
+{
+	/* CPU1: channel 2 enabled */
+	return nforce2_access_channel(adap, addr, flags, read_write, command,
+				      size, data, 0x04);
+}
+
+static s32 nforce2_access_virt3(struct i2c_adapter *adap, u16 addr,
+				unsigned short flags, char read_write,
+				u8 command, int size,
+				union i2c_smbus_data *data)
+{
+	/* CPU2: channel 3 enabled */
+	return nforce2_access_channel(adap, addr, flags, read_write, command,
+				      size, data, 0x08);
+}
+
+static s32 nforce2_access_virt4(struct i2c_adapter *adap, u16 addr,
+				unsigned short flags, char read_write,
+				u8 command, int size,
+				union i2c_smbus_data *data)
+{
+	/* CPU3: channel 4 enabled */
+	return nforce2_access_channel(adap, addr, flags, read_write, command,
+				      size, data, 0x10);
+}
+
+static int __init nforce2_s4985_init(void)
+{
+	int i, error;
+	union i2c_smbus_data ioconfig;
+
+	/* Unregister physical bus */
+	if (!nforce2_smbus)
+		return -ENODEV;
+	error = i2c_del_adapter(nforce2_smbus);
+	if (error) {
+		if (error == -EINVAL)
+			error = -ENODEV;
+		else
+			dev_err(&nforce2_smbus->dev, "Physical bus removal "
+				"failed\n");
+		goto ERROR0;
+	}
+
+	printk(KERN_INFO "Enabling SMBus multiplexing for Tyan S4985\n");
+	/* Define the 5 virtual adapters and algorithms structures */
+	s4985_adapter = kzalloc(5 * sizeof(struct i2c_adapter), GFP_KERNEL);
+	if (!s4985_adapter) {
+		error = -ENOMEM;
+		goto ERROR1;
+	}
+	s4985_algo = kzalloc(5 * sizeof(struct i2c_algorithm), GFP_KERNEL);
+	if (!s4985_algo) {
+		error = -ENOMEM;
+		goto ERROR2;
+	}
+
+	/* Fill in the new structures */
+	s4985_algo[0] = *(nforce2_smbus->algo);
+	s4985_algo[0].smbus_xfer = nforce2_access_virt0;
+	s4985_adapter[0] = *nforce2_smbus;
+	s4985_adapter[0].algo = s4985_algo;
+	s4985_adapter[0].dev.parent = nforce2_smbus->dev.parent;
+	for (i = 1; i < 5; i++) {
+		s4985_algo[i] = *(nforce2_smbus->algo);
+		s4985_adapter[i] = *nforce2_smbus;
+		snprintf(s4985_adapter[i].name, sizeof(s4985_adapter[i].name),
+			 "SMBus nForce2 adapter (CPU%d)", i - 1);
+		s4985_adapter[i].algo = s4985_algo + i;
+		s4985_adapter[i].dev.parent = nforce2_smbus->dev.parent;
+	}
+	s4985_algo[1].smbus_xfer = nforce2_access_virt1;
+	s4985_algo[2].smbus_xfer = nforce2_access_virt2;
+	s4985_algo[3].smbus_xfer = nforce2_access_virt3;
+	s4985_algo[4].smbus_xfer = nforce2_access_virt4;
+
+	/* Configure the PCA9556 multiplexer */
+	ioconfig.byte = 0x00; /* All I/O to output mode */
+	error = nforce2_smbus->algo->smbus_xfer(nforce2_smbus, 0x18, 0,
+						I2C_SMBUS_WRITE, 0x03,
+						I2C_SMBUS_BYTE_DATA, &ioconfig);
+	if (error) {
+		dev_err(&nforce2_smbus->dev, "PCA9556 configuration failed\n");
+		error = -EIO;
+		goto ERROR3;
+	}
+
+	/* Register virtual adapters */
+	for (i = 0; i < 5; i++) {
+		error = i2c_add_adapter(s4985_adapter + i);
+		if (error) {
+			dev_err(&nforce2_smbus->dev,
+				"Virtual adapter %d registration "
+				"failed, module not inserted\n", i);
+			for (i--; i >= 0; i--)
+				i2c_del_adapter(s4985_adapter + i);
+			goto ERROR3;
+		}
+	}
+
+	return 0;
+
+ERROR3:
+	kfree(s4985_algo);
+	s4985_algo = NULL;
+ERROR2:
+	kfree(s4985_adapter);
+	s4985_adapter = NULL;
+ERROR1:
+	/* Restore physical bus */
+	i2c_add_adapter(nforce2_smbus);
+ERROR0:
+	return error;
+}
+
+static void __exit nforce2_s4985_exit(void)
+{
+	if (s4985_adapter) {
+		int i;
+
+		for (i = 0; i < 5; i++)
+			i2c_del_adapter(s4985_adapter+i);
+		kfree(s4985_adapter);
+		s4985_adapter = NULL;
+	}
+	kfree(s4985_algo);
+	s4985_algo = NULL;
+
+	/* Restore physical bus */
+	if (i2c_add_adapter(nforce2_smbus))
+		dev_err(&nforce2_smbus->dev, "Physical bus restoration "
+			"failed\n");
+}
+
+MODULE_AUTHOR("Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>");
+MODULE_DESCRIPTION("S4985 SMBus multiplexing");
+MODULE_LICENSE("GPL");
+
+module_init(nforce2_s4985_init);
+module_exit(nforce2_s4985_exit);
--- linux-2.6.26-rc1.orig/drivers/i2c/busses/i2c-nforce2.c	2008-05-06 14:19:06.000000000 +0200
+++ linux-2.6.26-rc1/drivers/i2c/busses/i2c-nforce2.c	2008-05-06 14:19:15.000000000 +0200
@@ -111,6 +111,20 @@ struct nforce2_smbus {
 
 static struct pci_driver nforce2_driver;
 
+/* For multiplexing support, we need a global reference to the 1st
+   SMBus channel */
+#if defined CONFIG_I2C_NFORCE2_S4985 || defined CONFIG_I2C_NFORCE2_S4985_MODULE
+struct i2c_adapter *nforce2_smbus;
+EXPORT_SYMBOL_GPL(nforce2_smbus);
+
+static void nforce2_set_reference(struct i2c_adapter *adap)
+{
+	nforce2_smbus = adap;
+}
+#else
+static inline void nforce2_set_reference(struct i2c_adapter *adap) { }
+#endif
+
 static void nforce2_abort(struct i2c_adapter *adap)
 {
 	struct nforce2_smbus *smbus = adap->algo_data;
@@ -378,6 +392,7 @@ static int __devinit nforce2_probe(struc
 		return -ENODEV;
 	}
 
+	nforce2_set_reference(&smbuses[0].adapter);
 	return 0;
 }
 
@@ -386,6 +401,7 @@ static void __devexit nforce2_remove(str
 {
 	struct nforce2_smbus *smbuses = (void*) pci_get_drvdata(dev);
 
+	nforce2_set_reference(NULL);
 	if (smbuses[0].base) {
 		i2c_del_adapter(&smbuses[0].adapter);
 		release_region(smbuses[0].base, smbuses[0].size);


-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
