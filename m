From: Alexandra Yates <alexandra.yates@linux.intel.com>
Subject: [PATCH] i2c: i801: Intel DNV_N device IDs SMBus
Date: Fri,  5 Feb 2016 16:00:53 -0800
Message-ID: <1454716853-1336-1-git-send-email-alexandra.yates@linux.intel.com>
References: <i2c: i801: Intel DNV_N device IDs SMBus>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:33807 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750699AbcBEX44 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 5 Feb 2016 18:56:56 -0500
In-Reply-To: <i2c: i801: Intel DNV_N device IDs SMBus>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: jdelvare@suse.com, wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Alexandra Yates <alexandra.yates@linux.intel.com>

Adding Intel codename DNV_N platform device IDs for SMBus.

Signed-off-by: Alexandra Yates <alexandra.yates@linux.intel.com>
---
 drivers/i2c/busses/i2c-i801.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index f62d697..fb1a3ca 100644
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
@@ -1271,6 +1274,7 @@ static int i801_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	switch (dev->device) {
 	case PCI_DEVICE_ID_INTEL_SUNRISEPOINT_H_SMBUS:
 	case PCI_DEVICE_ID_INTEL_SUNRISEPOINT_LP_SMBUS:
+	case PCI_DEVICE_ID_INTEL_DNV_N_SMBUS:
 	case PCI_DEVICE_ID_INTEL_DNV_SMBUS:
 		priv->features |= FEATURE_I2C_BLOCK_READ;
 		priv->features |= FEATURE_IRQ;
-- 
1.9.1
