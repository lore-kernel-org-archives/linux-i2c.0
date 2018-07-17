From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 2/5] i2c: designware: allow IP specific sda_hold_time
Date: Tue, 17 Jul 2018 13:48:34 +0200
Message-ID: <20180717114837.21839-3-alexandre.belloni@bootlin.com>
References: <20180717114837.21839-1-alexandre.belloni@bootlin.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180717114837.21839-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, James Hogan <jhogan@kernel.org>
Cc: Paul Burton <paul.burton@mips.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Allan Nielsen <allan.nielsen@microsemi.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>
List-Id: linux-i2c@vger.kernel.org

Because some old designware IPs were not supporting setting an SDA hold
time, vendors developed their own solution. Add a way for the final driver
to provide its own SDA hold time handling.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/i2c/busses/i2c-designware-common.c | 6 ++++++
 drivers/i2c/busses/i2c-designware-core.h   | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/i2c/busses/i2c-designware-common.c b/drivers/i2c/busses/i2c-designware-common.c
index 9afc3e075b33..545b69d6be3c 100644
--- a/drivers/i2c/busses/i2c-designware-common.c
+++ b/drivers/i2c/busses/i2c-designware-common.c
@@ -297,6 +297,12 @@ void i2c_dw_set_sda_hold_time(struct dw_i2c_dev *dev)
 {
 	u32 reg;
 
+	if (dev->set_sda_hold_time) {
+		dev->set_sda_hold_time(dev);
+
+		return;
+	}
+
 	/* Configure SDA Hold Time if required. */
 	reg = dw_readl(dev, DW_IC_COMP_VERSION);
 	if (reg >= DW_IC_SDA_HOLD_MIN_VERS) {
diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
index bc43fb9ac1cf..b2778b6d8aca 100644
--- a/drivers/i2c/busses/i2c-designware-core.h
+++ b/drivers/i2c/busses/i2c-designware-core.h
@@ -283,6 +283,7 @@ struct dw_i2c_dev {
 	void			(*disable)(struct dw_i2c_dev *dev);
 	void			(*disable_int)(struct dw_i2c_dev *dev);
 	int			(*init)(struct dw_i2c_dev *dev);
+	int			(*set_sda_hold_time)(struct dw_i2c_dev *dev);
 	int			mode;
 	struct i2c_bus_recovery_info rinfo;
 };
-- 
2.18.0
