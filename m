From: dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: [PATCH 6/9] i2c-designware: move controller config to bus specific portion of driver
Date: Fri, 14 Jan 2011 11:27:33 -0800
Message-ID: <1295033256-30077-7-git-send-email-dirk.brandewie@gmail.com>
References: <1295033256-30077-1-git-send-email-dirk.brandewie@gmail.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1295033256-30077-1-git-send-email-dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, shinya.kuribayashi.px-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

With multiple I2C adapters possible in the system each running at
(possibly) different speeds we need to move the controller
configuration bit field to the adapter.

Signed-off-by: Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/busses/i2c-designware-core.c |    7 +++----
 drivers/i2c/busses/i2c-designware-core.h |    1 +
 drivers/i2c/busses/i2c-designware-pci.c  |   29 +++++++++++++++--------------
 drivers/i2c/busses/i2c-designware-plat.c |    2 ++
 4 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
index c6a2b50..6723f9e 100644
--- a/drivers/i2c/busses/i2c-designware-core.c
+++ b/drivers/i2c/busses/i2c-designware-core.c
@@ -141,7 +141,7 @@ void
 i2c_dw_init(struct dw_i2c_dev *dev)
 {
 	u32 input_clock_khz;
-	u32 ic_con, hcnt, lcnt;
+	u32 hcnt, lcnt;
 
 	input_clock_khz = i2c_dw_clk_get_rate(dev);
 
@@ -183,9 +183,7 @@ i2c_dw_init(struct dw_i2c_dev *dev)
 	writel(0, dev->base + DW_IC_RX_TL);
 
 	/* configure the i2c master */
-	ic_con = DW_IC_CON_MASTER | DW_IC_CON_SLAVE_DISABLE |
-		DW_IC_CON_RESTART_EN | DW_IC_CON_SPEED_FAST;
-	writel(ic_con, dev->base + DW_IC_CON);
+	writel(dev->master_cfg, dev->base + DW_IC_CON);
 }
 EXPORT_SYMBOL(i2c_dw_init);
 
@@ -375,6 +373,7 @@ int i2c_dw_handle_tx_abort(struct dw_i2c_dev *dev)
 		return -EIO;
 }
 
+
 /*
  * Prepare controller for a transaction and call i2c_dw_xfer_msg
  */
diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
index e39a412..9aefe89 100644
--- a/drivers/i2c/busses/i2c-designware-core.h
+++ b/drivers/i2c/busses/i2c-designware-core.h
@@ -194,6 +194,7 @@ struct dw_i2c_dev {
 	int			irq;
 	struct i2c_adapter	adapter;
 	u32			functionality;
+	u32			master_cfg;
 	unsigned int		tx_fifo_depth;
 	unsigned int		rx_fifo_depth;
 };
diff --git a/drivers/i2c/busses/i2c-designware-pci.c b/drivers/i2c/busses/i2c-designware-pci.c
index 5d131ce..4e8681e 100644
--- a/drivers/i2c/busses/i2c-designware-pci.c
+++ b/drivers/i2c/busses/i2c-designware-pci.c
@@ -42,9 +42,6 @@
 #include "i2c-designware-core.h"
 
 #define DRIVER_NAME "i2c-designware-pci"
