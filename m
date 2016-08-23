From: Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH v4 3/4] i2c: designware: detect when dynamic tar update is possible
Date: Tue, 23 Aug 2016 19:18:55 -0300
Message-ID: <1471990736-30190-4-git-send-email-lucas.demarchi@intel.com>
References: <1471990736-30190-1-git-send-email-lucas.demarchi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1471990736-30190-1-git-send-email-lucas.demarchi@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Christian Ruppert <christian.ruppert@alitech.com>, mika.westerberg@linux.intel.com, jarkko.nikula@linux.intel.com, linux-kernel@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Lucas De Marchi <lucas.demarchi@intel.com>, =?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>
List-Id: linux-i2c@vger.kernel.org

This adapter can be synthesized with dynamic tar update enabled or disabled.
When enabled it is not necessary to disable the adapter to change the slave
address in some situations, which saves some time per transaction.

There is no direct register to know if this feature is enabled but we can do it
indirectly by writing to the 10BIT_ADDR field in IC_CON: this field is
read only when dynamic tar update is enabled.

Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
Signed-off-by: José Roberto de Souza <jose.souza@intel.com>
---
 drivers/i2c/busses/i2c-designware-core.c | 44 ++++++++++++++++++++++++--------
 drivers/i2c/busses/i2c-designware-core.h |  1 +
 2 files changed, 34 insertions(+), 11 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
index 79f33b3..b855beb 100644
--- a/drivers/i2c/busses/i2c-designware-core.c
+++ b/drivers/i2c/busses/i2c-designware-core.c
@@ -433,28 +433,29 @@ static int i2c_dw_wait_bus_not_busy(struct dw_i2c_dev *dev)
 static void i2c_dw_xfer_init(struct dw_i2c_dev *dev)
 {
 	struct i2c_msg *msgs = dev->msgs;
-	u32 ic_con, ic_tar = 0;
+	u32 ic_tar = 0;
 
 	/* Disable the adapter */
 	__i2c_dw_enable_and_wait(dev, false);
 
 	/* if the slave address is ten bit address, enable 10BITADDR */
-	ic_con = dw_readl(dev, DW_IC_CON);
-	if (msgs[dev->msg_write_idx].flags & I2C_M_TEN) {
-		ic_con |= DW_IC_CON_10BITADDR_MASTER;
+	if (dev->dynamic_tar_update_enabled) {
 		/*
 		 * If I2C_DYNAMIC_TAR_UPDATE is set, the 10-bit addressing
-		 * mode has to be enabled via bit 12 of IC_TAR register.
-		 * We set it always as I2C_DYNAMIC_TAR_UPDATE can't be
-		 * detected from registers.
+		 * mode has to be enabled via bit 12 of IC_TAR register,
+		 * otherwise bit 4 of IC_CON is used.
 		 */
-		ic_tar = DW_IC_TAR_10BITADDR_MASTER;
+		if (msgs[dev->msg_write_idx].flags & I2C_M_TEN)
+			ic_tar = DW_IC_TAR_10BITADDR_MASTER;
 	} else {
-		ic_con &= ~DW_IC_CON_10BITADDR_MASTER;
+		u32 ic_con = dw_readl(dev, DW_IC_CON);
+		if (msgs[dev->msg_write_idx].flags & I2C_M_TEN)
+			ic_con |= DW_IC_CON_10BITADDR_MASTER;
+		else
+			ic_con &= ~DW_IC_CON_10BITADDR_MASTER;
+		dw_writel(dev, ic_con, DW_IC_CON);
 	}
 
-	dw_writel(dev, ic_con, DW_IC_CON);
-
 	/*
 	 * Set the slave (target) address and enable 10-bit addressing mode
 	 * if applicable.
@@ -874,6 +875,7 @@ int i2c_dw_probe(struct dw_i2c_dev *dev)
 {
 	struct i2c_adapter *adap = &dev->adapter;
 	int r;
+	u32 reg;
 
 	init_completion(&dev->cmd_complete);
 
@@ -881,6 +883,26 @@ int i2c_dw_probe(struct dw_i2c_dev *dev)
 	if (r)
 		return r;
 
+	r = i2c_dw_acquire_lock(dev);
+	if (r)
+		return r;
+
+	/*
+	 * Test if dynamic TAR update is enabled in this controller by writing
+	 * to IC_10BITADDR_MASTER field in IC_CON: when it is enabled this
+	 * field is read-only so it should not succeed
+	 */
+	reg = dw_readl(dev, DW_IC_CON);
+	dw_writel(dev, reg ^ DW_IC_CON_10BITADDR_MASTER, DW_IC_CON);
+
+	if ((dw_readl(dev, DW_IC_CON) & DW_IC_CON_10BITADDR_MASTER) ==
+	    (reg & DW_IC_CON_10BITADDR_MASTER)) {
+		dev->dynamic_tar_update_enabled = true;
+		dev_dbg(dev->dev, "Dynamic TAR update enabled");
+	}
+
+	i2c_dw_release_lock(dev);
+
 	snprintf(adap->name, sizeof(adap->name),
 		 "Synopsys DesignWare I2C adapter");
 	adap->retries = 3;
diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
index cd409e7..cd6e9ec 100644
--- a/drivers/i2c/busses/i2c-designware-core.h
+++ b/drivers/i2c/busses/i2c-designware-core.h
@@ -105,6 +105,7 @@ struct dw_i2c_dev {
 	int			(*acquire_lock)(struct dw_i2c_dev *dev);
 	void			(*release_lock)(struct dw_i2c_dev *dev);
 	bool			pm_runtime_disabled;
+	bool			dynamic_tar_update_enabled;
 };
 
 #define ACCESS_SWAP		0x00000001
-- 
2.7.4
