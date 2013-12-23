From: Shane Huang <shane.huang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] i2c-piix4: AMD new SMBus base address location changed
Date: Mon, 23 Dec 2013 13:58:50 -0800
Message-ID: <1387835930-1828-1-git-send-email-shane.huang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Carl Peng <carl.peng-5C7GfCeVMHo@public.gmane.org>, Shane Huang <shane.huang-5C7GfCeVMHo@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

This patch is to support AMD new SMBus with different base address location.

Signed-off-by: Shane Huang <shane.huang-5C7GfCeVMHo@public.gmane.org>
---
 drivers/i2c/busses/i2c-piix4.c | 39 +++++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
index a028617..44d5ebe 100644
--- a/drivers/i2c/busses/i2c-piix4.c
+++ b/drivers/i2c/busses/i2c-piix4.c
@@ -230,12 +230,13 @@ static int piix4_setup(struct pci_dev *PIIX4_dev,
 	return piix4_smba;
 }
 
-static int piix4_setup_sb800(struct pci_dev *PIIX4_dev,
-			     const struct pci_device_id *id, u8 aux)
+static int piix4_setup_amd(struct pci_dev *PIIX4_dev,
+			   const struct pci_device_id *id, u8 aux)
 {
 	unsigned short piix4_smba;
 	unsigned short smba_idx = 0xcd6;
-	u8 smba_en_lo, smba_en_hi, i2ccfg, i2ccfg_offset = 0x10, smb_en;
+	u8 smba_en_lo, smba_en_hi, smb_en, smb_en_status;
+	u8 i2ccfg, i2ccfg_offset = 0x10;
 
 	/* SB800 and later SMBus does not support forcing address */
 	if (force || force_addr) {
@@ -245,7 +246,11 @@ static int piix4_setup_sb800(struct pci_dev *PIIX4_dev,
 	}
 
 	/* Determine the address of the SMBus areas */
-	smb_en = (aux) ? 0x28 : 0x2c;
+	if (PIIX4_dev->vendor == PCI_VENDOR_ID_AMD &&
+	    PIIX4_dev->revision >= 0x41)
+		smb_en = 0;
+	else
+		smb_en = (aux) ? 0x28 : 0x2c;
 
 	if (!request_region(smba_idx, 2, "smba_idx")) {
 		dev_err(&PIIX4_dev->dev, "SMBus base address index region "
@@ -258,13 +263,23 @@ static int piix4_setup_sb800(struct pci_dev *PIIX4_dev,
 	smba_en_hi = inb_p(smba_idx + 1);
 	release_region(smba_idx, 2);
 
-	if ((smba_en_lo & 1) == 0) {
+	if (PIIX4_dev->vendor == PCI_VENDOR_ID_AMD &&
+	    PIIX4_dev->revision >= 0x41) {
+		smb_en_status = smba_en_lo & 0x10;
+		piix4_smba = smba_en_hi << 8;
+		if (aux)
+			piix4_smba |= 0x20;
+	} else {
+		smb_en_status = smba_en_lo & 1;
+		piix4_smba = ((smba_en_hi << 8) | smba_en_lo) & 0xffe0;
+	}
+
+	if (!smb_en_status) {
 		dev_err(&PIIX4_dev->dev,
 			"Host SMBus controller not enabled!\n");
 		return -ENODEV;
 	}
 
-	piix4_smba = ((smba_en_hi << 8) | smba_en_lo) & 0xffe0;
 	if (acpi_check_region(piix4_smba, SMBIOSIZE, piix4_driver.name))
 		return -ENODEV;
 
@@ -277,7 +292,7 @@ static int piix4_setup_sb800(struct pci_dev *PIIX4_dev,
 	/* Aux SMBus does not support IRQ information */
 	if (aux) {
 		dev_info(&PIIX4_dev->dev,
-			 "SMBus Host Controller at 0x%x\n", piix4_smba);
+			 "Auxiliary SMBus controller at 0x%x\n", piix4_smba);
 		return piix4_smba;
 	}
 
@@ -297,7 +312,7 @@ static int piix4_setup_sb800(struct pci_dev *PIIX4_dev,
 		dev_dbg(&PIIX4_dev->dev, "Using SMI# for SMBus.\n");
 
 	dev_info(&PIIX4_dev->dev,
-		 "SMBus Host Controller at 0x%x, revision %d\n",
+		 "SMBus controller at 0x%x, revision %d\n",
 		 piix4_smba, i2ccfg >> 4);
 
 	return piix4_smba;
@@ -605,8 +620,8 @@ static int piix4_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	     dev->device == PCI_DEVICE_ID_ATI_SBX00_SMBUS &&
 	     dev->revision >= 0x40) ||
 	    dev->vendor == PCI_VENDOR_ID_AMD)
-		/* base address location etc changed in SB800 */
-		retval = piix4_setup_sb800(dev, id, 0);
+		/* base address location etc changed from SB800 */
+		retval = piix4_setup_amd(dev, id, 0);
 	else
 		retval = piix4_setup(dev, id);
 
@@ -628,13 +643,13 @@ static int piix4_probe(struct pci_dev *dev, const struct pci_device_id *id)
 			retval = piix4_setup_aux(dev, id, 0x58);
 		} else {
 			/* SB800 added aux bus too */
-			retval = piix4_setup_sb800(dev, id, 1);
+			retval = piix4_setup_amd(dev, id, 1);
 		}
 	}
 
 	if (dev->vendor == PCI_VENDOR_ID_AMD &&
 	    dev->device == PCI_DEVICE_ID_AMD_HUDSON2_SMBUS) {
-		retval = piix4_setup_sb800(dev, id, 1);
+		retval = piix4_setup_amd(dev, id, 1);
 	}
 
 	if (retval > 0) {
-- 
1.8.3.2
