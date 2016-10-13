From: Carlos Palminha <CARLOS.PALMINHA@synopsys.com>
Subject: [PATCH v2] i2c: i2c-piix4: several coding style fixes
Date: Thu, 13 Oct 2016 23:39:01 +0100
Message-ID: <20161013223901.16460-1-palminha@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:43434 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756831AbcJMWoz (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 13 Oct 2016 18:44:55 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Carlos Palminha <CARLOS.PALMINHA@synopsys.com>

Fixed several coding style issues:
 - '*' adjacent to data name
 - assignment in if condition
 - long comments blocks
 - spaces with open parenthesis
 - quoted string split across lines

Signed-off-by: Carlos Palminha <palminha@synopsys.com>
---
v1->v2:
- sent as one single patch
- fixed extra space in comment block
- fixed quoted string that was not coalesced into a single line

 drivers/i2c/busses/i2c-piix4.c | 145 +++++++++++++++++++++++------------------
 1 file changed, 82 insertions(+), 63 deletions(-)

diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
index c2268cd..c2fef45 100644
--- a/drivers/i2c/busses/i2c-piix4.c
+++ b/drivers/i2c/busses/i2c-piix4.c
@@ -1,32 +1,32 @@
 /*
-    Copyright (c) 1998 - 2002 Frodo Looijaard <frodol@dds.nl> and
-    Philip Edelbrock <phil@netroedge.com>
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
-*/
+ *  Copyright (c) 1998 - 2002 Frodo Looijaard <frodol@dds.nl> and
+ *  Philip Edelbrock <phil@netroedge.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ */
 
 /*
-   Supports:
-	Intel PIIX4, 440MX
-	Serverworks OSB4, CSB5, CSB6, HT-1000, HT-1100
-	ATI IXP200, IXP300, IXP400, SB600, SB700/SP5100, SB800
-	AMD Hudson-2, ML, CZ
-	SMSC Victory66
-
-   Note: we assume there can only be one device, with one or more
-   SMBus interfaces.
-   The device can register multiple i2c_adapters (up to PIIX4_MAX_ADAPTERS).
-   For devices supporting multiple ports the i2c_adapter should provide
-   an i2c_algorithm to access them.
-*/
+ * Supports:
+ *	Intel PIIX4, 440MX
+ *	Serverworks OSB4, CSB5, CSB6, HT-1000, HT-1100
+ *	ATI IXP200, IXP300, IXP400, SB600, SB700/SP5100, SB800
+ *	AMD Hudson-2, ML, CZ
+ *	SMSC Victory66
+ *
+ * Note: we assume there can only be one device, with one or more
+ * SMBus interfaces.
+ * The device can register multiple i2c_adapters (up to PIIX4_MAX_ADAPTERS).
+ * For devices supporting multiple ports the i2c_adapter should provide
+ * an i2c_algorithm to access them.
+ */
 
 #include <linux/module.h>
 #include <linux/moduleparam.h>
@@ -97,16 +97,20 @@
 
 /* insmod parameters */
 
-/* If force is set to anything different from 0, we forcibly enable the
-   PIIX4. DANGEROUS! */
+/*
+ * If force is set to anything different from 0, we forcibly enable the
+ * PIIX4. DANGEROUS!
+ */
 static int force;
-module_param (force, int, 0);
+module_param(force, int, 0);
 MODULE_PARM_DESC(force, "Forcibly enable the PIIX4. DANGEROUS!");
 
-/* If force_addr is set to anything different from 0, we forcibly enable
-   the PIIX4 at the given address. VERY DANGEROUS! */
+/*
+ * If force_addr is set to anything different from 0, we forcibly enable
+ * the PIIX4 at the given address. VERY DANGEROUS!
+ */
 static int force_addr;
-module_param (force_addr, int, 0);
+module_param(force_addr, int, 0);
 MODULE_PARM_DESC(force_addr,
 		 "Forcibly enable the PIIX4 at the given address. "
 		 "EXTREMELY DANGEROUS!");
@@ -132,8 +136,10 @@ static const struct dmi_system_id piix4_dmi_blacklist[] = {
 	{ }
 };
 
-/* The IBM entry is in a separate table because we only check it
-   on Intel-based systems */
+/*
+ * The IBM entry is in a separate table because we only check it
+ * on Intel-based systems
+ */
 static const struct dmi_system_id piix4_dmi_ibm[] = {
 	{
 		.ident = "IBM",
@@ -172,8 +178,10 @@ static int piix4_setup(struct pci_dev *PIIX4_dev,
 	    (PIIX4_dev->device == PCI_DEVICE_ID_SERVERWORKS_CSB5))
 		srvrworks_csb5_delay = 1;
 
-	/* On some motherboards, it was reported that accessing the SMBus
-	   caused severe hardware problems */
+	/*
+	 * On some motherboards, it was reported that accessing the SMBus
+	 * caused severe hardware problems
+	 */
 	if (dmi_check_system(piix4_dmi_blacklist)) {
 		dev_err(&PIIX4_dev->dev,
 			"Accessing the SMBus on this system is unsafe!\n");
@@ -196,7 +204,7 @@ static int piix4_setup(struct pci_dev *PIIX4_dev,
 	} else {
 		pci_read_config_word(PIIX4_dev, SMBBA, &piix4_smba);
 		piix4_smba &= 0xfff0;
-		if(piix4_smba == 0) {
+		if (piix4_smba == 0) {
 			dev_err(&PIIX4_dev->dev, "SMBus base address "
 				"uninitialized - upgrade BIOS or use "
 				"force_addr=0xaddr\n");
@@ -215,8 +223,10 @@ static int piix4_setup(struct pci_dev *PIIX4_dev,
 
 	pci_read_config_byte(PIIX4_dev, SMBHSTCFG, &temp);
 
-	/* If force_addr is set, we program the new address here. Just to make
-	   sure, we disable the PIIX4 first. */
+	/*
+	 * If force_addr is set, we program the new address here. Just to make
+	 * sure, we disable the PIIX4 first.
+	 */
 	if (force_addr) {
 		pci_write_config_byte(PIIX4_dev, SMBHSTCFG, temp & 0xfe);
 		pci_write_config_word(PIIX4_dev, SMBBA, piix4_smba);
@@ -250,8 +260,8 @@ static int piix4_setup(struct pci_dev *PIIX4_dev,
 	else if ((temp & 0x0E) == 0)
 		dev_dbg(&PIIX4_dev->dev, "Using SMI# for SMBus\n");
 	else
-		dev_err(&PIIX4_dev->dev, "Illegal Interrupt configuration "
-			"(or code out of date)!\n");
+		dev_err(&PIIX4_dev->dev,
+			"Illegal Interrupt config (or code out of date)!\n");
 
 	pci_read_config_byte(PIIX4_dev, SMBREV, &temp);
 	dev_info(&PIIX4_dev->dev,
@@ -270,8 +280,8 @@ static int piix4_setup_sb800(struct pci_dev *PIIX4_dev,
 
 	/* SB800 and later SMBus does not support forcing address */
 	if (force || force_addr) {
-		dev_err(&PIIX4_dev->dev, "SMBus does not support "
-			"forcing address!\n");
+		dev_err(&PIIX4_dev->dev,
+			"SMBus does not support forcing address!\n");
 		return -EINVAL;
 	}
 
@@ -328,8 +338,9 @@ static int piix4_setup_sb800(struct pci_dev *PIIX4_dev,
 
 	/* Request the SMBus I2C bus config region */
 	if (!request_region(piix4_smba + i2ccfg_offset, 1, "i2ccfg")) {
-		dev_err(&PIIX4_dev->dev, "SMBus I2C bus config region "
-			"0x%x already in use!\n", piix4_smba + i2ccfg_offset);
+		dev_err(&PIIX4_dev->dev,
+			"SMBus I2C bus config region 0x%x already in use!\n",
+			piix4_smba + i2ccfg_offset);
 		release_region(piix4_smba, SMBIOSIZE);
 		return -EBUSY;
 	}
@@ -369,8 +380,10 @@ static int piix4_setup_aux(struct pci_dev *PIIX4_dev,
 			   const struct pci_device_id *id,
 			   unsigned short base_reg_addr)
 {
-	/* Set up auxiliary SMBus controllers found on some
-	 * AMD chipsets e.g. SP5100 (SB700 derivative) */
+	/*
+	 * Set up auxiliary SMBus controllers found on some
+	 * AMD chipsets e.g. SP5100 (SB700 derivative)
+	 */
 
 	unsigned short piix4_smba;
 
@@ -393,8 +406,9 @@ static int piix4_setup_aux(struct pci_dev *PIIX4_dev,
 		return -ENODEV;
 
 	if (!request_region(piix4_smba, SMBIOSIZE, piix4_driver.name)) {
-		dev_err(&PIIX4_dev->dev, "Auxiliary SMBus region 0x%x "
-			"already in use!\n", piix4_smba);
+		dev_err(&PIIX4_dev->dev,
+			"Auxiliary SMBus region 0x%x already in use!\n",
+			piix4_smba);
 		return -EBUSY;
 	}
 
@@ -419,11 +433,13 @@ static int piix4_transaction(struct i2c_adapter *piix4_adapter)
 		inb_p(SMBHSTDAT1));
 
 	/* Make sure the SMBus host is ready to start transmitting */
-	if ((temp = inb_p(SMBHSTSTS)) != 0x00) {
-		dev_dbg(&piix4_adapter->dev, "SMBus busy (%02x). "
-			"Resetting...\n", temp);
+	temp = inb_p(SMBHSTSTS);
+	if (temp != 0x00) {
+		dev_dbg(&piix4_adapter->dev,
+			"SMBus busy (%02x). Resetting...\n", temp);
 		outb_p(temp, SMBHSTSTS);
-		if ((temp = inb_p(SMBHSTSTS)) != 0x00) {
+		temp = inb_p(SMBHSTSTS);
+		if (temp != 0x00) {
 			dev_err(&piix4_adapter->dev, "Failed! (%02x)\n", temp);
 			return -EBUSY;
 		} else {
@@ -470,9 +486,10 @@ static int piix4_transaction(struct i2c_adapter *piix4_adapter)
 	if (inb_p(SMBHSTSTS) != 0x00)
 		outb_p(inb(SMBHSTSTS), SMBHSTSTS);
 
-	if ((temp = inb_p(SMBHSTSTS)) != 0x00) {
-		dev_err(&piix4_adapter->dev, "Failed reset at end of "
-			"transaction (%02x)\n", temp);
+	temp = inb_p(SMBHSTSTS);
+	if (temp != 0x00) {
+		dev_err(&piix4_adapter->dev,
+			"Failed reset at end of transaction (%02x)\n", temp);
 	}
 	dev_dbg(&piix4_adapter->dev, "Transaction (post): CNT=%02x, CMD=%02x, "
 		"ADD=%02x, DAT0=%02x, DAT1=%02x\n", inb_p(SMBHSTCNT),
@@ -482,9 +499,9 @@ static int piix4_transaction(struct i2c_adapter *piix4_adapter)
 }
 
 /* Return negative errno on error. */
-static s32 piix4_access(struct i2c_adapter * adap, u16 addr,
+static s32 piix4_access(struct i2c_adapter *adap, u16 addr,
 		 unsigned short flags, char read_write,
-		 u8 command, int size, union i2c_smbus_data * data)
+		 u8 command, int size, union i2c_smbus_data *data)
 {
 	struct i2c_piix4_adapdata *adapdata = i2c_get_adapdata(adap);
 	unsigned short piix4_smba = adapdata->smba;
@@ -649,7 +666,7 @@ static const struct pci_device_id piix4_ids[] = {
 	{ 0, }
 };
 
-MODULE_DEVICE_TABLE (pci, piix4_ids);
+MODULE_DEVICE_TABLE(pci, piix4_ids);
 
 static struct i2c_adapter *piix4_main_adapters[PIIX4_MAX_ADAPTERS];
 static struct i2c_adapter *piix4_aux_adapter;
@@ -801,8 +818,10 @@ static int piix4_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	}
 
 	if (retval > 0) {
-		/* Try to add the aux adapter if it exists,
-		 * piix4_add_adapter will clean up if this fails */
+		/*
+		 * Try to add the aux adapter if it exists,
+		 * piix4_add_adapter will clean up if this fails
+		 */
 		piix4_add_adapter(dev, retval, false, 0,
 				  is_sb800 ? piix4_aux_port_name_sb800 : "",
 				  &piix4_aux_adapter);
@@ -853,7 +872,7 @@ static struct pci_driver piix4_driver = {
 
 module_pci_driver(piix4_driver);
 
-MODULE_AUTHOR("Frodo Looijaard <frodol@dds.nl> and "
-		"Philip Edelbrock <phil@netroedge.com>");
+MODULE_AUTHOR("Frodo Looijaard <frodol@dds.nl>");
+MODULE_AUTHOR("Philip Edelbrock <phil@netroedge.com>");
 MODULE_DESCRIPTION("PIIX4 SMBus driver");
 MODULE_LICENSE("GPL");
-- 
2.9.3
