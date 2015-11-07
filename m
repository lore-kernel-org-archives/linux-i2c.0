From: Christian Fetzer <fetzer.ch@gmail.com>
Subject: [PATCH v3 3/5] i2c-piix4: Request base address index region once for SB800
Date: Sat,  7 Nov 2015 12:35:24 +0100
Message-ID: <1446896126-13369-4-git-send-email-fetzer.ch@gmail.com>
References: <1446896126-13369-1-git-send-email-fetzer.ch@gmail.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:34609 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751520AbbKGLfr (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Sat, 7 Nov 2015 06:35:47 -0500
Received: by wmnn186 with SMTP id n186so61259322wmn.1
        for <linux-i2c@vger.kernel.org>; Sat, 07 Nov 2015 03:35:46 -0800 (PST)
In-Reply-To: <1446896126-13369-1-git-send-email-fetzer.ch@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, galandilias@gmail.com, Christian Fetzer <fetzer.ch@gmail.com>

Request the SMBus base address index region once in piix4_probe. This
is particularly useful when using the multiplexed adapter in SB800 as
it avoids requesting and releasing the region on every transfer.

Signed-off-by: Christian Fetzer <fetzer.ch@gmail.com>
---
 drivers/i2c/busses/i2c-piix4.c | 37 ++++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
index 0e4ae60..67ada1e 100644
--- a/drivers/i2c/busses/i2c-piix4.c
+++ b/drivers/i2c/busses/i2c-piix4.c
@@ -78,6 +78,9 @@
 /* Multi-port constants */
 #define PIIX4_MAX_ADAPTERS 4
 
+/* SB800 constants */
+#define SB800_PIIX4_SMB_IDX 0xCD6
+
 /* insmod parameters */
 
 /* If force is set to anything different from 0, we forcibly enable the
@@ -125,6 +128,9 @@ static const struct dmi_system_id piix4_dmi_ibm[] = {
 	{ },
 };
 
+/* SB800 globals */
+static bool piix4_smb_idx_sb800;
+
 struct i2c_piix4_adapdata {
 	unsigned short smba;
 };
@@ -232,7 +238,6 @@ static int piix4_setup_sb800(struct pci_dev *PIIX4_dev,
 			     const struct pci_device_id *id, u8 aux)
 {
 	unsigned short piix4_smba;
-	unsigned short smba_idx = 0xcd6;
 	u8 smba_en_lo, smba_en_hi, smb_en, smb_en_status;
 	u8 i2ccfg, i2ccfg_offset = 0x10;
 
@@ -254,16 +259,10 @@ static int piix4_setup_sb800(struct pci_dev *PIIX4_dev,
 	else
 		smb_en = (aux) ? 0x28 : 0x2c;
 
-	if (!request_region(smba_idx, 2, "smba_idx")) {
-		dev_err(&PIIX4_dev->dev, "SMBus base address index region "
-			"0x%x already in use!\n", smba_idx);
-		return -EBUSY;
-	}
-	outb_p(smb_en, smba_idx);
-	smba_en_lo = inb_p(smba_idx + 1);
-	outb_p(smb_en + 1, smba_idx);
-	smba_en_hi = inb_p(smba_idx + 1);
-	release_region(smba_idx, 2);
+	outb_p(smb_en, SB800_PIIX4_SMB_IDX);
+	smba_en_lo = inb_p(SB800_PIIX4_SMB_IDX + 1);
+	outb_p(smb_en + 1, SB800_PIIX4_SMB_IDX);
+	smba_en_hi = inb_p(SB800_PIIX4_SMB_IDX + 1);
 
 	if (!smb_en) {
 		smb_en_status = smba_en_lo & 0x10;
@@ -621,11 +620,20 @@ static int piix4_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	if ((dev->vendor == PCI_VENDOR_ID_ATI &&
 	     dev->device == PCI_DEVICE_ID_ATI_SBX00_SMBUS &&
 	     dev->revision >= 0x40) ||
-	    dev->vendor == PCI_VENDOR_ID_AMD)
+	    dev->vendor == PCI_VENDOR_ID_AMD) {
+		if (!request_region(SB800_PIIX4_SMB_IDX, 2, "smba_idx")) {
+			dev_err(&dev->dev,
+			"SMBus base address index region 0x%x already in use!\n",
+			SB800_PIIX4_SMB_IDX);
+			return -EBUSY;
+		}
+		piix4_smb_idx_sb800 = true;
+
 		/* base address location etc changed in SB800 */
 		retval = piix4_setup_sb800(dev, id, 0);
-	else
+	} else {
 		retval = piix4_setup(dev, id);
+	}
 
 	/* If no main SMBus found, give up */
 	if (retval < 0)
@@ -692,6 +700,9 @@ static void piix4_remove(struct pci_dev *dev)
 		piix4_adap_remove(piix4_aux_adapter, true);
 		piix4_aux_adapter = NULL;
 	}
+
+	if (piix4_smb_idx_sb800)
+		release_region(SB800_PIIX4_SMB_IDX, 2);
 }
 
 static struct pci_driver piix4_driver = {
-- 
1.9.1
