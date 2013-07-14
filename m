From: Rudolf Marek <r.marek-/xGekIyIa4Ap1Coe8Ar9gA@public.gmane.org>
Subject: Re: [PATCH] i2c: i2c-piix4: Add support for secondary SMBus on AMD
 SB800 and AMD FCH chipsets
Date: Sun, 14 Jul 2013 23:17:26 +0200
Message-ID: <51E31566.2070509@assembler.cz>
References: <5196B32D.7060501@assembler.cz> <1369294522.12648.11.camel@mattotaupa> <20130611193539.GG3376@katana> <51B77EC0.2020204@assembler.cz> <20130617071615.GB2957@katana> <51BF8184.8090807@assembler.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040607050603070907050006"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <51BF8184.8090807-/xGekIyIa4Ap1Coe8Ar9gA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Paul Menzel <paulepanter-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

This is a multi-part message in MIME format.
--------------040607050603070907050006
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

From: Rudolf Marek <r.marek-/xGekIyIa4Ap1Coe8Ar9gA@public.gmane.org>

Add support for the secondary SMBus controller on the AMD SB800 and AMD FCH 
chipsets.

Signed-off-by: Rudolf Marek <r.marek-/xGekIyIa4Ap1Coe8Ar9gA@public.gmane.org>

---

Thanks
Rudolf

--------------040607050603070907050006
Content-Type: text/x-diff;
 name="i2c-piix4.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="i2c-piix4.patch"

Index: linux-3.10-rc6/drivers/i2c/busses/i2c-piix4.c
===================================================================
--- linux-3.10-rc6.orig/drivers/i2c/busses/i2c-piix4.c	2013-06-15 23:51:07.000000000 +0200
+++ linux-3.10-rc6/drivers/i2c/busses/i2c-piix4.c	2013-06-17 23:30:48.198871798 +0200
@@ -231,11 +231,11 @@
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
@@ -245,6 +245,8 @@
 	}
 
 	/* Determine the address of the SMBus areas */
+	smb_en = (aux) ? 0x28 : 0x2c;
+
 	if (!request_region(smba_idx, 2, "smba_idx")) {
 		dev_err(&PIIX4_dev->dev, "SMBus base address index region "
 			"0x%x already in use!\n", smba_idx);
@@ -272,6 +274,13 @@
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
@@ -596,7 +605,7 @@
 	     dev->revision >= 0x40) ||
 	    dev->vendor == PCI_VENDOR_ID_AMD)
 		/* base address location etc changed in SB800 */
-		retval = piix4_setup_sb800(dev, id);
+		retval = piix4_setup_sb800(dev, id, 0);
 	else
 		retval = piix4_setup(dev, id);
 
@@ -610,17 +619,29 @@
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
 
Index: linux-3.10-rc6/Documentation/i2c/busses/i2c-piix4
===================================================================
--- linux-3.10-rc6.orig/Documentation/i2c/busses/i2c-piix4	2013-06-15 23:51:07.000000000 +0200
+++ linux-3.10-rc6/Documentation/i2c/busses/i2c-piix4	2013-06-17 23:33:23.024925371 +0200
@@ -73,9 +73,10 @@
 The ServerWorks Southbridges, the Intel 440MX, and the Victory66 are
 identical to the PIIX4 in I2C/SMBus support.
 
-The AMD SB700 and SP5100 chipsets implement two PIIX4-compatible SMBus
-controllers. If your BIOS initializes the secondary controller, it will
-be detected by this driver as an "Auxiliary SMBus Host Controller".
+The AMD SB700, SB800, SP5100 and Hudson-2 chipsets implement two
+PIIX4-compatible SMBus controllers. If your BIOS initializes the
+secondary controller, it will be detected by this driver as
+an "Auxiliary SMBus Host Controller".
 
 If you own Force CPCI735 motherboard or other OSB4 based systems you may need
 to change the SMBus Interrupt Select register so the SMBus controller uses

--------------040607050603070907050006--
