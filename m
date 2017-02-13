From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH] Revert "i2c: designware: detect when dynamic tar update is possible"
Date: Mon, 13 Feb 2017 11:18:19 +0200
Message-ID: <20170213091819.4370-1-jarkko.nikula@linux.intel.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:23805 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751666AbdBMJVl (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 13 Feb 2017 04:21:41 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Shah Nehal-Bakulchandra <Nehal-bakulchandra.Shah@amd.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Lucas De Marchi <lucas.demarchi@intel.com>, "# v4 . 9+" <stable@vger.kernel.org>

This reverts commit 63d0f0a6952a1a02bc4f116b7da7c7887e46efa3.

It caused a regression on platforms where I2C controller is synthesized
with dynamic TAR update disabled. Detection code is testing is bit
DW_IC_CON_10BITADDR_MASTER in register DW_IC_CON read-only but fails to
restore original value in case bit is read-write.

Instead of fixing this we revert the commit since it was preparation for
the commit 0317e6c0f1dc ("i2c: designware: do not disable adapter after
transfer") which was also reverted.

Reported-by: Shah Nehal-Bakulchandra <Nehal-bakulchandra.Shah@amd.com>
Reported-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: <stable@vger.kernel.org> # v4.9+
Fixes: 63d0f0a6952a ("i2c: designware: detect when dynamic tar update is possible")
Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 drivers/i2c/busses/i2c-designware-core.c | 45 ++++++++------------------------
 drivers/i2c/busses/i2c-designware-core.h |  1 -
 2 files changed, 11 insertions(+), 35 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
index 6d81c56184d3..e9db857c6226 100644
--- a/drivers/i2c/busses/i2c-designware-core.c
+++ b/drivers/i2c/busses/i2c-designware-core.c
@@ -475,30 +475,28 @@ static int i2c_dw_wait_bus_not_busy(struct dw_i2c_dev *dev)
 static void i2c_dw_xfer_init(struct dw_i2c_dev *dev)
 {
 	struct i2c_msg *msgs = dev->msgs;
-	u32 ic_tar = 0;
+	u32 ic_con, ic_tar = 0;
 
 	/* Disable the adapter */
 	__i2c_dw_enable_and_wait(dev, false);
 
 	/* if the slave address is ten bit address, enable 10BITADDR */
-	if (dev->dynamic_tar_update_enabled) {
+	ic_con = dw_readl(dev, DW_IC_CON);
+	if (msgs[dev->msg_write_idx].flags & I2C_M_TEN) {
+		ic_con |= DW_IC_CON_10BITADDR_MASTER;
 		/*
 		 * If I2C_DYNAMIC_TAR_UPDATE is set, the 10-bit addressing
-		 * mode has to be enabled via bit 12 of IC_TAR register,
-		 * otherwise bit 4 of IC_CON is used.
+		 * mode has to be enabled via bit 12 of IC_TAR register.
+		 * We set it always as I2C_DYNAMIC_TAR_UPDATE can't be
+		 * detected from registers.
 		 */
-		if (msgs[dev->msg_write_idx].flags & I2C_M_TEN)
-			ic_tar = DW_IC_TAR_10BITADDR_MASTER;
+		ic_tar = DW_IC_TAR_10BITADDR_MASTER;
 	} else {
-		u32 ic_con = dw_readl(dev, DW_IC_CON);
-
-		if (msgs[dev->msg_write_idx].flags & I2C_M_TEN)
-			ic_con |= DW_IC_CON_10BITADDR_MASTER;
-		else
-			ic_con &= ~DW_IC_CON_10BITADDR_MASTER;
-		dw_writel(dev, ic_con, DW_IC_CON);
+		ic_con &= ~DW_IC_CON_10BITADDR_MASTER;
 	}
 
+	dw_writel(dev, ic_con, DW_IC_CON);
+
 	/*
 	 * Set the slave (target) address and enable 10-bit addressing mode
 	 * if applicable.
@@ -963,7 +961,6 @@ int i2c_dw_probe(struct dw_i2c_dev *dev)
 {
 	struct i2c_adapter *adap = &dev->adapter;
 	int r;
-	u32 reg;
 
 	init_completion(&dev->cmd_complete);
 
@@ -971,26 +968,6 @@ int i2c_dw_probe(struct dw_i2c_dev *dev)
 	if (r)
 		return r;
 
-	r = i2c_dw_acquire_lock(dev);
-	if (r)
-		return r;
-
-	/*
-	 * Test if dynamic TAR update is enabled in this controller by writing
-	 * to IC_10BITADDR_MASTER field in IC_CON: when it is enabled this
-	 * field is read-only so it should not succeed
-	 */
-	reg = dw_readl(dev, DW_IC_CON);
-	dw_writel(dev, reg ^ DW_IC_CON_10BITADDR_MASTER, DW_IC_CON);
-
-	if ((dw_readl(dev, DW_IC_CON) & DW_IC_CON_10BITADDR_MASTER) ==
-	    (reg & DW_IC_CON_10BITADDR_MASTER)) {
-		dev->dynamic_tar_update_enabled = true;
-		dev_dbg(dev->dev, "Dynamic TAR update enabled");
-	}
-
-	i2c_dw_release_lock(dev);
-
 	snprintf(adap->name, sizeof(adap->name),
 		 "Synopsys DesignWare I2C adapter");
 	adap->retries = 3;
diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
index 26250b425e2f..c1db3a5a340f 100644
--- a/drivers/i2c/busses/i2c-designware-core.h
+++ b/drivers/i2c/busses/i2c-designware-core.h
@@ -125,7 +125,6 @@ struct dw_i2c_dev {
 	int			(*acquire_lock)(struct dw_i2c_dev *dev);
 	void			(*release_lock)(struct dw_i2c_dev *dev);
 	bool			pm_runtime_disabled;
-	bool			dynamic_tar_update_enabled;
 };
 
 #define ACCESS_SWAP		0x00000001
-- 
2.11.0
