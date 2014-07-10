From: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 2/2] i2c-stub: Add support for banked register ranges
Date: Thu, 10 Jul 2014 12:56:59 +0200
Message-ID: <20140710125659.015f1517@endymion.delvare>
References: <20140710124511.05108894@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140710124511.05108894-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Some chips implement banked register ranges. This allows implementing
more registers than the limited 8-bit address space originally allows.
In order to access a register on these chips, you must first select
the proper bank. Add support for this mechanism to the i2c-stub driver
so that such chips can be emulated. All the bank settings are passed
as module parameters.

Signed-off-by: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Cc: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
---
Tested successfully with:
http://jdelvare.nerim.net/devel/lm-sensors/dumps/w83793-for-stub.dump

 Documentation/i2c/i2c-stub |   11 ++-
 drivers/i2c/i2c-stub.c     |  131 +++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 128 insertions(+), 14 deletions(-)

--- linux-3.16-rc3.orig/drivers/i2c/i2c-stub.c	2014-07-10 12:44:35.705936505 +0200
+++ linux-3.16-rc3/drivers/i2c/i2c-stub.c	2014-07-10 12:47:52.449819728 +0200
@@ -2,7 +2,7 @@
     i2c-stub.c - I2C/SMBus chip emulator
 
     Copyright (c) 2004 Mark M. Hoffman <mhoffman-xQSgfq/1h4JiLUuM0BA3LQ@public.gmane.org>
-    Copyright (C) 2007, 2012 Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
+    Copyright (C) 2007-2014 Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
 
     This program is free software; you can redistribute it and/or modify
     it under the terms of the GNU General Public License as published by
@@ -47,6 +47,24 @@ static unsigned long functionality = STU
 module_param(functionality, ulong, S_IRUGO | S_IWUSR);
 MODULE_PARM_DESC(functionality, "Override functionality bitfield");
 
+/* Some chips have banked register ranges */
+
+static u8 bank_reg[MAX_CHIPS];
+module_param_array(bank_reg, byte, NULL, S_IRUGO);
+MODULE_PARM_DESC(bank_reg, "Bank register");
+
+static u8 bank_mask[MAX_CHIPS];
+module_param_array(bank_mask, byte, NULL, S_IRUGO);
+MODULE_PARM_DESC(bank_mask, "Bank value mask");
+
+static u8 bank_start[MAX_CHIPS];
+module_param_array(bank_start, byte, NULL, S_IRUGO);
+MODULE_PARM_DESC(bank_start, "First banked register");
+
+static u8 bank_end[MAX_CHIPS];
+module_param_array(bank_end, byte, NULL, S_IRUGO);
+MODULE_PARM_DESC(bank_end, "Last banked register");
+
 struct smbus_block_data {
 	struct list_head node;
 	u8 command;
@@ -59,6 +77,16 @@ struct stub_chip {
 	u16 words[256];		/* Byte operations use the LSB as per SMBus
 				   specification */
 	struct list_head smbus_blocks;
+
+	/* For chips with banks, extra registers are allocated dynamically */
+	u8 bank_reg;
+	u8 bank_shift;
+	u8 bank_mask;
+	u8 bank_sel;		/* Currently selected bank */
+	u8 bank_start;
+	u8 bank_end;
+	u16 bank_size;
+	u16 *bank_words;	/* Room for bank_mask * bank_size registers */
 };
 
 static struct stub_chip *stub_chips;
@@ -86,6 +114,17 @@ static struct smbus_block_data *stub_fin
 	return rb;
 }
 
+static u16 *stub_get_wordp(struct stub_chip *chip, u8 offset)
+{
+	if (chip->bank_sel &&
+	    offset >= chip->bank_start && offset <= chip->bank_end)
+		return chip->bank_words +
+		       (chip->bank_sel - 1) * chip->bank_size +
+		       offset - chip->bank_start;
+	else
+		return chip->words + offset;
+}
+
 /* Return negative errno on error. */
 static s32 stub_xfer(struct i2c_adapter *adap, u16 addr, unsigned short flags,
 	char read_write, u8 command, int size, union i2c_smbus_data *data)
