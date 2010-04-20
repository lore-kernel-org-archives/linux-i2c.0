From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c-stub: Add support for bus multiplexing
Date: Tue, 20 Apr 2010 14:40:34 +0200
Message-ID: <20100420144034.40d5985c@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>, Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: i2c-stub: Add support for bus multiplexing

Emulate a PCA9540 mux chip on request. There are two reasons for
implementing this:
* This makes it possible to emulate two chips at the same address.
* This lets us test the multiplexing code.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Cc: Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>
---
 Documentation/i2c/i2c-stub    |    9 ++
 drivers/i2c/busses/i2c-stub.c |  179 +++++++++++++++++++++++++++++++++++++----
 2 files changed, 171 insertions(+), 17 deletions(-)

--- linux-2.6.34-rc5.orig/drivers/i2c/busses/i2c-stub.c	2010-04-20 08:18:24.000000000 +0200
+++ linux-2.6.34-rc5/drivers/i2c/busses/i2c-stub.c	2010-04-20 13:42:53.000000000 +0200
@@ -2,7 +2,7 @@
     i2c-stub.c - I2C/SMBus chip emulator
 
     Copyright (c) 2004 Mark M. Hoffman <mhoffman-xQSgfq/1h4JiLUuM0BA3LQ@public.gmane.org>
-    Copyright (C) 2007 Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
+    Copyright (C) 2007-2010 Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
 
     This program is free software; you can redistribute it and/or modify
     it under the terms of the GNU General Public License as published by
@@ -33,11 +33,26 @@
 		   I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA | \
 		   I2C_FUNC_SMBUS_I2C_BLOCK)
 
+#define PCA9540_ADDR		0x70
+#define PCA9540_CHAN_MASK	0x07
+#define PCA9540_CHAN0_EN	0x04
+#define PCA9540_CHAN1_EN	0x05
+
 static unsigned short chip_addr[MAX_CHIPS];
 module_param_array(chip_addr, ushort, NULL, S_IRUGO);
 MODULE_PARM_DESC(chip_addr,
 		 "Chip addresses (up to 10, between 0x03 and 0x77)");
 
+static unsigned short pca9540_addr_0[MAX_CHIPS];
+module_param_array(pca9540_addr_0, ushort, NULL, S_IRUGO);
+MODULE_PARM_DESC(pca9540_addr_0,
+		 "Chip addresses on PCA9540 mux branch 0 (up to 10)");
+
+static unsigned short pca9540_addr_1[MAX_CHIPS];
+module_param_array(pca9540_addr_1, ushort, NULL, S_IRUGO);
+MODULE_PARM_DESC(pca9540_addr_1,
+		 "Chip addresses on PCA9540 mux branch 1 (up to 10)");
+
 static unsigned long functionality = STUB_FUNC;
 module_param(functionality, ulong, S_IRUGO | S_IWUSR);
 MODULE_PARM_DESC(functionality, "Override functionality bitfield");
@@ -49,10 +64,41 @@ struct stub_chip {
 };
 
 static struct stub_chip *stub_chips;
+static struct stub_chip *pca9540_chips_0;
+static struct stub_chip *pca9540_chips_1;
+static int have_pca9540;
+static u8 pca9540_state;
+
+static struct stub_chip *pca9540_get_chip(u16 addr)
+{
+	const unsigned short *pca9540_addr;
+	struct stub_chip *pca9540_chips;
+	int i;
+
+	switch (pca9540_state & PCA9540_CHAN_MASK) {
+	case PCA9540_CHAN0_EN:
+		pca9540_addr = pca9540_addr_0;
+		pca9540_chips = pca9540_chips_0;
+		break;
+	case PCA9540_CHAN1_EN:
+		pca9540_addr = pca9540_addr_1;
+		pca9540_chips = pca9540_chips_1;
+		break;
+	default:
+		return NULL;
+	}
+
+	for (i = 0; i < MAX_CHIPS && pca9540_addr[i]; i++) {
+		if (addr == pca9540_addr[i])
+			return pca9540_chips + i;
+	}
+	return NULL;
+}
 
 /* Return negative errno on error. */
