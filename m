From: Rudolf Marek <r.marek-/xGekIyIa4Ap1Coe8Ar9gA@public.gmane.org>
Subject: [PATCH] i2c-piix4 - Add support for secondary SMBus on AMD SB800
 and AMD FCH chipsets
Date: Sat, 18 May 2013 00:46:05 +0200
Message-ID: <5196B32D.7060501@assembler.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090507070400060507090307"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Paul Menzel <paulepanter-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

This is a multi-part message in MIME format.
--------------090507070400060507090307
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello all,

Attached patch adds support for secondary SMBus of AMD SB800 and new AMD FCH 
chipsets. The base address of secondary SMBus is different from SB700 and it is 
stored on similar place as SB800 primary SMBus.

More verbose info:

Probing function was just modified to read the SMBus base from address 0x28 or 
from original 0x2c. The secondary bus does not provide IRQ information.

I think the SB700 has same secondary controller, so revision/IRQ information 
should not be printed too. This can be fixed in some other patch.

Chipset datasheet can be found here: 
http://support.amd.com/us/Embedded_TechDocs/45482.pdf

Tested on SB800 and FCH boards.

Tested-by: Paul Menzel <paulepanter-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
ASRock E350M1 with SB800

Signed-off-by: Rudolf Marek <r.marek-/xGekIyIa4Ap1Coe8Ar9gA@public.gmane.org>

Thanks
Rudolf

--------------090507070400060507090307
Content-Type: text/x-diff;
 name="i2c-piix4.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="i2c-piix4.patch"

diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
index 39ab78c..7145d3c 100644
--- a/drivers/i2c/busses/i2c-piix4.c
+++ b/drivers/i2c/busses/i2c-piix4.c
@@ -231,11 +231,11 @@ static int piix4_setup(struct pci_dev *PIIX4_dev,
 }
 
 static int piix4_setup_sb800(struct pci_dev *PIIX4_dev,
-			     const struct pci_device_id *id)
+			     const struct pci_device_id *id, u8 aux)
 {
 	unsigned short piix4_smba;
 	unsigned short smba_idx = 0xcd6;
-	u8 smba_en_lo, smba_en_hi, i2ccfg, i2ccfg_offset = 0x10, smb_en = 0x2c;
+	u8 smba_en_lo, smba_en_hi, i2ccfg, i2ccfg_offset = 0x10, smb_en;
 
 	/* SB800 and later SMBus does not support forcing address */
 	if (force || force_addr) {
@@ -245,6 +245,8 @@ static int piix4_setup_sb800(struct pci_dev *PIIX4_dev,
 	}
 
 	/* Determine the address of the SMBus areas */
+	smb_en = (aux) ? 0x28 : 0x2c;
+
 	if (!request_region(smba_idx, 2, "smba_idx")) {
 		dev_err(&PIIX4_dev->dev, "SMBus base address index region "
 			"0x%x already in use!\n", smba_idx);
@@ -272,6 +274,13 @@ static int piix4_setup_sb800(struct pci_dev *PIIX4_dev,
 		return -EBUSY;
 	}
 
+	/* Aux SMBus does not support IRQ information */
+	if (aux) {
+		dev_info(&PIIX4_dev->dev,
+			 "SMBus Host Controller at 0x%x\n", piix4_smba);
+		return piix4_smba;
+	}
+
 	/* Request the SMBus I2C bus config region */
 	if (!request_region(piix4_smba + i2ccfg_offset, 1, "i2ccfg")) {
 		dev_err(&PIIX4_dev->dev, "SMBus I2C bus config region "
@@ -596,7 +605,7 @@ static int piix4_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	     dev->revision >= 0x40) ||
 	    dev->vendor == PCI_VENDOR_ID_AMD)
 		/* base address location etc changed in SB800 */
-		retval = piix4_setup_sb800(dev, id);
+		retval = piix4_setup_sb800(dev, id, 0);
 	else
 		retval = piix4_setup(dev, id);
 
@@ -610,17 +619,29 @@ static int piix4_probe(struct pci_dev *dev, const struct pci_device_id *id)
 		return retval;
 
 	/* Check for auxiliary SMBus on some AMD chipsets */
+	retval = -ENODEV;
+
 	if (dev->vendor == PCI_VENDOR_ID_ATI &&
-	    dev->device == PCI_DEVICE_ID_ATI_SBX00_SMBUS &&
-	    dev->revision < 0x40) {
-		retval = piix4_setup_aux(dev, id, 0x58);
-		if (retval > 0) {
-			/* Try to add the aux adapter if it exists,
-			 * piix4_add_adapter will clean up if this fails */
-			piix4_add_adapter(dev, retval, &piix4_aux_adapter);
+	    dev->device == PCI_DEVICE_ID_ATI_SBX00_SMBUS) {
+		if (dev->revision < 0x40) {
+			retval = piix4_setup_aux(dev, id, 0x58);
+		} else {
+			/* SB800 added aux bus too */
+			retval = piix4_setup_sb800(dev, id, 1);
 		}
 	}
 
+	if (dev->vendor == PCI_VENDOR_ID_AMD &&
+	    dev->device == PCI_DEVICE_ID_AMD_HUDSON2_SMBUS) {
+		retval = piix4_setup_sb800(dev, id, 1);
+	}
+
+	if (retval > 0) {
+		/* Try to add the aux adapter if it exists,
+		 * piix4_add_adapter will clean up if this fails */
+		piix4_add_adapter(dev, retval, &piix4_aux_adapter);
+	}
+
 	return 0;
 }
 

--------------090507070400060507090307--
