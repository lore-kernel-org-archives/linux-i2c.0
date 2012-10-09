From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c-stub: Move to drivers/i2c
Date: Tue, 9 Oct 2012 22:10:49 +0200
Message-ID: <20121009221049.72c0075c@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Peter Huewe <peterhuewe-Mmb7MZpHnFY@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Move the i2c-stub driver to drivers/i2c, to match the Kconfig entry.
This is less confusing that way.

I also fixed all checkpatch warnings and errors.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Peter Huewe <peterhuewe-Mmb7MZpHnFY@public.gmane.org>
---
 drivers/i2c/Makefile          |    1 
 drivers/i2c/busses/Makefile   |    1 
 drivers/i2c/busses/i2c-stub.c |  222 -----------------------------------------
 drivers/i2c/i2c-stub.c        |  221 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 222 insertions(+), 223 deletions(-)

--- linux-3.7-rc0.orig/drivers/i2c/busses/i2c-stub.c	2012-07-21 22:58:29.000000000 +0200
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,222 +0,0 @@
-/*
-    i2c-stub.c - I2C/SMBus chip emulator
-
-    Copyright (c) 2004 Mark M. Hoffman <mhoffman-xQSgfq/1h4JiLUuM0BA3LQ@public.gmane.org>
-    Copyright (C) 2007 Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
-
-    This program is free software; you can redistribute it and/or modify
-    it under the terms of the GNU General Public License as published by
-    the Free Software Foundation; either version 2 of the License, or
-    (at your option) any later version.
-
-    This program is distributed in the hope that it will be useful,
-    but WITHOUT ANY WARRANTY; without even the implied warranty of
-    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-    GNU General Public License for more details.
-
-    You should have received a copy of the GNU General Public License
-    along with this program; if not, write to the Free Software
-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
-*/
-
-#define DEBUG 1
-
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/slab.h>
-#include <linux/errno.h>
-#include <linux/i2c.h>
-
-#define MAX_CHIPS 10
-#define STUB_FUNC (I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE | \
-		   I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA | \
-		   I2C_FUNC_SMBUS_I2C_BLOCK)
-
-static unsigned short chip_addr[MAX_CHIPS];
-module_param_array(chip_addr, ushort, NULL, S_IRUGO);
-MODULE_PARM_DESC(chip_addr,
-		 "Chip addresses (up to 10, between 0x03 and 0x77)");
-
-static unsigned long functionality = STUB_FUNC;
-module_param(functionality, ulong, S_IRUGO | S_IWUSR);
-MODULE_PARM_DESC(functionality, "Override functionality bitfield");
-
-struct stub_chip {
-	u8 pointer;
-	u16 words[256];		/* Byte operations use the LSB as per SMBus
-				   specification */
-};
-
-static struct stub_chip *stub_chips;
-
-/* Return negative errno on error. */
-static s32 stub_xfer(struct i2c_adapter * adap, u16 addr, unsigned short flags,
-	char read_write, u8 command, int size, union i2c_smbus_data * data)
-{
-	s32 ret;
-	int i, len;
-	struct stub_chip *chip = NULL;
-
-	/* Search for the right chip */
-	for (i = 0; i < MAX_CHIPS && chip_addr[i]; i++) {
-		if (addr == chip_addr[i]) {
-			chip = stub_chips + i;
-			break;
-		}
-	}
-	if (!chip)
-		return -ENODEV;
-
-	switch (size) {
-
-	case I2C_SMBUS_QUICK:
-		dev_dbg(&adap->dev, "smbus quick - addr 0x%02x\n", addr);
-		ret = 0;
-		break;
-
-	case I2C_SMBUS_BYTE:
-		if (read_write == I2C_SMBUS_WRITE) {
-			chip->pointer = command;
-			dev_dbg(&adap->dev, "smbus byte - addr 0x%02x, "
-					"wrote 0x%02x.\n",
-					addr, command);
-		} else {
-			data->byte = chip->words[chip->pointer++] & 0xff;
-			dev_dbg(&adap->dev, "smbus byte - addr 0x%02x, "
-					"read  0x%02x.\n",
-					addr, data->byte);
-		}
-
-		ret = 0;
-		break;
-
-	case I2C_SMBUS_BYTE_DATA:
-		if (read_write == I2C_SMBUS_WRITE) {
-			chip->words[command] &= 0xff00;
-			chip->words[command] |= data->byte;
-			dev_dbg(&adap->dev, "smbus byte data - addr 0x%02x, "
-					"wrote 0x%02x at 0x%02x.\n",
-					addr, data->byte, command);
-		} else {
-			data->byte = chip->words[command] & 0xff;
-			dev_dbg(&adap->dev, "smbus byte data - addr 0x%02x, "
-					"read  0x%02x at 0x%02x.\n",
-					addr, data->byte, command);
-		}
-		chip->pointer = command + 1;
-
-		ret = 0;
-		break;
-
-	case I2C_SMBUS_WORD_DATA:
-		if (read_write == I2C_SMBUS_WRITE) {
-			chip->words[command] = data->word;
-			dev_dbg(&adap->dev, "smbus word data - addr 0x%02x, "
-					"wrote 0x%04x at 0x%02x.\n",
-					addr, data->word, command);
-		} else {
-			data->word = chip->words[command];
-			dev_dbg(&adap->dev, "smbus word data - addr 0x%02x, "
-					"read  0x%04x at 0x%02x.\n",
-					addr, data->word, command);
-		}
-
-		ret = 0;
-		break;
-
-	case I2C_SMBUS_I2C_BLOCK_DATA:
-		len = data->block[0];
-		if (read_write == I2C_SMBUS_WRITE) {
-			for (i = 0; i < len; i++) {
-				chip->words[command + i] &= 0xff00;
-				chip->words[command + i] |= data->block[1 + i];
-			}
-			dev_dbg(&adap->dev, "i2c block data - addr 0x%02x, "
-					"wrote %d bytes at 0x%02x.\n",
-					addr, len, command);
-		} else {
-			for (i = 0; i < len; i++) {
-				data->block[1 + i] =
-					chip->words[command + i] & 0xff;
-			}
-			dev_dbg(&adap->dev, "i2c block data - addr 0x%02x, "
-					"read  %d bytes at 0x%02x.\n",
-					addr, len, command);
-		}
-
-		ret = 0;
-		break;
-
-	default:
-		dev_dbg(&adap->dev, "Unsupported I2C/SMBus command\n");
-		ret = -EOPNOTSUPP;
-		break;
-	} /* switch (size) */
-
-	return ret;
-}
-
-static u32 stub_func(struct i2c_adapter *adapter)
-{
-	return STUB_FUNC & functionality;
-}
-
-static const struct i2c_algorithm smbus_algorithm = {
-	.functionality	= stub_func,
-	.smbus_xfer	= stub_xfer,
-};
-
-static struct i2c_adapter stub_adapter = {
-	.owner		= THIS_MODULE,
-	.class		= I2C_CLASS_HWMON | I2C_CLASS_SPD,
-	.algo		= &smbus_algorithm,
-	.name		= "SMBus stub driver",
-};
-
-static int __init i2c_stub_init(void)
-{
-	int i, ret;
-
-	if (!chip_addr[0]) {
-		printk(KERN_ERR "i2c-stub: Please specify a chip address\n");
-		return -ENODEV;
-	}
-
-	for (i = 0; i < MAX_CHIPS && chip_addr[i]; i++) {
-		if (chip_addr[i] < 0x03 || chip_addr[i] > 0x77) {
-			printk(KERN_ERR "i2c-stub: Invalid chip address "
-			       "0x%02x\n", chip_addr[i]);
-			return -EINVAL;
-		}
-
-		printk(KERN_INFO "i2c-stub: Virtual chip at 0x%02x\n",
-		       chip_addr[i]);
-	}
-
-	/* Allocate memory for all chips at once */
-	stub_chips = kzalloc(i * sizeof(struct stub_chip), GFP_KERNEL);
-	if (!stub_chips) {
-		printk(KERN_ERR "i2c-stub: Out of memory\n");
-		return -ENOMEM;
-	}
-
-	ret = i2c_add_adapter(&stub_adapter);
-	if (ret)
-		kfree(stub_chips);
-	return ret;
-}
-
-static void __exit i2c_stub_exit(void)
-{
-	i2c_del_adapter(&stub_adapter);
-	kfree(stub_chips);
-}
-
-MODULE_AUTHOR("Mark M. Hoffman <mhoffman-xQSgfq/1h4JiLUuM0BA3LQ@public.gmane.org>");
-MODULE_DESCRIPTION("I2C stub driver");
-MODULE_LICENSE("GPL");
-
-module_init(i2c_stub_init);
-module_exit(i2c_stub_exit);
-
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-3.7-rc0/drivers/i2c/i2c-stub.c	2012-10-09 18:56:00.122815452 +0200
@@ -0,0 +1,221 @@
+/*
+    i2c-stub.c - I2C/SMBus chip emulator
+
+    Copyright (c) 2004 Mark M. Hoffman <mhoffman-xQSgfq/1h4JiLUuM0BA3LQ@public.gmane.org>
+    Copyright (C) 2007, 2012 Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
+
+    This program is free software; you can redistribute it and/or modify
+    it under the terms of the GNU General Public License as published by
+    the Free Software Foundation; either version 2 of the License, or
+    (at your option) any later version.
+
+    This program is distributed in the hope that it will be useful,
+    but WITHOUT ANY WARRANTY; without even the implied warranty of
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+    GNU General Public License for more details.
+
+    You should have received a copy of the GNU General Public License
+    along with this program; if not, write to the Free Software
+    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+*/
+
+#define DEBUG 1
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/errno.h>
+#include <linux/i2c.h>
+
+#define MAX_CHIPS 10
+#define STUB_FUNC (I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE | \
+		   I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA | \
+		   I2C_FUNC_SMBUS_I2C_BLOCK)
+
+static unsigned short chip_addr[MAX_CHIPS];
+module_param_array(chip_addr, ushort, NULL, S_IRUGO);
+MODULE_PARM_DESC(chip_addr,
+		 "Chip addresses (up to 10, between 0x03 and 0x77)");
+
+static unsigned long functionality = STUB_FUNC;
+module_param(functionality, ulong, S_IRUGO | S_IWUSR);
+MODULE_PARM_DESC(functionality, "Override functionality bitfield");
+
+struct stub_chip {
+	u8 pointer;
+	u16 words[256];		/* Byte operations use the LSB as per SMBus
+				   specification */
+};
+
+static struct stub_chip *stub_chips;
+
+/* Return negative errno on error. */
+static s32 stub_xfer(struct i2c_adapter *adap, u16 addr, unsigned short flags,
+	char read_write, u8 command, int size, union i2c_smbus_data *data)
+{
+	s32 ret;
+	int i, len;
+	struct stub_chip *chip = NULL;
+
+	/* Search for the right chip */
+	for (i = 0; i < MAX_CHIPS && chip_addr[i]; i++) {
+		if (addr == chip_addr[i]) {
+			chip = stub_chips + i;
+			break;
+		}
+	}
+	if (!chip)
+		return -ENODEV;
+
+	switch (size) {
+
+	case I2C_SMBUS_QUICK:
+		dev_dbg(&adap->dev, "smbus quick - addr 0x%02x\n", addr);
+		ret = 0;
+		break;
+
+	case I2C_SMBUS_BYTE:
+		if (read_write == I2C_SMBUS_WRITE) {
+			chip->pointer = command;
+			dev_dbg(&adap->dev,
+				"smbus byte - addr 0x%02x, wrote 0x%02x.\n",
+				addr, command);
+		} else {
+			data->byte = chip->words[chip->pointer++] & 0xff;
+			dev_dbg(&adap->dev,
+				"smbus byte - addr 0x%02x, read  0x%02x.\n",
+				addr, data->byte);
+		}
+
+		ret = 0;
+		break;
+
+	case I2C_SMBUS_BYTE_DATA:
+		if (read_write == I2C_SMBUS_WRITE) {
+			chip->words[command] &= 0xff00;
+			chip->words[command] |= data->byte;
+			dev_dbg(&adap->dev,
+				"smbus byte data - addr 0x%02x, wrote 0x%02x at 0x%02x.\n",
+				addr, data->byte, command);
+		} else {
+			data->byte = chip->words[command] & 0xff;
+			dev_dbg(&adap->dev,
+				"smbus byte data - addr 0x%02x, read  0x%02x at 0x%02x.\n",
+				addr, data->byte, command);
+		}
+		chip->pointer = command + 1;
+
+		ret = 0;
+		break;
+
+	case I2C_SMBUS_WORD_DATA:
+		if (read_write == I2C_SMBUS_WRITE) {
+			chip->words[command] = data->word;
+			dev_dbg(&adap->dev,
+				"smbus word data - addr 0x%02x, wrote 0x%04x at 0x%02x.\n",
+				addr, data->word, command);
+		} else {
+			data->word = chip->words[command];
+			dev_dbg(&adap->dev,
+				"smbus word data - addr 0x%02x, read  0x%04x at 0x%02x.\n",
+				addr, data->word, command);
+		}
+
+		ret = 0;
+		break;
+
+	case I2C_SMBUS_I2C_BLOCK_DATA:
+		len = data->block[0];
+		if (read_write == I2C_SMBUS_WRITE) {
+			for (i = 0; i < len; i++) {
+				chip->words[command + i] &= 0xff00;
+				chip->words[command + i] |= data->block[1 + i];
+			}
+			dev_dbg(&adap->dev,
+				"i2c block data - addr 0x%02x, wrote %d bytes at 0x%02x.\n",
+				addr, len, command);
+		} else {
+			for (i = 0; i < len; i++) {
+				data->block[1 + i] =
+					chip->words[command + i] & 0xff;
+			}
+			dev_dbg(&adap->dev,
+				"i2c block data - addr 0x%02x, read  %d bytes at 0x%02x.\n",
+				addr, len, command);
+		}
+
+		ret = 0;
+		break;
+
+	default:
+		dev_dbg(&adap->dev, "Unsupported I2C/SMBus command\n");
+		ret = -EOPNOTSUPP;
+		break;
+	} /* switch (size) */
+
+	return ret;
+}
+
+static u32 stub_func(struct i2c_adapter *adapter)
+{
+	return STUB_FUNC & functionality;
+}
+
+static const struct i2c_algorithm smbus_algorithm = {
+	.functionality	= stub_func,
+	.smbus_xfer	= stub_xfer,
+};
+
+static struct i2c_adapter stub_adapter = {
+	.owner		= THIS_MODULE,
+	.class		= I2C_CLASS_HWMON | I2C_CLASS_SPD,
+	.algo		= &smbus_algorithm,
+	.name		= "SMBus stub driver",
+};
+
+static int __init i2c_stub_init(void)
+{
+	int i, ret;
+
+	if (!chip_addr[0]) {
+		pr_err("i2c-stub: Please specify a chip address\n");
+		return -ENODEV;
+	}
+
+	for (i = 0; i < MAX_CHIPS && chip_addr[i]; i++) {
+		if (chip_addr[i] < 0x03 || chip_addr[i] > 0x77) {
+			pr_err("i2c-stub: Invalid chip address 0x%02x\n",
+			       chip_addr[i]);
+			return -EINVAL;
+		}
+
+		pr_info("i2c-stub: Virtual chip at 0x%02x\n", chip_addr[i]);
+	}
+
+	/* Allocate memory for all chips at once */
+	stub_chips = kzalloc(i * sizeof(struct stub_chip), GFP_KERNEL);
+	if (!stub_chips) {
+		pr_err("i2c-stub: Out of memory\n");
+		return -ENOMEM;
+	}
+
+	ret = i2c_add_adapter(&stub_adapter);
+	if (ret)
+		kfree(stub_chips);
+	return ret;
+}
+
+static void __exit i2c_stub_exit(void)
+{
+	i2c_del_adapter(&stub_adapter);
+	kfree(stub_chips);
+}
+
+MODULE_AUTHOR("Mark M. Hoffman <mhoffman-xQSgfq/1h4JiLUuM0BA3LQ@public.gmane.org>");
+MODULE_DESCRIPTION("I2C stub driver");
+MODULE_LICENSE("GPL");
+
+module_init(i2c_stub_init);
+module_exit(i2c_stub_exit);
+
--- linux-3.7-rc0.orig/drivers/i2c/Makefile	2012-10-08 22:06:00.000000000 +0200
+++ linux-3.7-rc0/drivers/i2c/Makefile	2012-10-09 18:19:21.145857771 +0200
@@ -8,6 +8,7 @@ obj-$(CONFIG_I2C_SMBUS)		+= i2c-smbus.o
 obj-$(CONFIG_I2C_CHARDEV)	+= i2c-dev.o
 obj-$(CONFIG_I2C_MUX)		+= i2c-mux.o
 obj-y				+= algos/ busses/ muxes/
+obj-$(CONFIG_I2C_STUB)		+= i2c-stub.o
 
 ccflags-$(CONFIG_I2C_DEBUG_CORE) := -DDEBUG
 CFLAGS_i2c-core.o := -Wno-deprecated-declarations
--- linux-3.7-rc0.orig/drivers/i2c/busses/Makefile	2012-10-03 17:50:40.000000000 +0200
+++ linux-3.7-rc0/drivers/i2c/busses/Makefile	2012-10-09 18:19:14.126856390 +0200
@@ -84,7 +84,6 @@ obj-$(CONFIG_I2C_ACORN)		+= i2c-acorn.o
 obj-$(CONFIG_I2C_ELEKTOR)	+= i2c-elektor.o
 obj-$(CONFIG_I2C_PCA_ISA)	+= i2c-pca-isa.o
 obj-$(CONFIG_I2C_SIBYTE)	+= i2c-sibyte.o
-obj-$(CONFIG_I2C_STUB)		+= i2c-stub.o
 obj-$(CONFIG_SCx200_ACB)	+= scx200_acb.o
 obj-$(CONFIG_SCx200_I2C)	+= scx200_i2c.o
 


-- 
Jean Delvare
