From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c-i801: Standardize log messages
Date: Thu, 23 Jan 2014 16:59:38 +0100
Message-ID: <20140123165938.493ea62c@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Shane Huang <shane.huang-5C7GfCeVMHo@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Use exactly the same log messages in the legacy setup function and the
SB800+ setup function. This way strings can be reused, which saves
some bytes in the generated binary.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Shane Huang <shane.huang-5C7GfCeVMHo@public.gmane.org>
---
Inspired by Shane's recent patch, on top of which it applies.

 drivers/i2c/busses/i2c-piix4.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- linux-3.13.orig/drivers/i2c/busses/i2c-piix4.c	2014-01-23 13:35:43.684040390 +0100
+++ linux-3.13/drivers/i2c/busses/i2c-piix4.c	2014-01-23 13:54:55.462751999 +0100
@@ -208,16 +208,16 @@ static int piix4_setup(struct pci_dev *P
 				   "WARNING: SMBus interface has been FORCEFULLY ENABLED!\n");
 		} else {
 			dev_err(&PIIX4_dev->dev,
-				"Host SMBus controller not enabled!\n");
+				"SMBus Host Controller not enabled!\n");
 			release_region(piix4_smba, SMBIOSIZE);
 			return -ENODEV;
 		}
 	}
 
 	if (((temp & 0x0E) == 8) || ((temp & 0x0E) == 2))
-		dev_dbg(&PIIX4_dev->dev, "Using Interrupt 9 for SMBus.\n");
+		dev_dbg(&PIIX4_dev->dev, "Using IRQ for SMBus\n");
 	else if ((temp & 0x0E) == 0)
-		dev_dbg(&PIIX4_dev->dev, "Using Interrupt SMI# for SMBus.\n");
+		dev_dbg(&PIIX4_dev->dev, "Using SMI# for SMBus\n");
 	else
 		dev_err(&PIIX4_dev->dev, "Illegal Interrupt configuration "
 			"(or code out of date)!\n");
@@ -279,7 +279,7 @@ static int piix4_setup_sb800(struct pci_
 
 	if (!smb_en_status) {
 		dev_err(&PIIX4_dev->dev,
-			"Host SMBus controller not enabled!\n");
+			"SMBus Host Controller not enabled!\n");
 		return -ENODEV;
 	}
 
@@ -311,9 +311,9 @@ static int piix4_setup_sb800(struct pci_
 	release_region(piix4_smba + i2ccfg_offset, 1);
 
 	if (i2ccfg & 1)
-		dev_dbg(&PIIX4_dev->dev, "Using IRQ for SMBus.\n");
+		dev_dbg(&PIIX4_dev->dev, "Using IRQ for SMBus\n");
 	else
-		dev_dbg(&PIIX4_dev->dev, "Using SMI# for SMBus.\n");
+		dev_dbg(&PIIX4_dev->dev, "Using SMI# for SMBus\n");
 
 	dev_info(&PIIX4_dev->dev,
 		 "SMBus Host Controller at 0x%x, revision %d\n",


-- 
Jean Delvare
