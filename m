From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/3] i2c: designware-pci: Introduce Merrifield support
Date: Wed, 15 Jun 2016 01:55:59 +0300
Message-ID: <1465944960-25444-2-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1465944960-25444-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:29983 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752040AbcFNW4F (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 14 Jun 2016 18:56:05 -0400
In-Reply-To: <1465944960-25444-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

This patch enables I2C controllers found on Intel Edison board.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/i2c/busses/i2c-designware-pcidrv.c | 33 ++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/i2c/busses/i2c-designware-pcidrv.c b/drivers/i2c/busses/i2c-designware-pcidrv.c
index 0f1fc48..a51f6e0 100644
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
@@ -110,6 +119,19 @@ static int mfld_setup(struct pci_dev *pdev, struct dw_pci_controller *c)
 	return -ENODEV;
 }
 
+static int mrfld_setup(struct pci_dev *pdev, struct dw_pci_controller *c)
+{
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
@@ -119,6 +141,14 @@ static struct dw_pci_controller dw_pci_controllers[] = {
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
@@ -266,6 +296,9 @@ static const struct pci_device_id i2_designware_pci_ids[] = {
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
