From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH v2] i2c: i801: Add support for Kaby Lake PCH-H
Date: Fri, 23 Sep 2016 11:56:01 +0300
Message-ID: <20160923085601.166121-1-mika.westerberg@linux.intel.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:46342 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933808AbcIWI4F (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 23 Sep 2016 04:56:05 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Jean Delvare <jdelvare@suse.com>
Cc: linux-i2c@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Intel Kaby Lake PCH-H has the same legacy SMBus host controller than Intel
Sunrisepoint PCH. It also has same iTCO watchdog on the bus.

Add Kaby Lake PCH-H PCI ID to the list of supported devices.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
Changes from v1:
  * Call it Kaby Lake PCH-H instead of Kabypoint
  * Add the device to the list of supported devices in comment on top of
    the file.

 drivers/i2c/busses/i2c-i801.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index 5ef9b733d153..4785e102e31c 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -64,6 +64,7 @@
  * Broxton (SOC)		0x5ad4	32	hard	yes	yes	yes
  * Lewisburg (PCH)		0xa1a3	32	hard	yes	yes	yes
  * Lewisburg Supersku (PCH)	0xa223	32	hard	yes	yes	yes
+ * Kaby Lake PCH-H (PCH)	0xa2a3	32	hard	yes	yes	yes
  *
  * Features supported by this driver:
  * Software PEC				no
@@ -226,6 +227,7 @@
 #define PCI_DEVICE_ID_INTEL_SUNRISEPOINT_H_SMBUS	0xa123
 #define PCI_DEVICE_ID_INTEL_LEWISBURG_SMBUS		0xa1a3
 #define PCI_DEVICE_ID_INTEL_LEWISBURG_SSKU_SMBUS	0xa223
+#define PCI_DEVICE_ID_INTEL_KABYLAKE_PCH_H_SMBUS	0xa2a3
 
 struct i801_mux_config {
 	char *gpio_chip;
@@ -1006,6 +1008,7 @@ static const struct pci_device_id i801_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_BROXTON_SMBUS) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_LEWISBURG_SMBUS) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_LEWISBURG_SSKU_SMBUS) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_KABYLAKE_PCH_H_SMBUS) },
 	{ 0, }
 };
 
@@ -1482,6 +1485,7 @@ static int i801_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	case PCI_DEVICE_ID_INTEL_LEWISBURG_SMBUS:
 	case PCI_DEVICE_ID_INTEL_LEWISBURG_SSKU_SMBUS:
 	case PCI_DEVICE_ID_INTEL_DNV_SMBUS:
+	case PCI_DEVICE_ID_INTEL_KABYLAKE_PCH_H_SMBUS:
 		priv->features |= FEATURE_I2C_BLOCK_READ;
 		priv->features |= FEATURE_IRQ;
 		priv->features |= FEATURE_SMBUS_PEC;
-- 
2.9.3
