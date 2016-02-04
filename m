From: Alexandra Yates <alexandra.yates@linux.intel.com>
Subject: [PATCH] Adding Intel Lewisburg support for iTCO
Date: Thu,  4 Feb 2016 14:37:27 -0800
Message-ID: <1454625447-27563-1-git-send-email-alexandra.yates@linux.intel.com>
References: <Adding Intel Lewisburg support for iTCO>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:50261 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933251AbcBDWdf (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 4 Feb 2016 17:33:35 -0500
In-Reply-To: <Adding Intel Lewisburg support for iTCO>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: jdelvare@suse.com, wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Alexandra Yates <alexandra.yates@linux.intel.com>

Starting from Intel Sunrisepoint (Skylake PCH) the iTCO watchdog
resources have been moved to reside under the i801 SMBus host
controller whereas previously they were under the LPC device.

This patch adds Intel lewisburg SMBus support for iTCO device.

Signed-off-by: Alexandra Yates <alexandra.yates@linux.intel.com>
---
 drivers/i2c/busses/i2c-i801.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index f62d697..27fa0cb 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -1271,6 +1271,8 @@ static int i801_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	switch (dev->device) {
 	case PCI_DEVICE_ID_INTEL_SUNRISEPOINT_H_SMBUS:
 	case PCI_DEVICE_ID_INTEL_SUNRISEPOINT_LP_SMBUS:
+	case PCI_DEVICE_ID_INTEL_LEWISBURG_SMBUS:
+	case PCI_DEVICE_ID_INTEL_LEWISBURG_SSKU_SMBUS:
 	case PCI_DEVICE_ID_INTEL_DNV_SMBUS:
 		priv->features |= FEATURE_I2C_BLOCK_READ;
 		priv->features |= FEATURE_IRQ;
-- 
1.9.1
