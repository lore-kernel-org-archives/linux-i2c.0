From: Christian Fetzer <fetzer.ch@gmail.com>
Subject: [PATCH v2 3/5] i2c-piix4: Request base address index region once for SB800
Date: Sun,  1 Nov 2015 17:32:07 +0100
Message-ID: <1446395529-9987-4-git-send-email-fetzer.ch@gmail.com>
References: <1446395529-9987-1-git-send-email-fetzer.ch@gmail.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:34702 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752015AbbKAQc6 (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Sun, 1 Nov 2015 11:32:58 -0500
Received: by wikq8 with SMTP id q8so37835355wik.1
        for <linux-i2c@vger.kernel.org>; Sun, 01 Nov 2015 08:32:57 -0800 (PST)
In-Reply-To: <1446395529-9987-1-git-send-email-fetzer.ch@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, galandilias@gmail.com, Christian Fetzer <fetzer.ch@gmail.com>

Request the SMBus base address index region once in piix4_probe. This
is particularly useful when using the multiplexed adapter in SB800 as
it avoids requesting and releasing the region on every transfer.

Signed-off-by: Christian Fetzer <fetzer.ch@gmail.com>
---
 drivers/i2c/busses/i2c-piix4.c | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
index 35eeb0d..d866b58 100644
--- a/drivers/i2c/busses/i2c-piix4.c
+++ b/drivers/i2c/busses/i2c-piix4.c
@@ -125,6 +125,9 @@ static const struct dmi_system_id piix4_dmi_ibm[] = {
 	{ },
 };
 
+/* SB800 globals */
+static unsigned short piix4_smb_idx_sb800;
+
 struct i2c_piix4_adapdata {
 	unsigned short smba;
 };
@@ -232,7 +235,6 @@ static int piix4_setup_sb800(struct pci_dev *PIIX4_dev,
 			     const struct pci_device_id *id, u8 aux)
 {
 	unsigned short piix4_smba;
-	unsigned short smba_idx = 0xcd6;
 	u8 smba_en_lo, smba_en_hi, smb_en, smb_en_status;
 	u8 i2ccfg, i2ccfg_offset = 0x10;
 
@@ -254,16 +256,10 @@ static int piix4_setup_sb800(struct pci_dev *PIIX4_dev,
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
+	outb_p(smb_en, piix4_smb_idx_sb800);
+	smba_en_lo = inb_p(piix4_smb_idx_sb800 + 1);
+	outb_p(smb_en + 1, piix4_smb_idx_sb800);
+	smba_en_hi = inb_p(piix4_smb_idx_sb800 + 1);
 
 	if (!smb_en) {
 		smb_en_status = smba_en_lo & 0x10;
@@ -616,16 +612,26 @@ static int piix4_add_adapter(struct pci_dev *dev, unsigned short smba,
 
 static int piix4_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
+	unsigned short smba_idx = 0xcd6;
 	int retval;
 
 	if ((dev->vendor == PCI_VENDOR_ID_ATI &&
 	     dev->device == PCI_DEVICE_ID_ATI_SBX00_SMBUS &&
 	     dev->revision >= 0x40) ||
-	    dev->vendor == PCI_VENDOR_ID_AMD)
+	    dev->vendor == PCI_VENDOR_ID_AMD) {
+
+		if (!request_region(smba_idx, 2, "smba_idx")) {
+			dev_err(&dev->dev, "SMBus base address index region "
+				"0x%x already in use!\n", smba_idx);
+			return -EBUSY;
+		}
+		piix4_smb_idx_sb800 = smba_idx;
+
 		/* base address location etc changed in SB800 */
 		retval = piix4_setup_sb800(dev, id, 0);
-	else
+	} else {
 		retval = piix4_setup(dev, id);
+	}
 
 	/* If no main SMBus found, give up */
 	if (retval < 0)
@@ -692,6 +698,9 @@ static void piix4_remove(struct pci_dev *dev)
 		piix4_adap_remove(piix4_aux_adapter, 1);
 		piix4_aux_adapter = NULL;
 	}
+
+	if (piix4_smb_idx_sb800)
+		release_region(piix4_smb_idx_sb800, 2);
 }
 
 static struct pci_driver piix4_driver = {
-- 
1.9.1