-static s32 stub_xfer(struct i2c_adapter * adap, u16 addr, unsigned short flags,
-	char read_write, u8 command, int size, union i2c_smbus_data * data)
+static s32 stub_xfer_normal(struct i2c_adapter *adap, u16 addr,
+	unsigned short flags, char read_write, u8 command, int size,
+	union i2c_smbus_data *data)
 {
 	s32 ret;
 	int i, len;
@@ -65,6 +111,19 @@ static s32 stub_xfer(struct i2c_adapter
 			break;
 		}
 	}
+	/* If a PCA9540 mux chip is emulated, check its state to find out
+	 * which devices are reachable */
+	if (have_pca9540) {
+		struct stub_chip *chip_muxed = pca9540_get_chip(addr);
+		if (chip_muxed) {
+			if (chip) {
+				dev_err(&adap->dev, "Bad bus topology, "
+					"duplicate address 0x%02x\n", addr);
+				return -EIO;
+			}
+			chip = chip_muxed;
+		}
+	}
 	if (!chip)
 		return -ENODEV;
 
@@ -157,6 +216,39 @@ static s32 stub_xfer(struct i2c_adapter
 	return ret;
 }
 
+/* Emulate a PCA9540 mux chip */
+static s32 stub_xfer_pca9540(struct i2c_adapter *adap, u16 addr,
+	unsigned short flags, char read_write, u8 command, int size,
+	union i2c_smbus_data *data)
+{
+	if (size != I2C_SMBUS_BYTE) {
+		dev_dbg(&adap->dev, "Unsupported I2C/SMBus command\n");
+		return -EOPNOTSUPP;
+	}
+
+	if (read_write == I2C_SMBUS_WRITE) {
+		pca9540_state = command;
+		dev_dbg(&adap->dev, "PCA9540 - set to 0x%02x.\n", command);
+	} else {
+		data->byte = pca9540_state;
+		dev_dbg(&adap->dev, "PCA9540 - read   0x%02x.\n", data->byte);
+	}
+
+	return 0;
+}
+
+static s32 stub_xfer(struct i2c_adapter *adap, u16 addr, unsigned short flags,
+	char read_write, u8 command, int size, union i2c_smbus_data *data)
+{
+	if (have_pca9540 && addr == PCA9540_ADDR) {
+		return stub_xfer_pca9540(adap, addr, flags, read_write,
+					 command, size, data);
+	} else {
+		return stub_xfer_normal(adap, addr, flags, read_write,
+					command, size, data);
+	}
+}
+
 static u32 stub_func(struct i2c_adapter *adapter)
 {
 	return STUB_FUNC & functionality;
@@ -174,36 +266,89 @@ static struct i2c_adapter stub_adapter =
 	.name		= "SMBus stub driver",
 };
 
