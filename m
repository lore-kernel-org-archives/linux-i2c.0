Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79570423A6F;
	Tue, 20 Jan 2026 13:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768914460; cv=none; b=IeKgyP+EzThuhvKs+jfbwrWFMsWS8lrM9siNfOviJY8NIo7VGWa7/p7q/x19/dLVMoeP+45eUWsvOMx6BN6yxvmpYseAtJ/wrQgHomRDfos+596b8tFEqL+PBeC171iY9zclA0BZHU4Tfb39B2RbZ/WaNCDyMs3w3eD5eGsrbtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768914460; c=relaxed/simple;
	bh=Sw7n4lLV/QXTvaW/KguasZjScbcdYDk5lNriCzDIZyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GaX36BNgs6Pf1kv1Oyiv6yxHCSBECTyeERt2RXzuLhim3j9tbGf0LbfhlumDMekYuEDCFy2lwqqPMCTjbSlS2y6w0KUmmh4ZV/NRgAQCnpsID2JZ0d19ymI/zGkggoCAO0HfqHVPo4fMO2cAWDL3NTpqC1eYeJ7UnOky3kHtqvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qwzf5MCE; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qwzf5MCE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768914458; x=1800450458;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Sw7n4lLV/QXTvaW/KguasZjScbcdYDk5lNriCzDIZyI=;
  b=Qwzf5MCECfrNkdPD0+lHdk40sxqQBw8TEqI0/DvPEOsfj9g3uaM+c8rc
   tInEJeaSFbCRvtZOtr0nLIVzgOVVaz34o5tn9cL2apUcEpuZipSMfbxvi
   YmfNL0yDbSlOO1RvV/4KMj/Nabmp1F/4x+cr448DK5W8mcDkySVMdqoeC
   x8kkm3N9NYHKrdTJrPev0IoZVuMOw/lZ3MaCqBo+aietaeU+3DKywlrk8
   2d69cFchUrDuPjVP638LpSWZ9jcxwpO9+IorUJsVJkjn88FCKtA3qVtXk
   oiHx/s5QgEI6ap33SouvHwtEFodpiBq4m1oSdkzEO5etKBfjU/N+w8B6/
   A==;
X-CSE-ConnectionGUID: xFXhG07HQ4uL1ccA/Mt3iA==
X-CSE-MsgGUID: 5ca5NiWDTsuTT3nUmQrYeA==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="73748530"
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="73748530"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 05:07:38 -0800
X-CSE-ConnectionGUID: sGSf/1pRQ6qf/eYUNI95cw==
X-CSE-MsgGUID: UnfFzhA3TauMgO2v06FMtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="229053353"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa002.fm.intel.com with ESMTP; 20 Jan 2026 05:07:36 -0800
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Andi Shyti <andi.shyti@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jan Dabros <jsd@semihalf.com>,
	Raag Jadav <raag.jadav@intel.com>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/4] i2c: designware: Enable mode swapping
Date: Tue, 20 Jan 2026 14:07:27 +0100
Message-ID: <20260120130729.1679560-4-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260120130729.1679560-1-heikki.krogerus@linux.intel.com>
References: <20260120130729.1679560-1-heikki.krogerus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DesignWare I2C can not be operated as I2C master and
I2C slave simultaneously, but that does not actually mean
master and slave modes can not be supported at the same
time. It just means an explicit mode swap needs to be
executed when the mode is changed. The DesignWare I2C
documentation actually describes a couple of cases where the
mode is excepted to be changed.

The I2C master will now always be supported. Both modes are
now always configured in i2c_dw_configure(), but the slave
mode will continue to be available only when the Kconfig
option I2C_SLAVE is enabled.

The driver will now start in master mode and then swap to
slave mode when a slave device is registered. After a slave
device is registered, the controller is swapped to master
mode when a transfer in master mode is started and then back
to slave mode again after the transfer is completed.

