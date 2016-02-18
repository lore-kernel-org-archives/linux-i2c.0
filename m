From: Alexandra Yates <alexandra.yates@linux.intel.com>
Subject: [PATCH V2] i2c: i801: Intel DNV_N device IDs SMBus
Date: Wed, 17 Feb 2016 18:23:48 -0800
Message-ID: <1455762228-22341-1-git-send-email-alexandra.yates@linux.intel.com>
References: <[PATCH V2] i2c: i801: Intel DNV_N device IDs SMBus>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:2492 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422762AbcBRCTk (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 17 Feb 2016 21:19:40 -0500
In-Reply-To: <[PATCH V2] i2c: i801: Intel DNV_N device IDs SMBus>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de, jdelvare@suse.de, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Alexandra Yates <alexandra.yates@linux.intel.com>

Adding Intel codename DNV_N platform device IDs for SMBus.

Signed-off-by: Alexandra Yates <alexandra.yates@linux.intel.com>
---
 Change log V1 to V2: Added changes to Documentation/i2c/busses/i2c-i801
 drivers/i2c/busses/Kconfig and fixed merge conflicts.
 Documentation/i2c/busses/i2c-i801 | 1 +
 drivers/i2c/busses/Kconfig        | 1 +
 drivers/i2c/busses/i2c-i801.c     | 4 ++++
 3 files changed, 6 insertions(+)

diff --git a/Documentation/i2c/busses/i2c-i801 b/Documentation/i2c/busses/i2c-i801
index 1bba38d..71ef45f 100644
--- a/Documentation/i2c/busses/i2c-i801
+++ b/Documentation/i2c/busses/i2c-i801
@@ -31,6 +31,7 @@ Supported adapters:
   * Intel Sunrise Point-H (PCH)
   * Intel Sunrise Point-LP (PCH)
   * Intel DNV (SOC)
+  * Intel DNV_N (SOC)
   * Intel Broxton (SOC)
   * Intel Lewisburg (PCH)
    Datasheets: Publicly available at the Intel website
diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 0299dfa..3710394 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -125,6 +125,7 @@ config I2C_I801
 	    Sunrise Point-H (PCH)
 	    Sunrise Point-LP (PCH)
 	    DNV (SOC)
+	    DNV_N (SOC)
 	    Broxton (SOC)
 	    Lewisburg (PCH)
 
diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index 27fa0cb..5bc032d 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -60,6 +60,7 @@
  * BayTrail (SOC)		0x0f12	32	hard	yes	yes	yes
  * Sunrise Point-H (PCH) 	0xa123  32	hard	yes	yes	yes
  * Sunrise Point-LP (PCH)	0x9d23	32	hard	yes	yes	yes
+ * DNV_N (SOC)			0x19ac	32	hard	yes	yes	yes
  * DNV (SOC)			0x19df	32	hard	yes	yes	yes
  * Broxton (SOC)		0x5ad4	32	hard	yes	yes	yes
  * Lewisburg (PCH)		0xa1a3	32	hard	yes	yes	yes
@@ -206,6 +207,7 @@
 #define PCI_DEVICE_ID_INTEL_WILDCATPOINT_LP_SMBUS	0x9ca2
 #define PCI_DEVICE_ID_INTEL_SUNRISEPOINT_H_SMBUS	0xa123
 #define PCI_DEVICE_ID_INTEL_SUNRISEPOINT_LP_SMBUS	0x9d23
+#define PCI_DEVICE_ID_INTEL_DNV_N_SMBUS			0x19ac
 #define PCI_DEVICE_ID_INTEL_DNV_SMBUS			0x19df
 #define PCI_DEVICE_ID_INTEL_BROXTON_SMBUS		0x5ad4
 #define PCI_DEVICE_ID_INTEL_LEWISBURG_SMBUS		0xa1a3
@@ -871,6 +873,7 @@ static const struct pci_device_id i801_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_BRASWELL_SMBUS) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_SUNRISEPOINT_H_SMBUS) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_SUNRISEPOINT_LP_SMBUS) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_DNV_N_SMBUS) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_DNV_SMBUS) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_BROXTON_SMBUS) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_LEWISBURG_SMBUS) },
@@ -1273,6 +1276,7 @@ static int i801_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	case PCI_DEVICE_ID_INTEL_SUNRISEPOINT_LP_SMBUS:
 	case PCI_DEVICE_ID_INTEL_LEWISBURG_SMBUS:
 	case PCI_DEVICE_ID_INTEL_LEWISBURG_SSKU_SMBUS:
+	case PCI_DEVICE_ID_INTEL_DNV_N_SMBUS:
 	case PCI_DEVICE_ID_INTEL_DNV_SMBUS:
 		priv->features |= FEATURE_I2C_BLOCK_READ;
 		priv->features |= FEATURE_IRQ;
-- 
1.9.1
