From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 4/4] i2c: designware-pci: Add Haswell PCI IDs
Date: Thu, 15 May 2014 17:37:24 +0300
Message-ID: <1400164644-3222-5-git-send-email-mika.westerberg@linux.intel.com>
References: <1400164644-3222-1-git-send-email-mika.westerberg@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1400164644-3222-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Yao Jin <yao.jin@intel.com>, Aubrey Li <aubrey.li@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Intel Haswell has the same I2C host controller than Baytrail and it can
also be enumerated as a PCI device. Add the PCI IDs to the driver list.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/i2c/busses/i2c-designware-pcidrv.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/i2c/busses/i2c-designware-pcidrv.c b/drivers/i2c/busses/i2c-designware-pcidrv.c
index 85056c22d21e..3356f7ab9f79 100644
--- a/drivers/i2c/busses/i2c-designware-pcidrv.c
+++ b/drivers/i2c/busses/i2c-designware-pcidrv.c
@@ -56,6 +56,7 @@ enum dw_pci_ctl_id_t {
 	medfield_5,
 
 	baytrail,
+	haswell,
 };
 
 struct dw_scl_sda_cfg {
@@ -95,6 +96,15 @@ static struct dw_scl_sda_cfg byt_config = {
 	.sda_hold = 0x6,
 };
 
+/* Haswell HCNT/LCNT/SDA hold time */
+static struct dw_scl_sda_cfg hsw_config = {
+	.ss_hcnt = 0x01b0,
+	.fs_hcnt = 0x48,
+	.ss_lcnt = 0x01fb,
+	.fs_lcnt = 0xa0,
+	.sda_hold = 0x9,
+};
+
 static struct  dw_pci_controller  dw_pci_controllers[] = {
 	[moorestown_0] = {
 		.bus_num     = 0,
@@ -168,6 +178,15 @@ static struct  dw_pci_controller  dw_pci_controllers[] = {
 		.functionality = I2C_FUNC_10BIT_ADDR,
 		.scl_sda_cfg = &byt_config,
 	},
+	[haswell] = {
+		.bus_num = -1,
+		.bus_cfg = INTEL_MID_STD_CFG | DW_IC_CON_SPEED_FAST,
+		.tx_fifo_depth = 32,
+		.rx_fifo_depth = 32,
+		.clk_khz = 100000,
+		.functionality = I2C_FUNC_10BIT_ADDR,
+		.scl_sda_cfg = &hsw_config,
+	},
 };
 static struct i2c_algorithm i2c_dw_algo = {
 	.master_xfer	= i2c_dw_xfer,
@@ -328,6 +347,9 @@ static const struct pci_device_id i2_designware_pci_ids[] = {
 	{ PCI_VDEVICE(INTEL, 0x0F45), baytrail },
 	{ PCI_VDEVICE(INTEL, 0x0F46), baytrail },
 	{ PCI_VDEVICE(INTEL, 0x0F47), baytrail },
+	/* Haswell */
+	{ PCI_VDEVICE(INTEL, 0x9c61), haswell },
+	{ PCI_VDEVICE(INTEL, 0x9c62), haswell },
 	{ 0,}
 };
 MODULE_DEVICE_TABLE(pci, i2_designware_pci_ids);
-- 
2.0.0.rc2
