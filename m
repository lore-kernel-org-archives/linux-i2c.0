From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH] i2c: i801: Add PCI ID for Intel Braswell
Date: Tue, 19 Aug 2014 17:37:28 +0300
Message-ID: <1408459048-7470-1-git-send-email-mika.westerberg@linux.intel.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

From: Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

The SMBus host controller is the same as used in Baytrail so add the new
PCI ID to the driver's list of supported IDs.

Signed-off-by: Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/i2c/busses/i2c-i801.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index 2994690b26e9..10467a327749 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -164,6 +164,7 @@
 
 /* Older devices have their ID defined in <linux/pci_ids.h> */
 #define PCI_DEVICE_ID_INTEL_BAYTRAIL_SMBUS		0x0f12
+#define PCI_DEVICE_ID_INTEL_BRASWELL_SMBUS		0x2292
 #define PCI_DEVICE_ID_INTEL_COUGARPOINT_SMBUS		0x1c22
 #define PCI_DEVICE_ID_INTEL_PATSBURG_SMBUS		0x1d22
 /* Patsburg also has three 'Integrated Device Function' SMBus controllers */
@@ -828,6 +829,7 @@ static const struct pci_device_id i801_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_WILDCATPOINT_SMBUS) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_WILDCATPOINT_LP_SMBUS) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_BAYTRAIL_SMBUS) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_BRASWELL_SMBUS) },
 	{ 0, }
 };
 
-- 
2.1.0
