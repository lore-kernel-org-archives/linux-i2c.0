Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AC63D3015;
	Tue, 20 Jan 2026 13:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768914458; cv=none; b=s9xE9k69OVb/0IqRO0pmBFElrOdXHvHOUB8b78wSpsMlAf2aTMcbytl16STvb4o9Aj2Uv0OTLEZGMqON0FFk7hnYS5qUtZFy3nNrUy4h6FY9mcsTi73qNGuJulleoQGnTr6XOY1WOYtoWykKD3N3XAjlwyjeT/L/pZgwtOhg5P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768914458; c=relaxed/simple;
	bh=r2G1wZbDGtH6HoICgspsoAI1sLBCfeXYIZ18MuXkvtk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qtxGdFTKf5J1FK+lZ1SHdW+oqBPEnlPDRmsdF5guvJJmWuSWD3bQETF9LC8VnQn1AdmDX3VekXRt2u6pytYGWg8561HNXuI+ALndDeRKoMFtl1vuojJNWKr+H13Pnsc3xAKclks15D/3G+ypOogXpPRdx8lKUah39Gcqe+65Yxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ew+6ZmW3; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ew+6ZmW3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768914456; x=1800450456;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=r2G1wZbDGtH6HoICgspsoAI1sLBCfeXYIZ18MuXkvtk=;
  b=ew+6ZmW3MuJLkYsjTXtDEn8190X26U2RHRxwq8zWbA0oqjwAQqmQS7OG
   VRSoeV4f215MTXgKAbzBrOZ6KiaoUpD5s4fWIW+lcaA7xOPe5gXBdJQ/G
   3Tx5qe8adEOoaJ1Bu0t7Z9/G8uu7pEsRyCDUaKMaQ69CtfrNiUuuhdlPn
   w/OBjPR80VrdpIwvExVAgZyyLitPmQtq+vUlrkKqggSbWCEjmVnO4DmRu
   pUn3T2oBfOf11ktz/a5XZIqq/T/8QBFv+jSyFiEZjkd829PnIhNuVf1L8
   lWYIYkrrCtTwFip6v66XBCgFQ0BquPkMNZHOSR6mk6G2vX68Y2wjZ63cO
   Q==;
X-CSE-ConnectionGUID: ZR1zLKGmSz+vrTQPUZav9A==
X-CSE-MsgGUID: jpUs/zb5SJq6C4f44+v/8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="73748524"
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="73748524"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 05:07:36 -0800
X-CSE-ConnectionGUID: f5DdkXNWSpKRleKgaPbHCw==
X-CSE-MsgGUID: QLQloiJ4Qs+DPknrmErggg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="229053346"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa002.fm.intel.com with ESMTP; 20 Jan 2026 05:07:34 -0800
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Andi Shyti <andi.shyti@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jan Dabros <jsd@semihalf.com>,
	Raag Jadav <raag.jadav@intel.com>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/4] i2c: designware: Combine the init functions
Date: Tue, 20 Jan 2026 14:07:26 +0100
Message-ID: <20260120130729.1679560-3-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260120130729.1679560-1-heikki.krogerus@linux.intel.com>
References: <20260120130729.1679560-1-heikki.krogerus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Providing a single function for controller initialisation.
The controller initialisation has the same steps for master
and slave modes, except the timing parameters are only
needed in master mode.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/i2c/busses/i2c-designware-amdisp.c |  4 +-
 drivers/i2c/busses/i2c-designware-common.c | 81 +++++++++++++++++++++-
 drivers/i2c/busses/i2c-designware-core.h   |  3 +-
 drivers/i2c/busses/i2c-designware-master.c | 70 +------------------
 drivers/i2c/busses/i2c-designware-slave.c  | 44 ------------
 5 files changed, 85 insertions(+), 117 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-amdisp.c b/drivers/i2c/busses/i2c-designware-amdisp.c
index 450793d5f839..ec9259dd2a4f 100644
--- a/drivers/i2c/busses/i2c-designware-amdisp.c
+++ b/drivers/i2c/busses/i2c-designware-amdisp.c
@@ -163,8 +163,8 @@ static int amd_isp_dw_i2c_plat_runtime_resume(struct device *dev)
 
 	if (!i_dev->shared_with_punit)
 		i2c_dw_prepare_clk(i_dev, true);
-	if (i_dev->init)
-		i_dev->init(i_dev);
+
+	i2c_dw_init(i_dev);
 
 	return 0;
 }
