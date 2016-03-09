From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] i2c-i801: sort IDs alphabetically
Date: Wed,  9 Mar 2016 14:14:17 +0200
Message-ID: <1457525657-19178-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:36263 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932340AbcCIMOV (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 9 Mar 2016 07:14:21 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org, Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Sort the list to have a faster search for a certain PCI ID.

There is no functional change.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/i2c/busses/i2c-i801.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index 27fa0cb..585a3b7 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -184,7 +184,7 @@
 
 /* Older devices have their ID defined in <linux/pci_ids.h> */
 #define PCI_DEVICE_ID_INTEL_BAYTRAIL_SMBUS		0x0f12
-#define PCI_DEVICE_ID_INTEL_BRASWELL_SMBUS		0x2292
+#define PCI_DEVICE_ID_INTEL_DNV_SMBUS			0x19df
 #define PCI_DEVICE_ID_INTEL_COUGARPOINT_SMBUS		0x1c22
 #define PCI_DEVICE_ID_INTEL_PATSBURG_SMBUS		0x1d22
 /* Patsburg also has three 'Integrated Device Function' SMBus controllers */
@@ -193,9 +193,11 @@
 #define PCI_DEVICE_ID_INTEL_PATSBURG_SMBUS_IDF2		0x1d72
 #define PCI_DEVICE_ID_INTEL_PANTHERPOINT_SMBUS		0x1e22
 #define PCI_DEVICE_ID_INTEL_AVOTON_SMBUS		0x1f3c
+#define PCI_DEVICE_ID_INTEL_BRASWELL_SMBUS		0x2292
 #define PCI_DEVICE_ID_INTEL_DH89XXCC_SMBUS		0x2330
 #define PCI_DEVICE_ID_INTEL_COLETOCREEK_SMBUS		0x23b0
 #define PCI_DEVICE_ID_INTEL_5_3400_SERIES_SMBUS		0x3b30
+#define PCI_DEVICE_ID_INTEL_BROXTON_SMBUS		0x5ad4
 #define PCI_DEVICE_ID_INTEL_LYNXPOINT_SMBUS		0x8c22
 #define PCI_DEVICE_ID_INTEL_WILDCATPOINT_SMBUS		0x8ca2
 #define PCI_DEVICE_ID_INTEL_WELLSBURG_SMBUS		0x8d22
@@ -204,10 +206,8 @@
 #define PCI_DEVICE_ID_INTEL_WELLSBURG_SMBUS_MS2		0x8d7f
 #define PCI_DEVICE_ID_INTEL_LYNXPOINT_LP_SMBUS		0x9c22
 #define PCI_DEVICE_ID_INTEL_WILDCATPOINT_LP_SMBUS	0x9ca2
-#define PCI_DEVICE_ID_INTEL_SUNRISEPOINT_H_SMBUS	0xa123
 #define PCI_DEVICE_ID_INTEL_SUNRISEPOINT_LP_SMBUS	0x9d23
-#define PCI_DEVICE_ID_INTEL_DNV_SMBUS			0x19df
-#define PCI_DEVICE_ID_INTEL_BROXTON_SMBUS		0x5ad4
+#define PCI_DEVICE_ID_INTEL_SUNRISEPOINT_H_SMBUS	0xa123
 #define PCI_DEVICE_ID_INTEL_LEWISBURG_SMBUS		0xa1a3
 #define PCI_DEVICE_ID_INTEL_LEWISBURG_SSKU_SMBUS	0xa223
 
-- 
2.7.0