-#define STANDARD		0
-#define FAST			1
-#define HIGH			2
 
 enum dw_pci_ctl_id_t {
 	moorestown_0,
@@ -61,72 +58,76 @@ enum dw_pci_ctl_id_t {
 
 struct dw_pci_controller {
 	u32 bus_num;
-	u32 bus_speed;
+	u32 bus_cfg;
 	u32 tx_fifo_depth;
 	u32 rx_fifo_depth;
 	u32 clk_khz;
 };
 
+#define INTEL_MID_STD_CFG  (DW_IC_CON_MASTER |			\
+				DW_IC_CON_SLAVE_DISABLE |	\
+				DW_IC_CON_RESTART_EN)
+
 static struct  dw_pci_controller  dw_pci_controllers[] = {
 	[moorestown_0] = {
 		.bus_num     = 0,
-		.bus_speed   = FAST,
+		.bus_cfg   = INTEL_MID_STD_CFG | DW_IC_CON_SPEED_FAST,
 		.tx_fifo_depth = 64,
 		.rx_fifo_depth = 64,
 		.clk_khz      = 2500,
 	},
 	[moorestown_1] = {
 		.bus_num     = 1,
-		.bus_speed   = FAST,
+		.bus_cfg   = INTEL_MID_STD_CFG | DW_IC_CON_SPEED_FAST,
 		.tx_fifo_depth = 64,
 		.rx_fifo_depth = 64,
 		.clk_khz      = 2500,
 	},
 	[moorestown_2] = {
 		.bus_num     = 2,
-		.bus_speed   = FAST,
+		.bus_cfg   = INTEL_MID_STD_CFG | DW_IC_CON_SPEED_FAST,
 		.tx_fifo_depth = 64,
 		.rx_fifo_depth = 64,
 		.clk_khz      = 2500,
 	},
 	[medfield_0] = {
 		.bus_num     = 0,
-		.bus_speed   = FAST,
+		.bus_cfg   = INTEL_MID_STD_CFG | DW_IC_CON_SPEED_FAST,
 		.tx_fifo_depth = 64,
 		.rx_fifo_depth = 64,
 		.clk_khz      = 2500,
 	},
 	[medfield_1] = {
 		.bus_num     = 1,
-		.bus_speed   = FAST,
+		.bus_cfg   = INTEL_MID_STD_CFG | DW_IC_CON_SPEED_FAST,
 		.tx_fifo_depth = 64,
 		.rx_fifo_depth = 64,
 		.clk_khz      = 2500,
 	},
 	[medfield_2] = {
 		.bus_num     = 2,
-		.bus_speed   = FAST,
+		.bus_cfg   = INTEL_MID_STD_CFG | DW_IC_CON_SPEED_FAST,
 		.tx_fifo_depth = 64,
 		.rx_fifo_depth = 64,
 		.clk_khz      = 2500,
 	},
 	[medfield_3] = {
 		.bus_num     = 3,
-		.bus_speed   = STANDARD,
+		.bus_cfg   = INTEL_MID_STD_CFG | DW_IC_CON_SPEED_STD,
 		.tx_fifo_depth = 64,
 		.rx_fifo_depth = 64,
 		.clk_khz      = 2500,
 	},
 	[medfield_4] = {
 		.bus_num     = 4,
-		.bus_speed   = FAST,
+		.bus_cfg   = INTEL_MID_STD_CFG | DW_IC_CON_SPEED_FAST,
 		.tx_fifo_depth = 64,
 		.rx_fifo_depth = 64,
 		.clk_khz      = 2500,
 	},
 	[medfield_5] = {
 		.bus_num     = 5,
-		.bus_speed   = FAST,
+		.bus_cfg   = INTEL_MID_STD_CFG | DW_IC_CON_SPEED_FAST,
 		.tx_fifo_depth = 64,
 		.rx_fifo_depth = 64,
 		.clk_khz      = 2500,
@@ -204,6 +205,7 @@ const struct pci_device_id *id)
 		I2C_FUNC_SMBUS_BYTE_DATA |
 		I2C_FUNC_SMBUS_WORD_DATA |
 		I2C_FUNC_SMBUS_I2C_BLOCK;
+	dev->master_cfg =  controller->bus_cfg;
 
 	pci_set_drvdata(pdev, dev);
 
@@ -212,7 +214,6 @@ const struct pci_device_id *id)
 
 	i2c_dw_init(dev);
 
-
 	adap = &dev->adapter;
 	i2c_set_adapdata(adap, dev);
 	adap->owner = THIS_MODULE;
diff --git a/drivers/i2c/busses/i2c-designware-plat.c b/drivers/i2c/busses/i2c-designware-plat.c
index cf157a4..843aa01 100644
--- a/drivers/i2c/busses/i2c-designware-plat.c
+++ b/drivers/i2c/busses/i2c-designware-plat.c
@@ -97,6 +97,8 @@ static int __devinit dw_i2c_probe(struct platform_device *pdev)
 		I2C_FUNC_SMBUS_BYTE_DATA |
 		I2C_FUNC_SMBUS_WORD_DATA |
 		I2C_FUNC_SMBUS_I2C_BLOCK;
+	dev->master_cfg =  DW_IC_CON_MASTER | DW_IC_CON_SLAVE_DISABLE |
+		DW_IC_CON_RESTART_EN | DW_IC_CON_SPEED_FAST;
 
 	dev->base = ioremap(mem->start, resource_size(mem));
 	if (dev->base == NULL) {
-- 
1.7.3.4
