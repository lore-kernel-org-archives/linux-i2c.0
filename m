From: Alexandra Yates <alexandra.yates@linux.intel.com>
Subject: [PATCH V3] i2c: i801: Adding Intel Lewisburg support for iTCO
Date: Fri,  5 Feb 2016 15:22:44 -0800
Message-ID: <1454714564-8632-1-git-send-email-alexandra.yates@linux.intel.com>
References: <[PATCH V3] i2c: i801: Adding Intel Lewisburg support for iTCO>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:20251 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750935AbcBEXSs (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 5 Feb 2016 18:18:48 -0500
In-Reply-To: <[PATCH V3] i2c: i801: Adding Intel Lewisburg support for iTCO>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: jdelvare@suse.com, wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Alexandra Yates <alexandra.yates@linux.intel.com>

Changes log v2 to v3: Clarified commit message. No changes in code.

Starting from Intel Sunrisepoint (Skylake PCH) the iTCO watchdog
resources have been moved to reside under the i801 SMBus host
controller whereas previously they were under the LPC device.

This patch adds Intel lewisburg SMBus support for iTCO device.
It allows to load watchdog dynamically when the hardware is
present.  This patch is an addition
to cdc5a3110e7c3ae793f367285789a6bc39c962dc i2c: i801: "add
Intel Lewisburg device IDs".

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
