From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v2 3/6] i2c: designware: allow IP specific sda_hold_time
Date: Tue, 31 Jul 2018 15:47:37 +0200
Message-ID: <20180731134740.441-4-alexandre.belloni@bootlin.com>
References: <20180731134740.441-1-alexandre.belloni@bootlin.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180731134740.441-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, James Hogan <jhogan@kernel.org>
Cc: Paul Burton <paul.burton@mips.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Allan Nielsen <allan.nielsen@microsemi.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>
List-Id: linux-i2c@vger.kernel.org

Because some old designware IPs were not supporting setting an SDA hold
time, vendors developed their own solution. Add a way for the final driver
to provide its own SDA hold time handling.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

Changes in v2:
 - rebased on i2c-next
 - moved the if (dev->set_sda_hold_time) after the version test

 drivers/i2c/busses/i2c-designware-common.c | 2 ++
 drivers/i2c/busses/i2c-designware-core.h   | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/i2c/busses/i2c-designware-common.c b/drivers/i2c/busses/i2c-designware-common.c
index e67d6c7d552c..463906a02c7f 100644
--- a/drivers/i2c/busses/i2c-designware-common.c
+++ b/drivers/i2c/busses/i2c-designware-common.c
@@ -201,6 +201,8 @@ int i2c_dw_set_sda_hold(struct dw_i2c_dev *dev)
 		dev_dbg(dev->dev, "SDA Hold Time TX:RX = %d:%d\n",
 			dev->sda_hold_time & ~(u32)DW_IC_SDA_HOLD_RX_MASK,
 			dev->sda_hold_time >> DW_IC_SDA_HOLD_RX_SHIFT);
+	} else if (dev->set_sda_hold_time) {
+		dev->set_sda_hold_time(dev);
 	} else if (dev->sda_hold_time) {
 		dev_warn(dev->dev,
 			"Hardware too old to adjust SDA hold time.\n");
diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
index 70c188d6fb6b..870444bbbcc4 100644
--- a/drivers/i2c/busses/i2c-designware-core.h
+++ b/drivers/i2c/busses/i2c-designware-core.h
@@ -269,6 +269,7 @@ struct dw_i2c_dev {
 	void			(*disable)(struct dw_i2c_dev *dev);
 	void			(*disable_int)(struct dw_i2c_dev *dev);
 	int			(*init)(struct dw_i2c_dev *dev);
+	int			(*set_sda_hold_time)(struct dw_i2c_dev *dev);
 	int			mode;
 	struct i2c_bus_recovery_info rinfo;
 };
-- 
2.18.0
