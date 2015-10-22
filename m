From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH] i2c: i801: Add support for Intel Broxton
Date: Thu, 22 Oct 2015 17:16:58 +0300
Message-ID: <1445523418-5166-1-git-send-email-jarkko.nikula@linux.intel.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:60056 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757761AbbJVORH (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 22 Oct 2015 10:17:07 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>

This patch adds the SMBUS PCI ID of Intel Broxton.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
This goes on top of Mika's "[PATCH] i2c: i801: Add support for Intel DNV":
http://marc.info/?l=linux-i2c&m=144474010421111&w=2
---
 drivers/i2c/busses/i2c-i801.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index 47c2ddf76264..d8219bc2ac4e 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -61,6 +61,7 @@
  * Sunrise Point-H (PCH) 	0xa123  32	hard	yes	yes	yes
  * Sunrise Point-LP (PCH)	0x9d23	32	hard	yes	yes	yes
  * DNV (SOC)			0x19df	32	hard	yes	yes	yes
+ * Broxton (SOC)		0x5ad4	32	hard	yes	yes	yes
  *
  * Features supported by this driver:
  * Software PEC				no
@@ -204,6 +205,7 @@
 #define PCI_DEVICE_ID_INTEL_SUNRISEPOINT_H_SMBUS	0xa123
 #define PCI_DEVICE_ID_INTEL_SUNRISEPOINT_LP_SMBUS	0x9d23
 #define PCI_DEVICE_ID_INTEL_DNV_SMBUS			0x19df
+#define PCI_DEVICE_ID_INTEL_BROXTON_SMBUS		0x5ad4
 
 struct i801_mux_config {
 	char *gpio_chip;
@@ -866,6 +868,7 @@ static const struct pci_device_id i801_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_SUNRISEPOINT_H_SMBUS) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_SUNRISEPOINT_LP_SMBUS) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_DNV_SMBUS) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_BROXTON_SMBUS) },
 	{ 0, }
 };
 
-- 
2.6.1
