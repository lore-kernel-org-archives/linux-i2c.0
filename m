From: James Ralston <james.d.ralston@intel.com>
Subject: [PATCH 2/4] i2c-i801: Add Device IDs for Intel Sunrise Point PCH
Date: Mon, 13 Oct 2014 15:20:24 -0700
Message-ID: <1413238824-5513-1-git-send-email-james.d.ralston@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>, Wolfram Sang <wsa@the-dreams.de>
Cc: James Ralston <james.d.ralston@intel.com>, linux-doc@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

This patch adds the I2C/SMBus Device IDs for the Intel Sunrise Point PCH.

Signed-off-by: James Ralston <james.d.ralston@intel.com>
---
 Documentation/i2c/busses/i2c-i801 | 1 +
 drivers/i2c/busses/Kconfig        | 1 +
 drivers/i2c/busses/i2c-i801.c     | 3 +++
 3 files changed, 5 insertions(+)

diff --git a/Documentation/i2c/busses/i2c-i801 b/Documentation/i2c/busses/i2c-i801
index e9c803e..793c83d 100644
--- a/Documentation/i2c/busses/i2c-i801
+++ b/Documentation/i2c/busses/i2c-i801
@@ -28,6 +28,7 @@ Supported adapters:
   * Intel Wildcat Point (PCH)
   * Intel Wildcat Point-LP (PCH)
   * Intel BayTrail (SOC)
+  * Intel Sunrise Point-H (PCH)
    Datasheets: Publicly available at the Intel website
 
 On Intel Patsburg and later chipsets, both the normal host SMBus controller
diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 2ac87fa..9f4f574 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -112,6 +112,7 @@ config I2C_I801
 	    Wildcat Point (PCH)
 	    Wildcat Point-LP (PCH)
 	    BayTrail (SOC)
+	    Sunrise Point-H (PCH)
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-i801.
diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index 10467a3..7cfc183 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -62,6 +62,7 @@
  * Wildcat Point (PCH)		0x8ca2	32	hard	yes	yes	yes
  * Wildcat Point-LP (PCH)	0x9ca2	32	hard	yes	yes	yes
  * BayTrail (SOC)		0x0f12	32	hard	yes	yes	yes
+ * Sunrise Point-H (PCH) 	0xa123  32	hard	yes	yes	yes
  *
  * Features supported by this driver:
  * Software PEC				no
@@ -184,6 +185,7 @@
 #define PCI_DEVICE_ID_INTEL_WELLSBURG_SMBUS_MS2		0x8d7f
 #define PCI_DEVICE_ID_INTEL_LYNXPOINT_LP_SMBUS		0x9c22
 #define PCI_DEVICE_ID_INTEL_WILDCATPOINT_LP_SMBUS	0x9ca2
+#define PCI_DEVICE_ID_INTEL_SUNRISEPOINT_H_SMBUS	0xa123
 
 struct i801_mux_config {
 	char *gpio_chip;
@@ -830,6 +832,7 @@ static const struct pci_device_id i801_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_WILDCATPOINT_LP_SMBUS) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_BAYTRAIL_SMBUS) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_BRASWELL_SMBUS) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_SUNRISEPOINT_H_SMBUS) },
 	{ 0, }
 };
 
-- 
1.8.3.1
