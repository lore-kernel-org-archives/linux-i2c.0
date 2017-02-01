From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH v2] i2c: i801: Add support for Intel Gemini Lake
Date: Wed,  1 Feb 2017 19:20:59 +0300
Message-ID: <20170201162059.81911-1-mika.westerberg@linux.intel.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:11726 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750945AbdBAQVD (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 1 Feb 2017 11:21:03 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org

Intel Gemini Lake has the same SMBus host controller than Intel Broxton.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Jean Delvare <jdelvare@suse.de>
---
Changes from the previous version:
  * Updated documentation and Kconfig
  * Added Jean's SoB

 Documentation/i2c/busses/i2c-i801 | 1 +
 drivers/i2c/busses/Kconfig        | 1 +
 drivers/i2c/busses/i2c-i801.c     | 3 +++
 3 files changed, 5 insertions(+)

diff --git a/Documentation/i2c/busses/i2c-i801 b/Documentation/i2c/busses/i2c-i801
index 1bba38dd2637..820d9040de16 100644
--- a/Documentation/i2c/busses/i2c-i801
+++ b/Documentation/i2c/busses/i2c-i801
@@ -33,6 +33,7 @@ Supported adapters:
   * Intel DNV (SOC)
   * Intel Broxton (SOC)
   * Intel Lewisburg (PCH)
+  * Intel Gemini Lake (SOC)
    Datasheets: Publicly available at the Intel website
 
 On Intel Patsburg and later chipsets, both the normal host SMBus controller
diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 0cdc8443deab..f2dea4e8edb2 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -128,6 +128,7 @@ config I2C_I801
 	    DNV (SOC)
 	    Broxton (SOC)
 	    Lewisburg (PCH)
+	    Gemini Lake (SOC)
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-i801.
diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index e242db43774b..6484fa6dbb84 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -65,6 +65,7 @@
  * Lewisburg (PCH)		0xa1a3	32	hard	yes	yes	yes
  * Lewisburg Supersku (PCH)	0xa223	32	hard	yes	yes	yes
  * Kaby Lake PCH-H (PCH)	0xa2a3	32	hard	yes	yes	yes
+ * Gemini Lake (SOC)		0x31d4	32	hard	yes	yes	yes
  *
  * Features supported by this driver:
  * Software PEC				no
@@ -213,6 +214,7 @@
 #define PCI_DEVICE_ID_INTEL_BRASWELL_SMBUS		0x2292
 #define PCI_DEVICE_ID_INTEL_DH89XXCC_SMBUS		0x2330
 #define PCI_DEVICE_ID_INTEL_COLETOCREEK_SMBUS		0x23b0
+#define PCI_DEVICE_ID_INTEL_GEMINILAKE_SMBUS		0x31d4
 #define PCI_DEVICE_ID_INTEL_5_3400_SERIES_SMBUS		0x3b30
 #define PCI_DEVICE_ID_INTEL_BROXTON_SMBUS		0x5ad4
 #define PCI_DEVICE_ID_INTEL_LYNXPOINT_SMBUS		0x8c22
@@ -1012,6 +1014,7 @@ static const struct pci_device_id i801_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_WELLSBURG_SMBUS_MS1) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_WELLSBURG_SMBUS_MS2) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_COLETOCREEK_SMBUS) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_GEMINILAKE_SMBUS) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_WILDCATPOINT_SMBUS) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_WILDCATPOINT_LP_SMBUS) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_BAYTRAIL_SMBUS) },
-- 
2.11.0
