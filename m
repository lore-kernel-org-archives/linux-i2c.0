From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/3] i2c: designware-pci: Make bus number allocation robust
Date: Wed, 15 Jun 2016 01:55:58 +0300
Message-ID: <1465944960-25444-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:52921 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751893AbcFNW4Z (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 14 Jun 2016 18:56:25 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

On some platforms, such as Intel Medfield, the I2C slave devices are enumerated
through SFI tables where bus numbering is expected to be defined in the OS.
Make the bus number allocation robust for such platforms.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/i2c/busses/i2c-designware-pcidrv.c | 84 ++++++++++++------------------
 1 file changed, 34 insertions(+), 50 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-pcidrv.c b/drivers/i2c/busses/i2c-designware-pcidrv.c
index 7368be0..0f1fc48 100644
--- a/drivers/i2c/busses/i2c-designware-pcidrv.c
+++ b/drivers/i2c/busses/i2c-designware-pcidrv.c
@@ -41,13 +41,7 @@
 #define DRIVER_NAME "i2c-designware-pci"
 
 enum dw_pci_ctl_id_t {
-	medfield_0,
-	medfield_1,
-	medfield_2,
-	medfield_3,
-	medfield_4,
-	medfield_5,
-
+	medfield,
 	baytrail,
 	haswell,
 };
@@ -68,6 +62,7 @@ struct dw_pci_controller {
 	u32 clk_khz;
 	u32 functionality;
 	struct dw_scl_sda_cfg *scl_sda_cfg;
+	int (*setup)(struct pci_dev *pdev, struct dw_pci_controller *c);
 };
 
 #define INTEL_MID_STD_CFG  (DW_IC_CON_MASTER |			\
@@ -98,48 +93,31 @@ static struct dw_scl_sda_cfg hsw_config = {
 	.sda_hold = 0x9,
 };
 
+static int mfld_setup(struct pci_dev *pdev, struct dw_pci_controller *c)
+{
+	switch (pdev->device) {
+	case 0x0817:
+	case 0x0818:
+	case 0x0819:
+		c->bus_num = pdev->device - 0x817 + 3;
+		return 0;
+	case 0x082C:
+	case 0x082D:
+	case 0x082E:
+		c->bus_num = pdev->device - 0x82C + 0;
+		return 0;
+	}
+	return -ENODEV;
+}
+
 static struct dw_pci_controller dw_pci_controllers[] = {
-	[medfield_0] = {
-		.bus_num     = 0,
-		.bus_cfg   = INTEL_MID_STD_CFG | DW_IC_CON_SPEED_FAST,
-		.tx_fifo_depth = 32,
-		.rx_fifo_depth = 32,
-		.clk_khz      = 25000,
-	},
-	[medfield_1] = {
-		.bus_num     = 1,
-		.bus_cfg   = INTEL_MID_STD_CFG | DW_IC_CON_SPEED_FAST,
-		.tx_fifo_depth = 32,
-		.rx_fifo_depth = 32,
-		.clk_khz      = 25000,
-	},
-	[medfield_2] = {
-		.bus_num     = 2,
-		.bus_cfg   = INTEL_MID_STD_CFG | DW_IC_CON_SPEED_FAST,
-		.tx_fifo_depth = 32,
-		.rx_fifo_depth = 32,
-		.clk_khz      = 25000,
-	},
-	[medfield_3] = {
-		.bus_num     = 3,
-		.bus_cfg   = INTEL_MID_STD_CFG | DW_IC_CON_SPEED_STD,
-		.tx_fifo_depth = 32,
-		.rx_fifo_depth = 32,
-		.clk_khz      = 25000,
-	},
-	[medfield_4] = {
-		.bus_num     = 4,
-		.bus_cfg   = INTEL_MID_STD_CFG | DW_IC_CON_SPEED_FAST,
-		.tx_fifo_depth = 32,
-		.rx_fifo_depth = 32,
-		.clk_khz      = 25000,
-	},
-	[medfield_5] = {
-		.bus_num     = 5,
+	[medfield] = {
+		.bus_num = -1,
 		.bus_cfg   = INTEL_MID_STD_CFG | DW_IC_CON_SPEED_FAST,
 		.tx_fifo_depth = 32,
 		.rx_fifo_depth = 32,
 		.clk_khz      = 25000,
+		.setup = mfld_setup,
 	},
 	[baytrail] = {
 		.bus_num = -1,
@@ -242,6 +220,12 @@ static int i2c_dw_pci_probe(struct pci_dev *pdev,
 	dev->tx_fifo_depth = controller->tx_fifo_depth;
 	dev->rx_fifo_depth = controller->rx_fifo_depth;
 
+	if (controller->setup) {
+		r = controller->setup(pdev, controller);
+		if (r)
+			return r;
+	}
+
 	adap = &dev->adapter;
 	adap->owner = THIS_MODULE;
 	adap->class = 0;
@@ -276,12 +260,12 @@ MODULE_ALIAS("i2c_designware-pci");
 
 static const struct pci_device_id i2_designware_pci_ids[] = {
 	/* Medfield */
-	{ PCI_VDEVICE(INTEL, 0x0817), medfield_3 },
-	{ PCI_VDEVICE(INTEL, 0x0818), medfield_4 },
-	{ PCI_VDEVICE(INTEL, 0x0819), medfield_5 },
-	{ PCI_VDEVICE(INTEL, 0x082C), medfield_0 },
-	{ PCI_VDEVICE(INTEL, 0x082D), medfield_1 },
-	{ PCI_VDEVICE(INTEL, 0x082E), medfield_2 },
+	{ PCI_VDEVICE(INTEL, 0x0817), medfield },
+	{ PCI_VDEVICE(INTEL, 0x0818), medfield },
+	{ PCI_VDEVICE(INTEL, 0x0819), medfield },
+	{ PCI_VDEVICE(INTEL, 0x082C), medfield },
+	{ PCI_VDEVICE(INTEL, 0x082D), medfield },
+	{ PCI_VDEVICE(INTEL, 0x082E), medfield },
 	/* Baytrail */
 	{ PCI_VDEVICE(INTEL, 0x0F41), baytrail },
 	{ PCI_VDEVICE(INTEL, 0x0F42), baytrail },
-- 
2.8.1
