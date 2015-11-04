From: Alexandra Yates <alexandra.yates@linux.intel.com>
Subject: [PATCH V2] Intel Lewisburg device IDs for SMBus
Date: Wed,  4 Nov 2015 11:09:16 -0800
Message-ID: <1446664156-9873-1-git-send-email-alexandra.yates@linux.intel.com>
References: <Intel Lewisburg device IDs for SMBus>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:11141 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030387AbbKDTGb (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 4 Nov 2015 14:06:31 -0500
In-Reply-To: <Intel Lewisburg device IDs for SMBus>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: jdelvare@suse.com, linux-i2c@vger.kernel.org, wsa@the-dreams.de, corbet@lwn.net
Cc: Alexandra Yates <alexandra.yates@linux.intel.com>

Adding Intel codename Lewisburg platform device IDs for SMBus.

Signed-off-by: Alexandra Yates <alexandra.yates@linux.intel.com>
---
 Documentation/i2c/busses/i2c-i801 | 1 +
 drivers/i2c/busses/Kconfig        | 1 +
 drivers/i2c/busses/i2c-i801.c     | 6 ++++++
 3 files changed, 8 insertions(+)

diff --git a/Documentation/i2c/busses/i2c-i801 b/Documentation/i2c/busses/i2c-i801
index 6a4b1af..1bba38d 100644
--- a/Documentation/i2c/busses/i2c-i801
+++ b/Documentation/i2c/busses/i2c-i801
@@ -32,6 +32,7 @@ Supported adapters:
   * Intel Sunrise Point-LP (PCH)
   * Intel DNV (SOC)
   * Intel Broxton (SOC)
+  * Intel Lewisburg (PCH)
    Datasheets: Publicly available at the Intel website
 
 On Intel Patsburg and later chipsets, both the normal host SMBus controller
diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index e24c2b6..7b0aa82 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -126,6 +126,7 @@ config I2C_I801
 	    Sunrise Point-LP (PCH)
 	    DNV (SOC)
 	    Broxton (SOC)
+	    Lewisburg (PCH)
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-i801.
diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index c306751..76fcef4 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -62,6 +62,8 @@
  * Sunrise Point-LP (PCH)	0x9d23	32	hard	yes	yes	yes
  * DNV (SOC)			0x19df	32	hard	yes	yes	yes
  * Broxton (SOC)		0x5ad4	32	hard	yes	yes	yes
+ * Lewisburg (PCH)		0xA1A3	32	hard	yes	yes	yes
+ * Lewisburg Supersku (PCH)	0xA223	32	hard	yes	yes	yes
  *
  * Features supported by this driver:
  * Software PEC				no
@@ -181,6 +183,8 @@
 				 STATUS_ERROR_FLAGS)
 
 /* Older devices have their ID defined in <linux/pci_ids.h> */
+#define PCI_DEVICE_ID_INTEL_LEWISBURG_SMBUS		0xA1A3
+#define PCI_DEVICE_ID_INTEL_LEWISBURG_SSKU_SMBUS	0xA223
 #define PCI_DEVICE_ID_INTEL_BAYTRAIL_SMBUS		0x0f12
 #define PCI_DEVICE_ID_INTEL_BRASWELL_SMBUS		0x2292
 #define PCI_DEVICE_ID_INTEL_COUGARPOINT_SMBUS		0x1c22
@@ -864,6 +868,8 @@ static const struct pci_device_id i801_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_WILDCATPOINT_SMBUS) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_WILDCATPOINT_LP_SMBUS) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_BAYTRAIL_SMBUS) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_LEWISBURG_SMBUS) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_LEWISBURG_SSKU_SMBUS) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_BRASWELL_SMBUS) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_SUNRISEPOINT_H_SMBUS) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_SUNRISEPOINT_LP_SMBUS) },
-- 
1.9.1