The DesignWare I2C can now be used with protocols such as
MCTP (drivers/net/mctp/mctp-i2c.c) and IPMI
(drivers/char/ipmi/) that require support for both I2C
master and I2C slave. It is now also possible to support the
SMBus Host Notification Protocol as I2C master if needed.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/i2c/busses/i2c-designware-common.c | 50 +++++++++++++++-------
 drivers/i2c/busses/i2c-designware-core.h   |  9 ++--
 drivers/i2c/busses/i2c-designware-master.c |  6 ++-
 drivers/i2c/busses/i2c-designware-slave.c  | 35 +++++++--------
 4 files changed, 57 insertions(+), 43 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-common.c b/drivers/i2c/busses/i2c-designware-common.c
index 4668898b031d..1a934283f650 100644
--- a/drivers/i2c/busses/i2c-designware-common.c
+++ b/drivers/i2c/busses/i2c-designware-common.c
@@ -363,21 +363,25 @@ static inline u32 i2c_dw_acpi_round_bus_speed(struct device *device) { return 0;
 
 #endif	/* CONFIG_ACPI */
 
-static void i2c_dw_configure_mode(struct dw_i2c_dev *dev)
+static void i2c_dw_configure_mode(struct dw_i2c_dev *dev, int mode)
 {
-	switch (dev->mode) {
+	switch (mode) {
 	case DW_IC_MASTER:
 		regmap_write(dev->map, DW_IC_TX_TL, dev->tx_fifo_depth / 2);
 		regmap_write(dev->map, DW_IC_RX_TL, 0);
 		regmap_write(dev->map, DW_IC_CON, dev->master_cfg);
 		break;
 	case DW_IC_SLAVE:
+		dev->status = 0;
 		regmap_write(dev->map, DW_IC_TX_TL, 0);
 		regmap_write(dev->map, DW_IC_RX_TL, 0);
 		regmap_write(dev->map, DW_IC_CON, dev->slave_cfg);
+		regmap_write(dev->map, DW_IC_SAR, dev->slave->addr);
 		regmap_write(dev->map, DW_IC_INTR_MASK, DW_IC_INTR_SLAVE_MASK);
+		__i2c_dw_enable(dev);
 		break;
 	default:
+		WARN(1, "Invalid mode %d\n", mode);
 		return;
 	}
 }
@@ -399,6 +403,31 @@ static void i2c_dw_write_timings(struct dw_i2c_dev *dev)
 	}
 }
 
+/**
+ * i2c_dw_set_mode() - Select the controller mode of operation - master or slave
+ * @dev: device private data
+ * @mode: I2C mode of operation
+ *
+ * Configures the controller to operate in @mode. This function needs to be
+ * called when ever a mode swap is required.
+ *
+ * Setting the slave mode does not have an effect before a slave device is
+ * registered. So before the slave device is registered, the controller is kept
+ * in master mode regardless of @mode.
+ *
+ * The controller must be disabled before this function is called.
+ */
+void i2c_dw_set_mode(struct dw_i2c_dev *dev, int mode)
+{
+	if (mode == DW_IC_SLAVE && !dev->slave)
+		mode = DW_IC_MASTER;
+	if (dev->mode == mode)
+		return;
+
+	i2c_dw_configure_mode(dev, mode);
+	dev->mode = mode;
+}
+
 /**
  * i2c_dw_init() - Initialize the DesignWare I2C hardware
  * @dev: device private data
@@ -425,14 +454,13 @@ int i2c_dw_init(struct dw_i2c_dev *dev)
 	 */
 	regmap_write(dev->map, DW_IC_SMBUS_INTR_MASK, 0);
 
-	if (dev->mode == DW_IC_MASTER)
-		i2c_dw_write_timings(dev);
+	i2c_dw_write_timings(dev);
 
 	/* Write SDA hold time if supported */
 	if (dev->sda_hold_time)
 		regmap_write(dev->map, DW_IC_SDA_HOLD, dev->sda_hold_time);
 
