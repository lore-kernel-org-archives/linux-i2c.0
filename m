From: Alexandra Yates <alexandra.yates@linux.intel.com>
Subject: [PATCH V2] i2c: i801: Adding Intel Lewisburg support for iTCO
Date: Thu,  4 Feb 2016 15:06:55 -0800
Message-ID: <1454627215-2418-1-git-send-email-alexandra.yates@linux.intel.com>
References: <[PATCH V2] i2c: i801: Adding Intel Lewisburg support for iTCO>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <[PATCH V2] i2c: i801: Adding Intel Lewisburg support for iTCO>
Sender: linux-kernel-owner@vger.kernel.org
To: jdelvare@suse.com, wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Alexandra Yates <alexandra.yates@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org

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
