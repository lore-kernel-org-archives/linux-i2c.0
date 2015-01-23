From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v2 3/4] i2c: designware-pci: no need to provide clk_khz
Date: Fri, 23 Jan 2015 13:54:04 +0200
Message-ID: <1422014045-20584-3-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1422014045-20584-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1422014045-20584-1-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Cohen <david.a.cohen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The clk_khz field makes sense only if SS counters are not provided. Since we
provide them for Haswell and Baytrail explicitly we may omit the clk_khz
parameter.

Reviewed-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/i2c/busses/i2c-designware-pcidrv.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-pcidrv.c b/drivers/i2c/busses/i2c-designware-pcidrv.c
index 435a8ec..cddb20d 100644
--- a/drivers/i2c/busses/i2c-designware-pcidrv.c
+++ b/drivers/i2c/busses/i2c-designware-pcidrv.c
@@ -104,7 +104,6 @@ static struct  dw_pci_controller  dw_pci_controllers[] = {
 		.bus_cfg = INTEL_MID_STD_CFG | DW_IC_CON_SPEED_FAST,
 		.tx_fifo_depth = 32,
 		.rx_fifo_depth = 32,
-		.clk_khz = 100000,
 		.functionality = I2C_FUNC_10BIT_ADDR,
 		.scl_sda_cfg = &byt_config,
 	},
@@ -113,7 +112,6 @@ static struct  dw_pci_controller  dw_pci_controllers[] = {
 		.bus_cfg = INTEL_MID_STD_CFG | DW_IC_CON_SPEED_FAST,
 		.tx_fifo_depth = 32,
 		.rx_fifo_depth = 32,
-		.clk_khz = 100000,
 		.functionality = I2C_FUNC_10BIT_ADDR,
 		.scl_sda_cfg = &hsw_config,
 	},
-- 
2.1.4
