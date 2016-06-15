From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 2/3] i2c: designware-pci: Introduce Merrifield support
Date: Wed, 15 Jun 2016 18:05:06 +0300
Message-ID: <1466003107-19375-3-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1466003107-19375-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:16957 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932700AbcFOPHg (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 15 Jun 2016 11:07:36 -0400
In-Reply-To: <1466003107-19375-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

This patch enables I2C controllers found on Intel Edison board.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/i2c/busses/i2c-designware-pcidrv.c | 39 ++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/i2c/busses/i2c-designware-pcidrv.c b/drivers/i2c/busses/i2c-designware-pcidrv.c
index 586c8d8..a7aab10 100644
--- a/drivers/i2c/busses/i2c-designware-pcidrv.c
+++ b/drivers/i2c/busses/i2c-designware-pcidrv.c
@@ -42,6 +42,7 @@
 
 enum dw_pci_ctl_id_t {
 	medfield,
+	merrifield,
 	baytrail,
 	haswell,
 };
@@ -75,6 +76,14 @@ struct dw_pci_controller {
 					I2C_FUNC_SMBUS_WORD_DATA |	\
 					I2C_FUNC_SMBUS_I2C_BLOCK)
 
+/* Merrifield HCNT/LCNT/SDA hold time */
+static struct dw_scl_sda_cfg mrfld_config = {
+	.ss_hcnt = 0x2f8,
+	.fs_hcnt = 0x87,
+	.ss_lcnt = 0x37b,
+	.fs_lcnt = 0x10a,
+};
+
 /* BayTrail HCNT/LCNT/SDA hold time */
 static struct dw_scl_sda_cfg byt_config = {
 	.ss_hcnt = 0x200,
@@ -112,6 +121,25 @@ static int mfld_setup(struct pci_dev *pdev, struct dw_pci_controller *c)
 	return -ENODEV;
 }
 
+static int mrfld_setup(struct pci_dev *pdev, struct dw_pci_controller *c)
+{
+	/*
+	 * On Intel Merrifield the i2c busses are enumerated [1..7]. So, we add
+	 * 1 to shift the default range. Besides that the first PCI slot
+	 * provides 4 functions, that's why we have to add 0 to the head slot
+	 * and 4 to the tail one.
+	 */
+	switch (PCI_SLOT(pdev->devfn)) {
+	case 8:
+		c->bus_num = PCI_FUNC(pdev->devfn) + 0 + 1;
+		return 0;
+	case 9:
+		c->bus_num = PCI_FUNC(pdev->devfn) + 4 + 1;
+		return 0;
+	}
+	return -ENODEV;
+}
+
 static struct dw_pci_controller dw_pci_controllers[] = {
 	[medfield] = {
 		.bus_num = -1,
@@ -121,6 +149,14 @@ static struct dw_pci_controller dw_pci_controllers[] = {
 		.clk_khz      = 25000,
 		.setup = mfld_setup,
 	},
+	[merrifield] = {
+		.bus_num = -1,
+		.bus_cfg = INTEL_MID_STD_CFG | DW_IC_CON_SPEED_FAST,
+		.tx_fifo_depth = 64,
+		.rx_fifo_depth = 64,
+		.scl_sda_cfg = &mrfld_config,
+		.setup = mrfld_setup,
+	},
 	[baytrail] = {
 		.bus_num = -1,
 		.bus_cfg = INTEL_MID_STD_CFG | DW_IC_CON_SPEED_FAST,
@@ -269,6 +305,9 @@ static const struct pci_device_id i2_designware_pci_ids[] = {
 	{ PCI_VDEVICE(INTEL, 0x082C), medfield },
 	{ PCI_VDEVICE(INTEL, 0x082D), medfield },
 	{ PCI_VDEVICE(INTEL, 0x082E), medfield },
+	/* Merrifield */
+	{ PCI_VDEVICE(INTEL, 0x1195), merrifield },
+	{ PCI_VDEVICE(INTEL, 0x1196), merrifield },
 	/* Baytrail */
 	{ PCI_VDEVICE(INTEL, 0x0F41), baytrail },
 	{ PCI_VDEVICE(INTEL, 0x0F42), baytrail },
-- 
2.8.1
