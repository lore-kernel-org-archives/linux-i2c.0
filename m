From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v5 3/7] i2c: designware: allow IP specific sda_hold_time
Date: Fri, 31 Aug 2018 17:11:10 +0200
Message-ID: <20180831151114.25739-4-alexandre.belloni@bootlin.com>
References: <20180831151114.25739-1-alexandre.belloni@bootlin.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180831151114.25739-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, James Hogan <jhogan@kernel.org>, Paul Burton <paul.burton@mips.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Allan Nielsen <allan.nielsen@microchip.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>
List-Id: linux-i2c@vger.kernel.org

Because some old designware IPs were not supporting setting an SDA hold
time, vendors developed their own solution. Add a way for the final driver
to provide its own SDA hold time handling.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/i2c/busses/i2c-designware-common.c | 2 ++
 drivers/i2c/busses/i2c-designware-core.h   | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/i2c/busses/i2c-designware-common.c b/drivers/i2c/busses/i2c-designware-common.c
index 69ec4a791f23..36271cd75342 100644
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
index e367b1af4ab2..f6cad20a86ff 100644
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
2.19.0.rc1