-static int __init i2c_stub_init(void)
+static int __init i2c_stub_parse_addresses(const unsigned short *addr,
+	struct stub_chip **chipsp, const char *suffix)
 {
-	int i, ret;
+	int i;
 
-	if (!chip_addr[0]) {
-		printk(KERN_ERR "i2c-stub: Please specify a chip address\n");
-		return -ENODEV;
-	}
+	/* Nothing to do if the address list is empty */
+	if (!addr[0])
+		return 0;
 
-	for (i = 0; i < MAX_CHIPS && chip_addr[i]; i++) {
-		if (chip_addr[i] < 0x03 || chip_addr[i] > 0x77) {
+	for (i = 0; i < MAX_CHIPS && addr[i]; i++) {
+		if (addr[i] < 0x03 || addr[i] > 0x77) {
 			printk(KERN_ERR "i2c-stub: Invalid chip address "
-			       "0x%02x\n", chip_addr[i]);
+			       "0x%02x\n", addr[i]);
+			return -EINVAL;
+		}
+		if (have_pca9540 && addr[i] == PCA9540_ADDR) {
+			printk(KERN_ERR "i2c-stub: Address 0x%02x reserved "
+			       "for PCA9540 mux\n", addr[i]);
 			return -EINVAL;
 		}
 
-		printk(KERN_INFO "i2c-stub: Virtual chip at 0x%02x\n",
-		       chip_addr[i]);
+		printk(KERN_INFO "i2c-stub: Virtual chip at 0x%02x%s\n",
+		       addr[i], suffix);
 	}
 
 	/* Allocate memory for all chips at once */
-	stub_chips = kzalloc(i * sizeof(struct stub_chip), GFP_KERNEL);
-	if (!stub_chips) {
+	*chipsp = kzalloc(i * sizeof(struct stub_chip), GFP_KERNEL);
+	if (!*chipsp) {
 		printk(KERN_ERR "i2c-stub: Out of memory\n");
 		return -ENOMEM;
 	}
 
+	return 0;
+}
+
+static int __init i2c_stub_init(void)
+{
+	int ret;
+
+	have_pca9540 = pca9540_addr_0[0] || pca9540_addr_1[0];
+	if (!chip_addr[0] && !have_pca9540) {
+		printk(KERN_ERR "i2c-stub: Please specify a chip address\n");
+		return -ENODEV;
+	}
+
+	ret = i2c_stub_parse_addresses(chip_addr, &stub_chips, "");
+	if (ret)
+		goto err_free;
+
+	ret = i2c_stub_parse_addresses(pca9540_addr_0, &pca9540_chips_0,
+				       " on PCA9540 mux branch 0");
+	if (ret)
+		goto err_free;
+
+	ret = i2c_stub_parse_addresses(pca9540_addr_1, &pca9540_chips_1,
+				       " on PCA9540 mux branch 1");
+	if (ret)
+		goto err_free;
+
+	/* Bus multiplexing isn't compatible with device auto-detection */
+	if (have_pca9540)
+		stub_adapter.class = 0;
+
 	ret = i2c_add_adapter(&stub_adapter);
 	if (ret)
-		kfree(stub_chips);
+		goto err_free;
+
+	/* Instantiate PCA9540 multiplexer chip if requested */
+	if (have_pca9540) {
+		struct i2c_board_info info;
+
+		memset(&info, 0, sizeof(struct i2c_board_info));
+		strlcpy(info.type, "pca9540", I2C_NAME_SIZE);
+		info.addr = PCA9540_ADDR;
+		i2c_new_device(&stub_adapter, &info);
+	}
+
+	return 0;
+
+ err_free:
+	kfree(stub_chips);
+	kfree(pca9540_chips_0);
+	kfree(pca9540_chips_1);
 	return ret;
 }
 
--- linux-2.6.34-rc5.orig/Documentation/i2c/i2c-stub	2010-03-05 11:08:47.000000000 +0100
+++ linux-2.6.34-rc5/Documentation/i2c/i2c-stub	2010-04-20 14:05:17.000000000 +0200
@@ -33,6 +33,15 @@ PARAMETERS:
 int chip_addr[10]:
 	The SMBus addresses to emulate chips at.
 
+int pca9540_addr_0[10]:
+int pca9540_addr_1[10]:
+	The SMBus addresses to emulate chips at on the two branches
+	of an emulated PCA9540 mux chip. The PCA9540 chip is emulated
+	at address 0x70 if and only if at least one address is provided
+	for either parameter. Also note that the adapter class is reset
+	in this case, so you always have to explicitly instantiate your
+	devices, auto-detection will no longer work.
+
 unsigned long functionality:
 	Functionality override, to disable some commands. See I2C_FUNC_*
 	constants in <linux/i2c.h> for the suitable values. For example,


-- 
Jean Delvare
