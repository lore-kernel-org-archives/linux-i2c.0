From: Jean Delvare <jdelvare@suse.de>
Subject: [RFC PATCH] i2c: i801: Fix I2C Block Read on 8-Series/C220 and
 later
Date: Mon, 23 May 2016 11:47:40 +0200
Message-ID: <20160523114740.1f8cf29e@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:36339 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751745AbcEWJrn (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 23 May 2016 05:47:43 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linux I2C <linux-i2c@vger.kernel.org>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>

Starting with the 8-Series/C220 PCH (Lynx Point), the SMBus
controller includes a SPD EEPROM protection mechanism. Once the SPD
Write Disable bit is set, only reads are allowed to slave addresses
0x50-0x57.

However the legacy implementation of I2C Block Read since the ICH5
looks like a write, and is therefore blocked by the SPD protection
mechanism. This causes the eeprom and at24 drivers to fail.

So assume that I2C Block Read is implemented as an actual read on
these chipsets. I tested it on my Q87 chipset and it seems to work
just fine.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Wolfram Sang <wsa@the-dreams.de>
---
Jarkko, Mika, that's what I'm using on my machine now. It works, but
obviously I'd prefer to have confirmation from Intel hardware people
that this is the right thing to do before it goes upstream.

 drivers/i2c/busses/i2c-i801.c |   22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

--- linux-4.5.orig/drivers/i2c/busses/i2c-i801.c	2016-05-23 10:39:56.423505663 +0200
+++ linux-4.5/drivers/i2c/busses/i2c-i801.c	2016-05-23 11:25:09.862853791 +0200
@@ -137,9 +137,10 @@
 #define SMBPCICTL_INTDIS	0x0400
 
 /* Host configuration bits for SMBHSTCFG */
-#define SMBHSTCFG_HST_EN	1
-#define SMBHSTCFG_SMB_SMI_EN	2
-#define SMBHSTCFG_I2C_EN	4
+#define SMBHSTCFG_HST_EN	0x01
+#define SMBHSTCFG_SMB_SMI_EN	0x02
+#define SMBHSTCFG_I2C_EN	0x04
+#define SMBHSTCFG_SPD_WD	0x10
 
 /* TCO configuration bits for TCOCTL */
 #define TCOCTL_EN		0x0100
@@ -775,9 +776,16 @@ static s32 i801_access(struct i2c_adapte
 		block = 1;
 		break;
 	case I2C_SMBUS_I2C_BLOCK_DATA:
-		/* NB: page 240 of ICH5 datasheet shows that the R/#W
-		 * bit should be cleared here, even when reading */
-		outb_p((addr & 0x7f) << 1, SMBHSTADD(priv));
+		/*
+		 * NB: page 240 of ICH5 datasheet shows that the R/#W
+		 * bit should be cleared here, even when reading.
+		 * However if SPD Write Disable is set (Lynx Point and later),
+		 * the read will fail if we don't set the R/#W bit.
+		 */
+		outb_p(((addr & 0x7f) << 1) |
+		       ((priv->original_hstcfg & SMBHSTCFG_SPD_WD) ?
+			(read_write & 0x01) : 0),
+		       SMBHSTADD(priv));
 		if (read_write == I2C_SMBUS_READ) {
 			/* NB: page 240 of ICH5 datasheet also shows
 			 * that DATA1 is the cmd field when reading */
@@ -1456,6 +1464,8 @@ static int i801_probe(struct pci_dev *de
 		/* Disable SMBus interrupt feature if SMBus using SMI# */
 		priv->features &= ~FEATURE_IRQ;
 	}
+	if (temp & SMBHSTCFG_SPD_WD)
+		dev_info(&dev->dev, "SPD Write Disable is set\n");
 
 	/* Clear special mode bits */
 	if (priv->features & (FEATURE_SMBUS_PEC | FEATURE_BLOCK_BUFFER))


-- 
Jean Delvare
SUSE L3 Support