@@ -94,6 +133,7 @@ static s32 stub_xfer(struct i2c_adapter
 	int i, len;
 	struct stub_chip *chip = NULL;
 	struct smbus_block_data *b;
+	u16 *wordp;
 
 	/* Search for the right chip */
 	for (i = 0; i < stub_chips_nr; i++) {
@@ -119,7 +159,8 @@ static s32 stub_xfer(struct i2c_adapter
 				"smbus byte - addr 0x%02x, wrote 0x%02x.\n",
 				addr, command);
 		} else {
-			data->byte = chip->words[chip->pointer++] & 0xff;
+			wordp = stub_get_wordp(chip, chip->pointer++);
+			data->byte = *wordp & 0xff;
 			dev_dbg(&adap->dev,
 				"smbus byte - addr 0x%02x, read  0x%02x.\n",
 				addr, data->byte);
@@ -129,14 +170,25 @@ static s32 stub_xfer(struct i2c_adapter
 		break;
 
 	case I2C_SMBUS_BYTE_DATA:
+		wordp = stub_get_wordp(chip, command);
 		if (read_write == I2C_SMBUS_WRITE) {
-			chip->words[command] &= 0xff00;
-			chip->words[command] |= data->byte;
+			*wordp &= 0xff00;
+			*wordp |= data->byte;
 			dev_dbg(&adap->dev,
 				"smbus byte data - addr 0x%02x, wrote 0x%02x at 0x%02x.\n",
 				addr, data->byte, command);
+
+			/* Set the bank as needed */
+			if (chip->bank_words && command == chip->bank_reg) {
+				chip->bank_sel =
+					(data->byte >> chip->bank_shift)
+					& chip->bank_mask;
+				dev_dbg(&adap->dev,
+					"switching to bank %u.\n",
+					chip->bank_sel);
+			}
 		} else {
-			data->byte = chip->words[command] & 0xff;
+			data->byte = *wordp & 0xff;
 			dev_dbg(&adap->dev,
 				"smbus byte data - addr 0x%02x, read  0x%02x at 0x%02x.\n",
 				addr, data->byte, command);
@@ -147,13 +199,14 @@ static s32 stub_xfer(struct i2c_adapter
 		break;
 
 	case I2C_SMBUS_WORD_DATA:
+		wordp = stub_get_wordp(chip, command);
 		if (read_write == I2C_SMBUS_WRITE) {
-			chip->words[command] = data->word;
+			*wordp = data->word;
 			dev_dbg(&adap->dev,
 				"smbus word data - addr 0x%02x, wrote 0x%04x at 0x%02x.\n",
 				addr, data->word, command);
 		} else {
-			data->word = chip->words[command];
+			data->word = *wordp;
 			dev_dbg(&adap->dev,
 				"smbus word data - addr 0x%02x, read  0x%04x at 0x%02x.\n",
 				addr, data->word, command);
@@ -163,6 +216,10 @@ static s32 stub_xfer(struct i2c_adapter
 		break;
 
 	case I2C_SMBUS_I2C_BLOCK_DATA:
+		/*
+		 * We ignore banks here, because banked chips don't use I2C
+		 * block transfers
+		 */
 		len = data->block[0];
 		if (read_write == I2C_SMBUS_WRITE) {
 			for (i = 0; i < len; i++) {
@@ -186,6 +243,10 @@ static s32 stub_xfer(struct i2c_adapter
 		break;
 
 	case I2C_SMBUS_BLOCK_DATA:
+		/*
+		 * We ignore banks here, because chips typically don't use both
+		 * banks and SMBus block transfers
+		 */
 		b = stub_find_block(&adap->dev, chip, command, false);
 		if (read_write == I2C_SMBUS_WRITE) {
 			len = data->block[0];
@@ -262,6 +323,43 @@ static struct i2c_adapter stub_adapter =
 	.name		= "SMBus stub driver",
 };
 
+static int __init i2c_stub_allocate_banks(int i)
+{
+	struct stub_chip *chip = stub_chips + i;
+
+	chip->bank_reg = bank_reg[i];
+	chip->bank_start = bank_start[i];
+	chip->bank_end = bank_end[i];
+	chip->bank_size = bank_end[i] - bank_start[i] + 1;
+
+	/* We assume that all bits in the mask are contiguous */
+	chip->bank_mask = bank_mask[i];
+	while (!(chip->bank_mask & 1)) {
+		chip->bank_shift++;
+		chip->bank_mask >>= 1;
+	}
+
+	chip->bank_words = kzalloc(chip->bank_mask * chip->bank_size *
+				   sizeof(u16), GFP_KERNEL);
+	if (!chip->bank_words)
+		return -ENOMEM;
+
+	pr_debug("i2c-stub: Allocated %u banks of %u words each (registers 0x%02x to 0x%02x)\n",
+		 chip->bank_mask, chip->bank_size, chip->bank_start,
+		 chip->bank_end);
+
+	return 0;
+}
+
+static void i2c_stub_free(void)
+{
+	int i;
+
+	for (i = 0; i < stub_chips_nr; i++)
+		kfree(stub_chips[i].bank_words);
+	kfree(stub_chips);
+}
+
 static int __init i2c_stub_init(void)
 {
 	int i, ret;
@@ -289,19 +387,32 @@ static int __init i2c_stub_init(void)
 		pr_err("i2c-stub: Out of memory\n");
 		return -ENOMEM;
 	}
-	for (i = 0; i < stub_chips_nr; i++)
+	for (i = 0; i < stub_chips_nr; i++) {
 		INIT_LIST_HEAD(&stub_chips[i].smbus_blocks);
 
+		/* Allocate extra memory for banked register ranges */
+		if (bank_mask[i]) {
+			ret = i2c_stub_allocate_banks(i);
+			if (ret)
+				goto fail_free;
+		}
+	}
+
 	ret = i2c_add_adapter(&stub_adapter);
 	if (ret)
-		kfree(stub_chips);
+		goto fail_free;
+
+	return 0;
+
+ fail_free:
+	i2c_stub_free();
 	return ret;
 }
 
 static void __exit i2c_stub_exit(void)
 {
 	i2c_del_adapter(&stub_adapter);
-	kfree(stub_chips);
+	i2c_stub_free();
 }
 
 MODULE_AUTHOR("Mark M. Hoffman <mhoffman-xQSgfq/1h4JiLUuM0BA3LQ@public.gmane.org>");
--- linux-3.16-rc3.orig/Documentation/i2c/i2c-stub	2014-07-10 12:44:33.275888638 +0200
+++ linux-3.16-rc3/Documentation/i2c/i2c-stub	2014-07-10 12:52:34.607411809 +0200
@@ -44,15 +44,18 @@ unsigned long functionality:
 	value 0x1f0000 would only enable the quick, byte and byte data
 	commands.
 
+u8 bank_reg[10]
+u8 bank_mask[10]
+u8 bank_start[10]
+u8 bank_end[10]:
+	Optional bank settings. They tell which bits in which register
+	select the active bank, as well as the range of banked registers.
+
 CAVEATS:
 
 If your target driver polls some byte or word waiting for it to change, the
 stub could lock it up.  Use i2cset to unlock it.
 
-If the hardware for your driver has banked registers (e.g. Winbond sensors
-chips) this module will not work well - although it could be extended to
-support that pretty easily.
-
 If you spam it hard enough, printk can be lossy.  This module really wants
 something like relayfs.
 

-- 
Jean Delvare
SUSE L3 Support
