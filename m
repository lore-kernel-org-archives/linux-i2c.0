From: Carlos Palminha <CARLOS.PALMINHA@synopsys.com>
Subject: [PATCH 5/5] i2c: i2c-piix4: coding style fix - quoted string split across lines
Date: Tue, 11 Oct 2016 18:34:55 +0100
Message-ID: <20161011173455.7803-1-palminha@synopsys.com>
References: <20161011172441.7422-1-palminha@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:41098 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753336AbcJKRnn (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 11 Oct 2016 13:43:43 -0400
In-Reply-To: <20161011172441.7422-1-palminha@synopsys.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jdelvare@suse.com, wsa@the-dreams.de, CARLOS.PALMINHA@synopsys.com

Signed-off-by: Carlos Palminha <palminha@synopsys.com>
---
 drivers/i2c/busses/i2c-piix4.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
index 5cc460a..235a406 100644
--- a/drivers/i2c/busses/i2c-piix4.c
+++ b/drivers/i2c/busses/i2c-piix4.c
@@ -260,7 +260,8 @@ static int piix4_setup(struct pci_dev *PIIX4_dev,
 	else if ((temp & 0x0E) == 0)
 		dev_dbg(&PIIX4_dev->dev, "Using SMI# for SMBus\n");
 	else
-		dev_err(&PIIX4_dev->dev, "Illegal Interrupt configuration "
+		dev_err(&PIIX4_dev->dev,
+			"Illegal Interrupt configuration "
 			"(or code out of date)!\n");
 
 	pci_read_config_byte(PIIX4_dev, SMBREV, &temp);
@@ -280,8 +281,8 @@ static int piix4_setup_sb800(struct pci_dev *PIIX4_dev,
 
 	/* SB800 and later SMBus does not support forcing address */
 	if (force || force_addr) {
-		dev_err(&PIIX4_dev->dev, "SMBus does not support "
-			"forcing address!\n");
+		dev_err(&PIIX4_dev->dev,
+			"SMBus does not support forcing address!\n");
 		return -EINVAL;
 	}
 
@@ -338,8 +339,9 @@ static int piix4_setup_sb800(struct pci_dev *PIIX4_dev,
 
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
@@ -405,8 +407,9 @@ static int piix4_setup_aux(struct pci_dev *PIIX4_dev,
 		return -ENODEV;
 
 	if (!request_region(piix4_smba, SMBIOSIZE, piix4_driver.name)) {
-		dev_err(&PIIX4_dev->dev, "Auxiliary SMBus region 0x%x "
-			"already in use!\n", piix4_smba);
+		dev_err(&PIIX4_dev->dev,
+			"Auxiliary SMBus region 0x%x already in use!\n",
+			piix4_smba);
 		return -EBUSY;
 	}
 
@@ -433,8 +436,8 @@ static int piix4_transaction(struct i2c_adapter *piix4_adapter)
 	/* Make sure the SMBus host is ready to start transmitting */
 	temp = inb_p(SMBHSTSTS);
 	if (temp != 0x00) {
-		dev_dbg(&piix4_adapter->dev, "SMBus busy (%02x). "
-			"Resetting...\n", temp);
+		dev_dbg(&piix4_adapter->dev,
+			"SMBus busy (%02x). Resetting...\n", temp);
 		outb_p(temp, SMBHSTSTS);
 		temp = inb_p(SMBHSTSTS);
 		if (temp != 0x00) {
@@ -486,8 +489,8 @@ static int piix4_transaction(struct i2c_adapter *piix4_adapter)
 
 	temp = inb_p(SMBHSTSTS);
 	if (temp != 0x00) {
-		dev_err(&piix4_adapter->dev, "Failed reset at end of "
-			"transaction (%02x)\n", temp);
+		dev_err(&piix4_adapter->dev,
+			"Failed reset at end of transaction (%02x)\n", temp);
 	}
 	dev_dbg(&piix4_adapter->dev, "Transaction (post): CNT=%02x, CMD=%02x, "
 		"ADD=%02x, DAT0=%02x, DAT1=%02x\n", inb_p(SMBHSTCNT),
@@ -870,7 +873,7 @@ static struct pci_driver piix4_driver = {
 
 module_pci_driver(piix4_driver);
 
-MODULE_AUTHOR("Frodo Looijaard <frodol@dds.nl> and "
-		"Philip Edelbrock <phil@netroedge.com>");
+MODULE_AUTHOR("Frodo Looijaard <frodol@dds.nl>");
+MODULE_AUTHOR("Philip Edelbrock <phil@netroedge.com>");
 MODULE_DESCRIPTION("PIIX4 SMBus driver");
 MODULE_LICENSE("GPL");
-- 
2.9.3
