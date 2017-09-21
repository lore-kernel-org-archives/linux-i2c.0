From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH] i2c: i801: Add support for Intel Cedar Fork
Date: Thu, 21 Sep 2017 16:23:16 +0300
Message-ID: <20170921132316.20517-1-jarkko.nikula@linux.intel.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:45873 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751618AbdIUNXZ (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 21 Sep 2017 09:23:25 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>

Add PCI ID for Intel Cedar Fork PCH.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 Documentation/i2c/busses/i2c-i801 | 1 +
 drivers/i2c/busses/Kconfig        | 1 +
 drivers/i2c/busses/i2c-i801.c     | 4 ++++
 3 files changed, 6 insertions(+)

diff --git a/Documentation/i2c/busses/i2c-i801 b/Documentation/i2c/busses/i2c-i801
index 0500193434cb..d47702456926 100644
--- a/Documentation/i2c/busses/i2c-i801
+++ b/Documentation/i2c/busses/i2c-i801
@@ -36,6 +36,7 @@ Supported adapters:
   * Intel Gemini Lake (SOC)
   * Intel Cannon Lake-H (PCH)
   * Intel Cannon Lake-LP (PCH)
+  * Intel Cedar Fork (PCH)
    Datasheets: Publicly available at the Intel website
 
 On Intel Patsburg and later chipsets, both the normal host SMBus controller
diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index c06dce2c1da7..45a3f3ca29b3 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -131,6 +131,7 @@ config I2C_I801
 	    Gemini Lake (SOC)
 	    Cannon Lake-H (PCH)
 	    Cannon Lake-LP (PCH)
+	    Cedar Fork (PCH)
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-i801.
diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index e114e4e00d29..9e12a53ef7b8 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -68,6 +68,7 @@
  * Gemini Lake (SOC)		0x31d4	32	hard	yes	yes	yes
  * Cannon Lake-H (PCH)		0xa323	32	hard	yes	yes	yes
  * Cannon Lake-LP (PCH)		0x9da3	32	hard	yes	yes	yes
+ * Cedar Fork (PCH)		0x18df	32	hard	yes	yes	yes
  *
  * Features supported by this driver:
  * Software PEC				no
@@ -204,6 +205,7 @@
 
 /* Older devices have their ID defined in <linux/pci_ids.h> */
 #define PCI_DEVICE_ID_INTEL_BAYTRAIL_SMBUS		0x0f12
+#define PCI_DEVICE_ID_INTEL_CDF_SMBUS			0x18df
 #define PCI_DEVICE_ID_INTEL_DNV_SMBUS			0x19df
 #define PCI_DEVICE_ID_INTEL_COUGARPOINT_SMBUS		0x1c22
 #define PCI_DEVICE_ID_INTEL_PATSBURG_SMBUS		0x1d22
@@ -1025,6 +1027,7 @@ static const struct pci_device_id i801_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_BRASWELL_SMBUS) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_SUNRISEPOINT_H_SMBUS) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_SUNRISEPOINT_LP_SMBUS) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CDF_SMBUS) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_DNV_SMBUS) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_BROXTON_SMBUS) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_LEWISBURG_SMBUS) },
@@ -1513,6 +1516,7 @@ static int i801_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	case PCI_DEVICE_ID_INTEL_CANNONLAKE_LP_SMBUS:
 	case PCI_DEVICE_ID_INTEL_LEWISBURG_SMBUS:
 	case PCI_DEVICE_ID_INTEL_LEWISBURG_SSKU_SMBUS:
+	case PCI_DEVICE_ID_INTEL_CDF_SMBUS:
 	case PCI_DEVICE_ID_INTEL_DNV_SMBUS:
 	case PCI_DEVICE_ID_INTEL_KABYLAKE_PCH_H_SMBUS:
 		priv->features |= FEATURE_I2C_BLOCK_READ;
-- 
2.14.1
