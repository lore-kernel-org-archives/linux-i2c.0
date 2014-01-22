From: Shane Huang <shane.huang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 1/2] i2c-piix4: Add support for AMD ML and CZ SMBus changes
Date: Wed, 22 Jan 2014 14:05:46 -0800
Message-ID: <1390428346-2235-1-git-send-email-shane.huang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Carl Peng <carl.peng-5C7GfCeVMHo@public.gmane.org>, Shane Huang <shane.huang-5C7GfCeVMHo@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The locations of SMBus register base address and enablement bit are changed
from AMD ML, which need this patch to be supported.

Signed-off-by: Shane Huang <shane.huang-5C7GfCeVMHo@public.gmane.org>
---
 Documentation/i2c/busses/i2c-piix4 |    2 +-
 drivers/i2c/busses/Kconfig         |    1 +
 drivers/i2c/busses/i2c-piix4.c     |   28 +++++++++++++++++++++++-----
 3 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/Documentation/i2c/busses/i2c-piix4 b/Documentation/i2c/busses/i2c-piix4
index c097e0f..aa959fd 100644
--- a/Documentation/i2c/busses/i2c-piix4
+++ b/Documentation/i2c/busses/i2c-piix4
@@ -13,7 +13,7 @@ Supported adapters:
   * AMD SP5100 (SB700 derivative found on some server mainboards)
     Datasheet: Publicly available at the AMD website
     http://support.amd.com/us/Embedded_TechDocs/44413.pdf
-  * AMD Hudson-2, CZ
+  * AMD Hudson-2, ML, CZ
     Datasheet: Not publicly available
   * Standard Microsystems (SMSC) SLC90E66 (Victory66) southbridge
     Datasheet: Publicly available at the SMSC website http://www.smsc.com
diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 6bcdea5..f5ed031 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -152,6 +152,7 @@ config I2C_PIIX4
 	    ATI SB700/SP5100
 	    ATI SB800
 	    AMD Hudson-2
+	    AMD ML
 	    AMD CZ
 	    Serverworks OSB4
 	    Serverworks CSB5
diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
index a028617..f71b4d3 100644
--- a/drivers/i2c/busses/i2c-piix4.c
+++ b/drivers/i2c/busses/i2c-piix4.c
@@ -22,7 +22,7 @@
 	Intel PIIX4, 440MX
 	Serverworks OSB4, CSB5, CSB6, HT-1000, HT-1100
 	ATI IXP200, IXP300, IXP400, SB600, SB700/SP5100, SB800
-	AMD Hudson-2, CZ
+	AMD Hudson-2, ML, CZ
 	SMSC Victory66
 
    Note: we assume there can only be one device, with one or more
@@ -235,7 +235,8 @@ static int piix4_setup_sb800(struct pci_dev *PIIX4_dev,
 {
 	unsigned short piix4_smba;
 	unsigned short smba_idx = 0xcd6;
-	u8 smba_en_lo, smba_en_hi, i2ccfg, i2ccfg_offset = 0x10, smb_en;
+	u8 smba_en_lo, smba_en_hi, smb_en, smb_en_status;
+	u8 i2ccfg, i2ccfg_offset = 0x10;
 
 	/* SB800 and later SMBus does not support forcing address */
 	if (force || force_addr) {
@@ -245,7 +246,15 @@ static int piix4_setup_sb800(struct pci_dev *PIIX4_dev,
 	}
 
 	/* Determine the address of the SMBus areas */
-	smb_en = (aux) ? 0x28 : 0x2c;
+	if ((PIIX4_dev->vendor == PCI_VENDOR_ID_AMD &&
+	     PIIX4_dev->device == PCI_DEVICE_ID_AMD_HUDSON2_SMBUS &&
+	     PIIX4_dev->revision >= 0x41) ||
+	    (PIIX4_dev->vendor == PCI_VENDOR_ID_AMD &&
+	     PIIX4_dev->device == 0x790b &&
+	     PIIX4_dev->revision >= 0x49))
+		smb_en = 0x00;
+	else
+		smb_en = (aux) ? 0x28 : 0x2c;
 
 	if (!request_region(smba_idx, 2, "smba_idx")) {
 		dev_err(&PIIX4_dev->dev, "SMBus base address index region "
@@ -258,13 +267,22 @@ static int piix4_setup_sb800(struct pci_dev *PIIX4_dev,
 	smba_en_hi = inb_p(smba_idx + 1);
 	release_region(smba_idx, 2);
 
-	if ((smba_en_lo & 1) == 0) {
+	if (!smb_en) {
+		smb_en_status = smba_en_lo & 0x10;
+		piix4_smba = smba_en_hi << 8;
+		if (aux)
+			piix4_smba |= 0x20;
+	} else {
+		smb_en_status = smba_en_lo & 0x01;
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
 
-- 
1.7.9.5
