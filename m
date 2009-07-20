From: Crane Cai <crane.cai@amd.com>
Subject: [PATCH] I2C: Add support for new AMD SMBus devices
Date: Mon, 20 Jul 2009 15:31:12 +0800
Message-ID: <20090720073112.GA18219@crane-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752773AbZGTHbj@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: khali@linux-fr.org
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Use driver to detect SMBus devices with Vendor ID AMD and class code is SMBus.

Signed-off-by: Crane Cai <crane.cai@amd.com>
---
 drivers/i2c/busses/i2c-piix4.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
index 0249a7d..034f388 100644
--- a/drivers/i2c/busses/i2c-piix4.c
+++ b/drivers/i2c/busses/i2c-piix4.c
@@ -479,6 +479,10 @@ static struct pci_device_id piix4_ids[] = {
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
@@ -499,9 +503,10 @@ static int __devinit piix4_probe(struct pci_dev *dev,
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
