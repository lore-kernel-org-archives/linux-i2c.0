From: Crane Cai <crane.cai-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH v2] I2C: Add support for new AMD SMBus devices
Date: Tue, 11 Aug 2009 09:49:21 +0800
Message-ID: <20090811014921.GB29858@crane-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-kernel-gepDB1WL6pn9qxiX1TGQuw@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

AMD newer SMBus device uses the piix4 driver, and device is added by vendor ID
and class code. This method will include AMD old SMBus controller in, and need
to filter it out.

Signed-off-by: Crane Cai <crane.cai-5C7GfCeVMHo@public.gmane.org>
---
 drivers/i2c/busses/i2c-piix4.c |   17 +++++++++++++++--
 1 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
index 0249a7d..2539282 100644
--- a/drivers/i2c/busses/i2c-piix4.c
+++ b/drivers/i2c/busses/i2c-piix4.c
@@ -232,6 +232,14 @@ static int __devinit piix4_setup_sb800(struct pci_dev *PIIX4_dev,
 	unsigned short smba_idx = 0xcd6;
 	u8 smba_en_lo, smba_en_hi, i2ccfg, i2ccfg_offset = 0x10, smb_en = 0x2c;
 
+	/* Filter AMD old SMBus controller out */
+	if (PIIX4_dev->vendor == PCI_VENDOR_ID_AMD &&
+	    (PIIX4_dev->device <= PCI_DEVICE_ID_AMD_8111_SMBUS &&
+	     PIIX4_dev->device >= PCI_DEVICE_ID_AMD_VIPER_740B)) {
+		dev_info(&PIIX4_dev->dev, "Does not support this chip.\n");
+		return -ENODEV;
+	}
+
 	/* SB800 SMBus does not support forcing address */
 	if (force || force_addr) {
 		dev_err(&PIIX4_dev->dev, "SB800 SMBus does not support "
@@ -479,6 +487,10 @@ static struct pci_device_id piix4_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP300_SMBUS) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP400_SMBUS) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_SBX00_SMBUS) },
+	/* AMD Generic, PCI class code and Vendor ID for SMBus */
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_ANY_ID),
+	  .class = PCI_CLASS_SERIAL_SMBUS << 8,
+	  .class_mask = 0xffffff },
 	{ PCI_DEVICE(PCI_VENDOR_ID_SERVERWORKS,
 		     PCI_DEVICE_ID_SERVERWORKS_OSB4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_SERVERWORKS,
@@ -499,9 +511,10 @@ static int __devinit piix4_probe(struct pci_dev *dev,
 {
 	int retval;
 
-	if ((dev->vendor == PCI_VENDOR_ID_ATI) &&
+	if (((dev->vendor == PCI_VENDOR_ID_ATI) &&
 	    (dev->device == PCI_DEVICE_ID_ATI_SBX00_SMBUS) &&
-	    (dev->revision >= 0x40))
+	    (dev->revision >= 0x40)) ||
+	    dev->vendor == PCI_VENDOR_ID_AMD)
 		/* base address location etc changed in SB800 */
 		retval = piix4_setup_sb800(dev, id);
 	else
-- 
1.6.0.4
