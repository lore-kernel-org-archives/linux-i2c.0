From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v2] i2c: designware-pci: Add Baytrail PCI IDs
Date: Wed, 19 Feb 2014 16:10:29 +0200
Message-ID: <1392819029-6438-1-git-send-email-mika.westerberg@linux.intel.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Benson Leung <bleung-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Intel Baytrail I2C controllers can be enumerated from PCI as well as from
ACPI. In order to support this add the Baytrail PCI IDs to the driver.

Signed-off-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
Changes to previous version:
 * Removed "-%d" from the adapter name.

 drivers/i2c/busses/i2c-designware-pcidrv.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-pcidrv.c b/drivers/i2c/busses/i2c-designware-pcidrv.c
index c0a87a5eb63e..80c3b5e0a5c8 100644
--- a/drivers/i2c/busses/i2c-designware-pcidrv.c
+++ b/drivers/i2c/busses/i2c-designware-pcidrv.c
@@ -54,6 +54,8 @@ enum dw_pci_ctl_id_t {
 	medfield_3,
 	medfield_4,
 	medfield_5,
+
+	baytrail,
 };
 
 struct dw_pci_controller {
@@ -132,6 +134,13 @@ static struct  dw_pci_controller  dw_pci_controllers[] = {
 		.rx_fifo_depth = 32,
 		.clk_khz      = 25000,
 	},
+	[baytrail] = {
+		.bus_num = -1,
+		.bus_cfg = INTEL_MID_STD_CFG | DW_IC_CON_SPEED_FAST,
+		.tx_fifo_depth = 32,
+		.rx_fifo_depth = 32,
+		.clk_khz = 100000,
+	},
 };
 static struct i2c_algorithm i2c_dw_algo = {
 	.master_xfer	= i2c_dw_xfer,
@@ -226,8 +235,8 @@ static int i2c_dw_pci_probe(struct pci_dev *pdev,
 	adap->algo = &i2c_dw_algo;
 	adap->dev.parent = &pdev->dev;
 	adap->nr = controller->bus_num;
-	snprintf(adap->name, sizeof(adap->name), "i2c-designware-pci-%d",
-		adap->nr);
+
+	snprintf(adap->name, sizeof(adap->name), "i2c-designware-pci");
 
 	r = devm_request_irq(&pdev->dev, pdev->irq, i2c_dw_isr, IRQF_SHARED,
 			adap->name, dev);
@@ -278,6 +287,14 @@ static DEFINE_PCI_DEVICE_TABLE(i2_designware_pci_ids) = {
 	{ PCI_VDEVICE(INTEL, 0x082C), medfield_0 },
 	{ PCI_VDEVICE(INTEL, 0x082D), medfield_1 },
 	{ PCI_VDEVICE(INTEL, 0x082E), medfield_2 },
+	/* Baytrail */
+	{ PCI_VDEVICE(INTEL, 0x0F41), baytrail },
+	{ PCI_VDEVICE(INTEL, 0x0F42), baytrail },
+	{ PCI_VDEVICE(INTEL, 0x0F43), baytrail },
+	{ PCI_VDEVICE(INTEL, 0x0F44), baytrail },
+	{ PCI_VDEVICE(INTEL, 0x0F45), baytrail },
+	{ PCI_VDEVICE(INTEL, 0x0F46), baytrail },
+	{ PCI_VDEVICE(INTEL, 0x0F47), baytrail },
 	{ 0,}
 };
 MODULE_DEVICE_TABLE(pci, i2_designware_pci_ids);
-- 
1.9.0.rc3
