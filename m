From: Alexandra Yates <alexandra.yates@linux.intel.com>
Subject: [PATCH V4] i2c: i801: Adding Intel Lewisburg support for iTCO
Date: Wed, 17 Feb 2016 18:21:21 -0800
Message-ID: <1455762081-11947-2-git-send-email-alexandra.yates@linux.intel.com>
References: <i2c: i801: Adding Intel Lewisburg support for iTCO>
 <1455762081-11947-1-git-send-email-alexandra.yates@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455762081-11947-1-git-send-email-alexandra.yates@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de, jdelvare@suse.de, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Alexandra Yates <alexandra.yates@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org

Starting from Intel Sunrisepoint (Skylake PCH) the iTCO watchdog
resources have been moved to reside under the i801 SMBus host
controller whereas previously they were under the LPC device.

This patch adds Intel lewisburg SMBus support for iTCO device.
It allows to load watchdog dynamically when the hardware is
present.

Fixes: cdc5a3110e7c ("i2c: i801: add Intel Lewisburg device IDs")
Reviewed-by: Jean Delvare <jdelvare@suse.de>
Reviewed-by: Wolfram Sang <wsa@the-dreams.de>

Signed-off-by: Alexandra Yates <alexandra.yates@linux.intel.com>
---
 Changes log v1 to v2: Fixed Subject message. No changes in code.
 Changes log v2 to v3: Clarified commit message. No changes in code.
 Changes log v3 to v4: Fixed patch formating. No changes in code.
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
