From: Crane Cai <crane.cai-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] I2C: add new AMD SMBus device ID
Date: Thu, 10 Sep 2009 16:04:27 +0800
Message-ID: <20090910080427.GA10945@crane-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Add new SMBus device ID for SB900

---
Hi Jean,

We follow your point, new patch submitted, please apply.

Thanks,
- Crane
---

Signed-off-by: Crane Cai <crane.cai-5C7GfCeVMHo@public.gmane.org>
---
 drivers/i2c/busses/i2c-piix4.c |    8 +++++---
 include/linux/pci_ids.h        |    1 +
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
index 0249a7d..a75d216 100644
--- a/drivers/i2c/busses/i2c-piix4.c
+++ b/drivers/i2c/busses/i2c-piix4.c
@@ -479,6 +479,7 @@ static struct pci_device_id piix4_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP300_SMBUS) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP400_SMBUS) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_SBX00_SMBUS) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_SB900_SMBUS) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_SERVERWORKS,
 		     PCI_DEVICE_ID_SERVERWORKS_OSB4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_SERVERWORKS,
@@ -499,9 +500,10 @@ static int __devinit piix4_probe(struct pci_dev *dev,
 {
 	int retval;
 
-	if ((dev->vendor == PCI_VENDOR_ID_ATI) &&
-	    (dev->device == PCI_DEVICE_ID_ATI_SBX00_SMBUS) &&
-	    (dev->revision >= 0x40))
+	if ((dev->vendor == PCI_VENDOR_ID_ATI &&
+	     dev->device == PCI_DEVICE_ID_ATI_SBX00_SMBUS &&
+	     dev->revision >= 0x40) ||
+	    dev->vendor == PCI_VENDOR_ID_AMD)
 		/* base address location etc changed in SB800 */
 		retval = piix4_setup_sb800(dev, id);
 	else
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 73b46b6..0786ccd 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -537,6 +537,7 @@
 #define PCI_DEVICE_ID_AMD_8131_BRIDGE	0x7450
 #define PCI_DEVICE_ID_AMD_8131_APIC	0x7451
 #define PCI_DEVICE_ID_AMD_8132_BRIDGE	0x7458
+#define PCI_DEVICE_ID_AMD_SB900_SMBUS	0x780b
 #define PCI_DEVICE_ID_AMD_CS5536_ISA    0x2090
 #define PCI_DEVICE_ID_AMD_CS5536_FLASH  0x2091
 #define PCI_DEVICE_ID_AMD_CS5536_AUDIO  0x2093
-- 
1.6.0.4
