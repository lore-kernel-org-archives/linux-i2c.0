From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v1 1/3] i2c: designware-pci: shrink dw_pci_controllers array
Date: Thu, 22 Jan 2015 16:44:27 +0200
Message-ID: <1421937869-28376-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Cohen <david.a.cohen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

There is no need to duplicate same data for each controller. If we need
specific stuff for a certain controller in the future we may add it later. The
patch leaves one controller per platform.

Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/i2c/busses/i2c-designware-pcidrv.c | 96 ++++++------------------------
 1 file changed, 19 insertions(+), 77 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-pcidrv.c b/drivers/i2c/busses/i2c-designware-pcidrv.c
index acb40f9..9237abb 100644
--- a/drivers/i2c/busses/i2c-designware-pcidrv.c
+++ b/drivers/i2c/busses/i2c-designware-pcidrv.c
@@ -40,17 +40,8 @@
 #define DRIVER_NAME "i2c-designware-pci"
 
 enum dw_pci_ctl_id_t {
-	moorestown_0,
-	moorestown_1,
-	moorestown_2,
-
-	medfield_0,
-	medfield_1,
-	medfield_2,
-	medfield_3,
-	medfield_4,
-	medfield_5,
-
+	moorestown,
+	medfield,
 	baytrail,
 	haswell,
 };
@@ -102,68 +93,19 @@ static struct dw_scl_sda_cfg hsw_config = {
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
+	[moorestown] = {
+		.bus_num = -1,
+		.bus_cfg = INTEL_MID_STD_CFG | DW_IC_CON_SPEED_FAST,
 		.tx_fifo_depth = 32,
 		.rx_fifo_depth = 32,
-		.clk_khz      = 25000,
+		.clk_khz = 25000,
 	},
-	[medfield_5] = {
-		.bus_num     = 5,
-		.bus_cfg   = INTEL_MID_STD_CFG | DW_IC_CON_SPEED_FAST,
+	[medfield] = {
+		.bus_num = -1,
+		.bus_cfg = INTEL_MID_STD_CFG | DW_IC_CON_SPEED_FAST,
 		.tx_fifo_depth = 32,
 		.rx_fifo_depth = 32,
-		.clk_khz      = 25000,
+		.clk_khz = 25000,
 	},
 	[baytrail] = {
 		.bus_num = -1,
@@ -326,16 +268,16 @@ MODULE_ALIAS("i2c_designware-pci");
 
 static const struct pci_device_id i2_designware_pci_ids[] = {
 	/* Moorestown */
-	{ PCI_VDEVICE(INTEL, 0x0802), moorestown_0 },
-	{ PCI_VDEVICE(INTEL, 0x0803), moorestown_1 },
-	{ PCI_VDEVICE(INTEL, 0x0804), moorestown_2 },
+	{ PCI_VDEVICE(INTEL, 0x0802), moorestown },
+	{ PCI_VDEVICE(INTEL, 0x0803), moorestown },
+	{ PCI_VDEVICE(INTEL, 0x0804), moorestown },
 	/* Medfield */
-	{ PCI_VDEVICE(INTEL, 0x0817), medfield_3,},
-	{ PCI_VDEVICE(INTEL, 0x0818), medfield_4 },
-	{ PCI_VDEVICE(INTEL, 0x0819), medfield_5 },
-	{ PCI_VDEVICE(INTEL, 0x082C), medfield_0 },
-	{ PCI_VDEVICE(INTEL, 0x082D), medfield_1 },
-	{ PCI_VDEVICE(INTEL, 0x082E), medfield_2 },
+	{ PCI_VDEVICE(INTEL, 0x0817), medfield },
+	{ PCI_VDEVICE(INTEL, 0x0818), medfield },
+	{ PCI_VDEVICE(INTEL, 0x0819), medfield },
+	{ PCI_VDEVICE(INTEL, 0x082c), medfield },
+	{ PCI_VDEVICE(INTEL, 0x082d), medfield },
+	{ PCI_VDEVICE(INTEL, 0x082e), medfield },
 	/* Baytrail */
 	{ PCI_VDEVICE(INTEL, 0x0F41), baytrail },
 	{ PCI_VDEVICE(INTEL, 0x0F42), baytrail },
-- 
2.1.4