-	i2c_dw_configure_mode(dev);
+	i2c_dw_configure_mode(dev, dev->mode);
 
 	i2c_dw_release_lock(dev);
 
@@ -868,17 +896,7 @@ int i2c_dw_probe(struct dw_i2c_dev *dev)
 	if (ret)
 		return ret;
 
-	switch (dev->mode) {
-	case DW_IC_SLAVE:
-		ret = i2c_dw_probe_slave(dev);
-		break;
-	case DW_IC_MASTER:
-		ret = i2c_dw_probe_master(dev);
-		break;
-	default:
-		ret = -EINVAL;
-		break;
-	}
+	ret = i2c_dw_probe_master(dev);
 	if (ret)
 		return ret;
 
diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
index a831595b199c..853a8a4ed2c1 100644
--- a/drivers/i2c/busses/i2c-designware-core.h
+++ b/drivers/i2c/busses/i2c-designware-core.h
@@ -399,26 +399,23 @@ int i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num);
 
 #if IS_ENABLED(CONFIG_I2C_SLAVE)
 extern void i2c_dw_configure_slave(struct dw_i2c_dev *dev);
-extern int i2c_dw_probe_slave(struct dw_i2c_dev *dev);
 irqreturn_t i2c_dw_isr_slave(struct dw_i2c_dev *dev);
 int i2c_dw_reg_slave(struct i2c_client *client);
 int i2c_dw_unreg_slave(struct i2c_client *client);
 #else
 static inline void i2c_dw_configure_slave(struct dw_i2c_dev *dev) { }
-static inline int i2c_dw_probe_slave(struct dw_i2c_dev *dev) { return -EINVAL; }
 static inline irqreturn_t i2c_dw_isr_slave(struct dw_i2c_dev *dev) { return IRQ_NONE; }
 #endif
 
 static inline void i2c_dw_configure(struct dw_i2c_dev *dev)
 {
-	if (i2c_detect_slave_mode(dev->dev))
-		i2c_dw_configure_slave(dev);
-	else
-		i2c_dw_configure_master(dev);
+	i2c_dw_configure_slave(dev);
+	i2c_dw_configure_master(dev);
 }
 
 int i2c_dw_probe(struct dw_i2c_dev *dev);
 int i2c_dw_init(struct dw_i2c_dev *dev);
+void i2c_dw_set_mode(struct dw_i2c_dev *dev, int mode);
 
 #if IS_ENABLED(CONFIG_I2C_DESIGNWARE_BAYTRAIL)
 int i2c_dw_baytrail_probe_lock_support(struct dw_i2c_dev *dev);
diff --git a/drivers/i2c/busses/i2c-designware-master.c b/drivers/i2c/busses/i2c-designware-master.c
index 33432bbaec1f..ba2ee526ecc6 100644
--- a/drivers/i2c/busses/i2c-designware-master.c
+++ b/drivers/i2c/busses/i2c-designware-master.c
@@ -194,6 +194,8 @@ static void i2c_dw_xfer_init(struct dw_i2c_dev *dev)
 	/* Disable the adapter */
 	__i2c_dw_disable(dev);
 