diff --git a/drivers/i2c/busses/i2c-designware-common.c b/drivers/i2c/busses/i2c-designware-common.c
index 547ccf600b53..4668898b031d 100644
--- a/drivers/i2c/busses/i2c-designware-common.c
+++ b/drivers/i2c/busses/i2c-designware-common.c
@@ -363,6 +363,83 @@ static inline u32 i2c_dw_acpi_round_bus_speed(struct device *device) { return 0;
 
 #endif	/* CONFIG_ACPI */
 
+static void i2c_dw_configure_mode(struct dw_i2c_dev *dev)
+{
+	switch (dev->mode) {
+	case DW_IC_MASTER:
+		regmap_write(dev->map, DW_IC_TX_TL, dev->tx_fifo_depth / 2);
+		regmap_write(dev->map, DW_IC_RX_TL, 0);
+		regmap_write(dev->map, DW_IC_CON, dev->master_cfg);
+		break;
+	case DW_IC_SLAVE:
+		regmap_write(dev->map, DW_IC_TX_TL, 0);
+		regmap_write(dev->map, DW_IC_RX_TL, 0);
+		regmap_write(dev->map, DW_IC_CON, dev->slave_cfg);
+		regmap_write(dev->map, DW_IC_INTR_MASK, DW_IC_INTR_SLAVE_MASK);
+		break;
+	default:
+		return;
+	}
+}
+
+static void i2c_dw_write_timings(struct dw_i2c_dev *dev)
+{
+	/* Write standard speed timing parameters */
+	regmap_write(dev->map, DW_IC_SS_SCL_HCNT, dev->ss_hcnt);
+	regmap_write(dev->map, DW_IC_SS_SCL_LCNT, dev->ss_lcnt);
+
+	/* Write fast mode/fast mode plus timing parameters */
+	regmap_write(dev->map, DW_IC_FS_SCL_HCNT, dev->fs_hcnt);
+	regmap_write(dev->map, DW_IC_FS_SCL_LCNT, dev->fs_lcnt);
+
+	/* Write high speed timing parameters if supported */
+	if (dev->hs_hcnt && dev->hs_lcnt) {
+		regmap_write(dev->map, DW_IC_HS_SCL_HCNT, dev->hs_hcnt);
+		regmap_write(dev->map, DW_IC_HS_SCL_LCNT, dev->hs_lcnt);
+	}
+}
+
+/**
+ * i2c_dw_init() - Initialize the DesignWare I2C hardware
+ * @dev: device private data
+ *
+ * This functions configures and enables the DesigWare I2C hardware.
+ *
+ * Return: 0 on success, or negative errno otherwise.
+ */
+int i2c_dw_init(struct dw_i2c_dev *dev)
+{
+	int ret;
+
+	ret = i2c_dw_acquire_lock(dev);
+	if (ret)
+		return ret;
+
+	/* Disable the adapter */
+	__i2c_dw_disable(dev);
+
+	/*
+	 * Mask SMBus interrupts to block storms from broken
+	 * firmware that leaves IC_SMBUS=1; the handler never
+	 * services them.
+	 */
+	regmap_write(dev->map, DW_IC_SMBUS_INTR_MASK, 0);
+
+	if (dev->mode == DW_IC_MASTER)
+		i2c_dw_write_timings(dev);
+
+	/* Write SDA hold time if supported */
+	if (dev->sda_hold_time)
+		regmap_write(dev->map, DW_IC_SDA_HOLD, dev->sda_hold_time);
+
+	i2c_dw_configure_mode(dev);
+
+	i2c_dw_release_lock(dev);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(i2c_dw_init);
+
 static void i2c_dw_adjust_bus_speed(struct dw_i2c_dev *dev)
 {
 	u32 acpi_speed = i2c_dw_acpi_round_bus_speed(dev->dev);
@@ -805,7 +882,7 @@ int i2c_dw_probe(struct dw_i2c_dev *dev)
 	if (ret)
 		return ret;
 
-	ret = dev->init(dev);
+	ret = i2c_dw_init(dev);
 	if (ret)
 		return ret;
 
@@ -898,7 +975,7 @@ static int i2c_dw_runtime_resume(struct device *device)
 	if (!dev->shared_with_punit)
 		i2c_dw_prepare_clk(dev, true);
 
-	dev->init(dev);
+	i2c_dw_init(dev);
 
 	return 0;
 }
diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
index 1fc16a2d5fc5..a831595b199c 100644
--- a/drivers/i2c/busses/i2c-designware-core.h
+++ b/drivers/i2c/busses/i2c-designware-core.h
@@ -253,7 +253,6 @@ struct reset_control;
  * @semaphore_idx: Index of table with semaphore type attached to the bus. It's
  *	-1 if there is no semaphore.
  * @shared_with_punit: true if this bus is shared with the SoC's PUNIT
- * @init: function to initialize the I2C hardware
  * @set_sda_hold_time: callback to retrieve IP specific SDA hold timing
  * @mode: operation mode - DW_IC_MASTER or DW_IC_SLAVE
  * @rinfo: I²C GPIO recovery information
@@ -314,7 +313,6 @@ struct dw_i2c_dev {
 	void			(*release_lock)(void);
 	int			semaphore_idx;
 	bool			shared_with_punit;
-	int			(*init)(struct dw_i2c_dev *dev);
 	int			(*set_sda_hold_time)(struct dw_i2c_dev *dev);
 	int			mode;
 	struct i2c_bus_recovery_info rinfo;
@@ -420,6 +418,7 @@ static inline void i2c_dw_configure(struct dw_i2c_dev *dev)
 }
 
 int i2c_dw_probe(struct dw_i2c_dev *dev);
+int i2c_dw_init(struct dw_i2c_dev *dev);
 
 #if IS_ENABLED(CONFIG_I2C_DESIGNWARE_BAYTRAIL)
 int i2c_dw_baytrail_probe_lock_support(struct dw_i2c_dev *dev);
diff --git a/drivers/i2c/busses/i2c-designware-master.c b/drivers/i2c/busses/i2c-designware-master.c
index 91540a4520a3..33432bbaec1f 100644
--- a/drivers/i2c/busses/i2c-designware-master.c
+++ b/drivers/i2c/busses/i2c-designware-master.c
@@ -31,16 +31,6 @@
 #define AMD_TIMEOUT_MAX_US	250
 #define AMD_MASTERCFG_MASK	GENMASK(15, 0)
 
-static void i2c_dw_configure_fifo_master(struct dw_i2c_dev *dev)
-{
-	/* Configure Tx/Rx FIFO threshold levels */
-	regmap_write(dev->map, DW_IC_TX_TL, dev->tx_fifo_depth / 2);
-	regmap_write(dev->map, DW_IC_RX_TL, 0);
-
-	/* Configure the I2C master */
-	regmap_write(dev->map, DW_IC_CON, dev->master_cfg);
-}
-
 static int i2c_dw_set_timings_master(struct dw_i2c_dev *dev)
 {
 	unsigned int comp_param1;
@@ -195,58 +185,6 @@ static int i2c_dw_set_timings_master(struct dw_i2c_dev *dev)
 	return 0;
 }
 
-/**
- * i2c_dw_init_master() - Initialize the DesignWare I2C master hardware
- * @dev: device private data
- *
- * This functions configures and enables the I2C master.
- * This function is called during I2C init function, and in case of timeout at
- * run time.
- *
- * Return: 0 on success, or negative errno otherwise.
- */
-static int i2c_dw_init_master(struct dw_i2c_dev *dev)
-{
-	int ret;
-
-	ret = i2c_dw_acquire_lock(dev);
-	if (ret)
-		return ret;
-
-	/* Disable the adapter */
-	__i2c_dw_disable(dev);
-
-	/*
-	 * Mask SMBus interrupts to block storms from broken
-	 * firmware that leaves IC_SMBUS=1; the handler never
-	 * services them.
-	 */
-	regmap_write(dev->map, DW_IC_SMBUS_INTR_MASK, 0);
-
-	/* Write standard speed timing parameters */
-	regmap_write(dev->map, DW_IC_SS_SCL_HCNT, dev->ss_hcnt);
-	regmap_write(dev->map, DW_IC_SS_SCL_LCNT, dev->ss_lcnt);
-
-	/* Write fast mode/fast mode plus timing parameters */
-	regmap_write(dev->map, DW_IC_FS_SCL_HCNT, dev->fs_hcnt);
-	regmap_write(dev->map, DW_IC_FS_SCL_LCNT, dev->fs_lcnt);
-
-	/* Write high speed timing parameters if supported */
-	if (dev->hs_hcnt && dev->hs_lcnt) {
-		regmap_write(dev->map, DW_IC_HS_SCL_HCNT, dev->hs_hcnt);
-		regmap_write(dev->map, DW_IC_HS_SCL_LCNT, dev->hs_lcnt);
-	}
-
-	/* Write SDA hold time if supported */
-	if (dev->sda_hold_time)
-		regmap_write(dev->map, DW_IC_SDA_HOLD, dev->sda_hold_time);
-
-	i2c_dw_configure_fifo_master(dev);
-	i2c_dw_release_lock(dev);
-
-	return 0;
-}
-
 static void i2c_dw_xfer_init(struct dw_i2c_dev *dev)
 {
 	struct i2c_msg *msgs = dev->msgs;
@@ -843,9 +781,9 @@ i2c_dw_xfer_common(struct dw_i2c_dev *dev, struct i2c_msg msgs[], int num)
 	ret = i2c_dw_wait_transfer(dev);
 	if (ret) {
 		dev_err(dev->dev, "controller timed out\n");
-		/* i2c_dw_init_master() implicitly disables the adapter */
+		/* i2c_dw_init() implicitly disables the adapter */
 		i2c_recover_bus(&dev->adapter);
-		i2c_dw_init_master(dev);
+		i2c_dw_init(dev);
 		goto done;
 	}
 
@@ -950,7 +888,7 @@ static void i2c_dw_unprepare_recovery(struct i2c_adapter *adap)
 
 	i2c_dw_prepare_clk(dev, true);
 	reset_control_deassert(dev->rst);
-	i2c_dw_init_master(dev);
+	i2c_dw_init(dev);
 }
 
 static int i2c_dw_init_recovery_info(struct dw_i2c_dev *dev)
@@ -999,8 +937,6 @@ int i2c_dw_probe_master(struct dw_i2c_dev *dev)
 
 	init_completion(&dev->cmd_complete);
 
-	dev->init = i2c_dw_init_master;
-
 	ret = i2c_dw_set_timings_master(dev);
 	if (ret)
 		return ret;
diff --git a/drivers/i2c/busses/i2c-designware-slave.c b/drivers/i2c/busses/i2c-designware-slave.c
index c0baf53e97d8..9fc8faa33735 100644
--- a/drivers/i2c/busses/i2c-designware-slave.c
+++ b/drivers/i2c/busses/i2c-designware-slave.c
@@ -21,48 +21,6 @@
 
 #include "i2c-designware-core.h"
 
-static void i2c_dw_configure_fifo_slave(struct dw_i2c_dev *dev)
-{
-	/* Configure Tx/Rx FIFO threshold levels. */
-	regmap_write(dev->map, DW_IC_TX_TL, 0);
-	regmap_write(dev->map, DW_IC_RX_TL, 0);
-
-	/* Configure the I2C slave. */
-	regmap_write(dev->map, DW_IC_CON, dev->slave_cfg);
-	regmap_write(dev->map, DW_IC_INTR_MASK, DW_IC_INTR_SLAVE_MASK);
-}
-
-/**
- * i2c_dw_init_slave() - Initialize the DesignWare i2c slave hardware
- * @dev: device private data
- *
- * This function configures and enables the I2C in slave mode.
- * This function is called during I2C init function, and in case of timeout at
- * run time.
- *
- * Return: 0 on success, or negative errno otherwise.
- */
-static int i2c_dw_init_slave(struct dw_i2c_dev *dev)
-{
-	int ret;
-
-	ret = i2c_dw_acquire_lock(dev);
-	if (ret)
-		return ret;
-
-	/* Disable the adapter. */
-	__i2c_dw_disable(dev);
-
-	/* Write SDA hold time if supported */
-	if (dev->sda_hold_time)
-		regmap_write(dev->map, DW_IC_SDA_HOLD, dev->sda_hold_time);
-
-	i2c_dw_configure_fifo_slave(dev);
-	i2c_dw_release_lock(dev);
-
-	return 0;
-}
-
 int i2c_dw_reg_slave(struct i2c_client *slave)
 {
 	struct dw_i2c_dev *dev = i2c_get_adapdata(slave->adapter);
@@ -232,8 +190,6 @@ int i2c_dw_probe_slave(struct dw_i2c_dev *dev)
 	if (dev->flags & ACCESS_POLLING)
 		return -EOPNOTSUPP;
 
-	dev->init = i2c_dw_init_slave;
-
 	return 0;
 }
 
-- 
2.50.1

