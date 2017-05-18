From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH] i2c: i801: Add support for Intel Cannon Lake
Date: Thu, 18 May 2017 11:23:06 +0300
Message-ID: <20170518082306.3831-1-jarkko.nikula@linux.intel.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:13620 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753906AbdERIXd (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 18 May 2017 04:23:33 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>

From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Added SMBUS PCI Ids for SMBUS for Cannon Lake PCH.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
[jarkko.nikula@linux.intel.com: Add entries to Documentation and Kconfig.
Cover Cannon Lake-H too]
Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 Documentation/i2c/busses/i2c-i801 | 2 ++
 drivers/i2c/busses/Kconfig        | 2 ++
 drivers/i2c/busses/i2c-i801.c     | 8 ++++++++
 3 files changed, 12 insertions(+)

diff --git a/Documentation/i2c/busses/i2c-i801 b/Documentation/i2c/busses/i2c-i801
index 820d9040de16..0500193434cb 100644
--- a/Documentation/i2c/busses/i2c-i801
+++ b/Documentation/i2c/busses/i2c-i801
@@ -34,6 +34,8 @@ Supported adapters:
   * Intel Broxton (SOC)
   * Intel Lewisburg (PCH)
   * Intel Gemini Lake (SOC)
+  * Intel Cannon Lake-H (PCH)
+  * Intel Cannon Lake-LP (PCH)
    Datasheets: Publicly available at the Intel website
 
 On Intel Patsburg and later chipsets, both the normal host SMBus controller
diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 144cbadc7c72..ed7106e48ba4 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -129,6 +129,8 @@ config I2C_I801
 	    Broxton (SOC)
 	    Lewisburg (PCH)
 	    Gemini Lake (SOC)
+	    Cannon Lake-H (PCH)
+	    Cannon Lake-LP (PCH)
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-i801.
diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index 6484fa6dbb84..c9536e17d6ff 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -66,6 +66,8 @@
  * Lewisburg Supersku (PCH)	0xa223	32	hard	yes	yes	yes
  * Kaby Lake PCH-H (PCH)	0xa2a3	32	hard	yes	yes	yes
  * Gemini Lake (SOC)		0x31d4	32	hard	yes	yes	yes
+ * Cannon Lake-H (PCH)		0xa323	32	hard	yes	yes	yes
+ * Cannon Lake-LP (PCH)		0x9da3	32	hard	yes	yes	yes
  *
  * Features supported by this driver:
  * Software PEC				no
@@ -226,10 +228,12 @@
 #define PCI_DEVICE_ID_INTEL_LYNXPOINT_LP_SMBUS		0x9c22
 #define PCI_DEVICE_ID_INTEL_WILDCATPOINT_LP_SMBUS	0x9ca2
 #define PCI_DEVICE_ID_INTEL_SUNRISEPOINT_LP_SMBUS	0x9d23
+#define PCI_DEVICE_ID_INTEL_CANNONLAKE_LP_SMBUS		0x9da3
 #define PCI_DEVICE_ID_INTEL_SUNRISEPOINT_H_SMBUS	0xa123
 #define PCI_DEVICE_ID_INTEL_LEWISBURG_SMBUS		0xa1a3
 #define PCI_DEVICE_ID_INTEL_LEWISBURG_SSKU_SMBUS	0xa223
 #define PCI_DEVICE_ID_INTEL_KABYLAKE_PCH_H_SMBUS	0xa2a3
+#define PCI_DEVICE_ID_INTEL_CANNONLAKE_H_SMBUS		0xa323
 
 struct i801_mux_config {
 	char *gpio_chip;
@@ -1026,6 +1030,8 @@ static const struct pci_device_id i801_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_LEWISBURG_SMBUS) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_LEWISBURG_SSKU_SMBUS) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_KABYLAKE_PCH_H_SMBUS) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CANNONLAKE_H_SMBUS) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CANNONLAKE_LP_SMBUS) },
 	{ 0, }
 };
 
@@ -1499,6 +1505,8 @@ static int i801_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	switch (dev->device) {
 	case PCI_DEVICE_ID_INTEL_SUNRISEPOINT_H_SMBUS:
 	case PCI_DEVICE_ID_INTEL_SUNRISEPOINT_LP_SMBUS:
+	case PCI_DEVICE_ID_INTEL_CANNONLAKE_H_SMBUS:
+	case PCI_DEVICE_ID_INTEL_CANNONLAKE_LP_SMBUS:
 	case PCI_DEVICE_ID_INTEL_LEWISBURG_SMBUS:
 	case PCI_DEVICE_ID_INTEL_LEWISBURG_SSKU_SMBUS:
 	case PCI_DEVICE_ID_INTEL_DNV_SMBUS:
-- 
2.11.0
