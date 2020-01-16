From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH] i2c: i801: Add support for Intel Comet Lake PCH-V
Date: Thu, 16 Jan 2020 09:46:51 +0200
Message-ID: <20200116074651.529380-1-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga18.intel.com ([134.134.136.126]:2791 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726827AbgAPHq5 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 16 Jan 2020 02:46:57 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>

Add support for Intel Comet Lake PCH-V which is based on Intel Kaby
Lake. Difference between it and other Comet Lake variants is that former
uses previous iTCO version 4 and latter use version 6 like Intel Cannon
Lake PCH.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 drivers/i2c/busses/i2c-i801.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index 44db3a91d32d..ca4f096fef74 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -68,6 +68,7 @@
  * Elkhart Lake (PCH)		0x4b23	32	hard	yes	yes	yes
  * Tiger Lake-LP (PCH)		0xa0a3	32	hard	yes	yes	yes
  * Jasper Lake (SOC)		0x4da3	32	hard	yes	yes	yes
+ * Comet Lake-V (PCH)		0xa3a3	32	hard	yes	yes	yes
  *
  * Features supported by this driver:
  * Software PEC				no
@@ -244,6 +245,7 @@
 #define PCI_DEVICE_ID_INTEL_LEWISBURG_SSKU_SMBUS	0xa223
 #define PCI_DEVICE_ID_INTEL_KABYLAKE_PCH_H_SMBUS	0xa2a3
 #define PCI_DEVICE_ID_INTEL_CANNONLAKE_H_SMBUS		0xa323
+#define PCI_DEVICE_ID_INTEL_COMETLAKE_V_SMBUS		0xa3a3
 
 struct i801_mux_config {
 	char *gpio_chip;
@@ -1074,6 +1076,7 @@ static const struct pci_device_id i801_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICELAKE_LP_SMBUS) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_COMETLAKE_SMBUS) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_COMETLAKE_H_SMBUS) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_COMETLAKE_V_SMBUS) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ELKHART_LAKE_SMBUS) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_TIGERLAKE_LP_SMBUS) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_JASPER_LAKE_SMBUS) },
@@ -1742,6 +1745,7 @@ static int i801_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	case PCI_DEVICE_ID_INTEL_LEWISBURG_SSKU_SMBUS:
 	case PCI_DEVICE_ID_INTEL_DNV_SMBUS:
 	case PCI_DEVICE_ID_INTEL_KABYLAKE_PCH_H_SMBUS:
+	case PCI_DEVICE_ID_INTEL_COMETLAKE_V_SMBUS:
 		priv->features |= FEATURE_BLOCK_PROC;
 		priv->features |= FEATURE_I2C_BLOCK_READ;
 		priv->features |= FEATURE_IRQ;
-- 
2.24.1
