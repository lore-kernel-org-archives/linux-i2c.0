From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v2 1/4] i2c: designware-pci: remove Moorestown support
Date: Fri, 23 Jan 2015 13:54:02 +0200
Message-ID: <1422014045-20584-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Cohen <david.a.cohen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The Moorestown support bits were removed few years ago. This is a follow up to
that changes.

Suggested-by: David Cohen <david.a.cohen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/i2c/busses/i2c-designware-pcidrv.c | 29 -----------------------------
 1 file changed, 29 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-pcidrv.c b/drivers/i2c/busses/i2c-designware-pcidrv.c
index acb40f9..5c6fca7 100644
--- a/drivers/i2c/busses/i2c-designware-pcidrv.c
+++ b/drivers/i2c/busses/i2c-designware-pcidrv.c
@@ -40,10 +40,6 @@
 #define DRIVER_NAME "i2c-designware-pci"
 
 enum dw_pci_ctl_id_t {
-	moorestown_0,
-	moorestown_1,
-	moorestown_2,
-
 	medfield_0,
 	medfield_1,
 	medfield_2,
@@ -102,27 +98,6 @@ static struct dw_scl_sda_cfg hsw_config = {
 };
 
 static struct  dw_pci_controller  dw_pci_controllers[] = {
-	[moorestown_0] = {
-		.bus_num     = 0,
-		.bus_cfg   = INTEL_MID_STD_CFG | DW_IC_CON_SPEED_FAST,
-		.tx_fifo_depth = 32,
-		.rx_fifo_depth = 32,
-		.clk_khz      = 25000,
-	},
-	[moorestown_1] = {
-		.bus_num     = 1,
-		.bus_cfg   = INTEL_MID_STD_CFG | DW_IC_CON_SPEED_FAST,
-		.tx_fifo_depth = 32,
-		.rx_fifo_depth = 32,
-		.clk_khz      = 25000,
-	},
-	[moorestown_2] = {
-		.bus_num     = 2,
-		.bus_cfg   = INTEL_MID_STD_CFG | DW_IC_CON_SPEED_FAST,
-		.tx_fifo_depth = 32,
-		.rx_fifo_depth = 32,
-		.clk_khz      = 25000,
-	},
 	[medfield_0] = {
 		.bus_num     = 0,
 		.bus_cfg   = INTEL_MID_STD_CFG | DW_IC_CON_SPEED_FAST,
@@ -325,10 +300,6 @@ static void i2c_dw_pci_remove(struct pci_dev *pdev)
 MODULE_ALIAS("i2c_designware-pci");
 
 static const struct pci_device_id i2_designware_pci_ids[] = {
-	/* Moorestown */
-	{ PCI_VDEVICE(INTEL, 0x0802), moorestown_0 },
-	{ PCI_VDEVICE(INTEL, 0x0803), moorestown_1 },
-	{ PCI_VDEVICE(INTEL, 0x0804), moorestown_2 },
 	/* Medfield */
 	{ PCI_VDEVICE(INTEL, 0x0817), medfield_3,},
 	{ PCI_VDEVICE(INTEL, 0x0818), medfield_4 },
-- 
2.1.4