+	i2c_dw_set_mode(dev, DW_IC_MASTER);
+
 	/* If the slave address is ten bit address, enable 10BITADDR */
 	if (msgs[dev->msg_write_idx].flags & I2C_M_TEN) {
 		ic_con = DW_IC_CON_10BITADDR_MASTER;
@@ -831,6 +833,8 @@ i2c_dw_xfer_common(struct dw_i2c_dev *dev, struct i2c_msg msgs[], int num)
 	ret = -EIO;
 
 done:
+	i2c_dw_set_mode(dev, DW_IC_SLAVE);
+
 	i2c_dw_release_lock(dev);
 
 done_nolock:
@@ -853,7 +857,7 @@ void i2c_dw_configure_master(struct dw_i2c_dev *dev)
 {
 	struct i2c_timings *t = &dev->timings;
 
-	dev->functionality = I2C_FUNC_10BIT_ADDR | DW_IC_DEFAULT_FUNCTIONALITY;
+	dev->functionality |= I2C_FUNC_10BIT_ADDR | DW_IC_DEFAULT_FUNCTIONALITY;
 
 	dev->master_cfg = DW_IC_CON_MASTER | DW_IC_CON_SLAVE_DISABLE |
 			  DW_IC_CON_RESTART_EN;
diff --git a/drivers/i2c/busses/i2c-designware-slave.c b/drivers/i2c/busses/i2c-designware-slave.c
index 9fc8faa33735..ad0d5fbfa6d5 100644
--- a/drivers/i2c/busses/i2c-designware-slave.c
+++ b/drivers/i2c/busses/i2c-designware-slave.c
@@ -24,24 +24,25 @@
 int i2c_dw_reg_slave(struct i2c_client *slave)
 {
 	struct dw_i2c_dev *dev = i2c_get_adapdata(slave->adapter);
+	int ret;
 
+	if (!i2c_check_functionality(slave->adapter, I2C_FUNC_SLAVE))
+		return -EOPNOTSUPP;
 	if (dev->slave)
 		return -EBUSY;
 	if (slave->flags & I2C_CLIENT_TEN)
 		return -EAFNOSUPPORT;
-	pm_runtime_get_sync(dev->dev);
 
-	/*
-	 * Set slave address in the IC_SAR register,
-	 * the address to which the DW_apb_i2c responds.
-	 */
+	ret = i2c_dw_acquire_lock(dev);
+	if (ret)
+		return ret;
+
+	pm_runtime_get_sync(dev->dev);
 	__i2c_dw_disable_nowait(dev);
-	regmap_write(dev->map, DW_IC_SAR, slave->addr);
 	dev->slave = slave;
+	i2c_dw_set_mode(dev, DW_IC_SLAVE);
 
-	__i2c_dw_enable(dev);
-
-	dev->status = 0;
+	i2c_dw_release_lock(dev);
 
 	return 0;
 }
@@ -54,6 +55,7 @@ int i2c_dw_unreg_slave(struct i2c_client *slave)
 	i2c_dw_disable(dev);
 	synchronize_irq(dev->irq);
 	dev->slave = NULL;
+	i2c_dw_set_mode(dev, DW_IC_MASTER);
 	pm_runtime_put_sync_suspend(dev->dev);
 
 	return 0;
@@ -176,23 +178,16 @@ irqreturn_t i2c_dw_isr_slave(struct dw_i2c_dev *dev)
 
 void i2c_dw_configure_slave(struct dw_i2c_dev *dev)
 {
-	dev->functionality = I2C_FUNC_SLAVE;
+	if (dev->flags & ACCESS_POLLING)
+		return;
+
+	dev->functionality |= I2C_FUNC_SLAVE;
 
 	dev->slave_cfg = DW_IC_CON_RX_FIFO_FULL_HLD_CTRL |
 			 DW_IC_CON_RESTART_EN | DW_IC_CON_STOP_DET_IFADDRESSED;
-
-	dev->mode = DW_IC_SLAVE;
 }
 EXPORT_SYMBOL_GPL(i2c_dw_configure_slave);
 
-int i2c_dw_probe_slave(struct dw_i2c_dev *dev)
-{
-	if (dev->flags & ACCESS_POLLING)
-		return -EOPNOTSUPP;
-
-	return 0;
-}
-
 MODULE_AUTHOR("Luis Oliveira <lolivei@synopsys.com>");
 MODULE_DESCRIPTION("Synopsys DesignWare I2C bus slave adapter");
 MODULE_LICENSE("GPL v2");
-- 
2.50.1

