From: Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>
Subject: [PATCH 2/2] i2c/designware: Provide optional i2c bus recovery function
Date: Fri, 24 Feb 2012 17:01:16 +0530
Message-ID: <351031347b845920a0ea78e7491d955137e3d7aa.1330082915.git.viresh.kumar@st.com>
References: <0ca1d8990c23a45193a32d0e7e889620b995af59.1330082915.git.viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <0ca1d8990c23a45193a32d0e7e889620b995af59.1330082915.git.viresh.kumar-qxv4g6HH51o@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
Cc: armando.visconti-qxv4g6HH51o@public.gmane.org, shiraz.hashim-qxv4g6HH51o@public.gmane.org, vipin.kumar-qxv4g6HH51o@public.gmane.org, rajeev-dlh.kumar-qxv4g6HH51o@public.gmane.org, deepak.sikri-qxv4g6HH51o@public.gmane.org, vipulkumar.samar-qxv4g6HH51o@public.gmane.org, amit.virdi-qxv4g6HH51o@public.gmane.org, viresh.kumar-qxv4g6HH51o@public.gmane.org, pratyush.anand-qxv4g6HH51o@public.gmane.org, bhupesh.sharma-qxv4g6HH51o@public.gmane.org, viresh.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, bhavna.yadav-qxv4g6HH51o@public.gmane.org, vincenzo.frascino-qxv4g6HH51o@public.gmane.org, mirko.gardi-qxv4g6HH51o@public.gmane.org, salvatore.dedominicis-qxv4g6HH51o@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

From: Vincenzo Frascino <vincenzo.frascino-qxv4g6HH51o@public.gmane.org>

Add optional i2c_recover_bus() function to the Synopsys DesignWare I2C adapter
driver that performs i2c bus recovery after timeout. The scope of this routine
is to define i2c bus recovery procedure as specified in the i2c protocol Rev. 03
section 3.16 titled "Bus clear".

Since the Designware I2C controller doesn't provide direct control over SDA and
SCL lines hence the intent is to let platform try to recover the bus if they
have the capability to take control of I2C pads and follow the recovery
protocol.

Signed-off-by: Vincenzo Frascino <vincenzo.frascino-qxv4g6HH51o@public.gmane.org>
Signed-off-by: Shiraz Hashim <shiraz.hashim-qxv4g6HH51o@public.gmane.org>
Signed-off-by: Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>
---
 drivers/i2c/busses/i2c-designware-core.c    |    4 +++
 drivers/i2c/busses/i2c-designware-core.h    |    3 +-
 drivers/i2c/busses/i2c-designware-platdrv.c |    8 ++++++
 include/linux/i2c/i2c-designware.h          |   33 +++++++++++++++++++++++++++
 4 files changed, 47 insertions(+), 1 deletions(-)
 create mode 100644 include/linux/i2c/i2c-designware.h

diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
index df87992..91d9357 100644
--- a/drivers/i2c/busses/i2c-designware-core.c
+++ b/drivers/i2c/busses/i2c-designware-core.c
@@ -525,6 +525,10 @@ i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 	ret = wait_for_completion_interruptible_timeout(&dev->cmd_complete, HZ);
 	if (ret == 0) {
 		dev_err(dev->dev, "controller timed out\n");
+		if (dev->i2c_recover_bus) {
+			dev_info(dev->dev, "try i2c bus recovery\n");
+			dev->i2c_recover_bus(dev->recovery_data);
+		}
 		i2c_dw_init(dev);
 		ret = -ETIMEDOUT;
 		goto done;
diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
index 02d1a2d..e2f3119 100644
--- a/drivers/i2c/busses/i2c-designware-core.h
+++ b/drivers/i2c/busses/i2c-designware-core.h
@@ -34,7 +34,6 @@
 #define DW_IC_CON_RESTART_EN		0x20
 #define DW_IC_CON_SLAVE_DISABLE		0x40
 
-
 /**
  * struct dw_i2c_dev - private i2c-designware data
  * @dev: driver model device node
@@ -88,6 +87,8 @@ struct dw_i2c_dev {
 	u32			master_cfg;
 	unsigned int		tx_fifo_depth;
 	unsigned int		rx_fifo_depth;
+	void			(*i2c_recover_bus)(void *);
+	void			*recovery_data;
 };
 
 extern u32 dw_readl(struct dw_i2c_dev *dev, int offset);
diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index c5ac2dc..2237398 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -29,6 +29,7 @@
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/i2c.h>
+#include <linux/i2c/i2c-designware.h>
 #include <linux/clk.h>
 #include <linux/errno.h>
 #include <linux/sched.h>
@@ -55,6 +56,7 @@ static int __devinit dw_i2c_probe(struct platform_device *pdev)
 	struct dw_i2c_dev *dev;
 	struct i2c_adapter *adap;
 	struct resource *mem, *ioarea;
+	struct i2c_dw_pdata *pdata;
 	int irq, r;
 
 	/* NOTE: driver uses the static register mapping */
@@ -98,6 +100,12 @@ static int __devinit dw_i2c_probe(struct platform_device *pdev)
 	}
 	clk_enable(dev->clk);
 
+	pdata = dev_get_platdata(&pdev->dev);
+	if (pdata && pdata->i2c_recover_bus) {
+		dev->i2c_recover_bus = pdata->i2c_recover_bus;
+		dev->recovery_data = &pdev;
+	}
+
 	dev->functionality =
 		I2C_FUNC_I2C |
 		I2C_FUNC_10BIT_ADDR |
diff --git a/include/linux/i2c/i2c-designware.h b/include/linux/i2c/i2c-designware.h
new file mode 100644
index 0000000..e40ad85
--- /dev/null
+++ b/include/linux/i2c/i2c-designware.h
@@ -0,0 +1,33 @@
+/*
+ * Synopsys DesignWare I2C adapter driver's platform data
+ *
+ * Copyright (C) 2012 ST Microelectronics.
+ * Author: Vincenzo Frascino <vincenzo.frascino-qxv4g6HH51o@public.gmane.org>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+#ifndef I2C_DESIGNWARE_H
+#define I2C_DESIGNWARE_H
+
+#include <linux/platform_device.h>
+
+/* I2C Designware Platform Data */
+struct i2c_dw_pdata {
+	/*
+	 * The scope of this routine is to define i2c bus recovery procedure
+	 * as specified in the i2c protocol Rev. 03 section 3.16 titled
+	 * "Bus clear".
+	 * Its implementation is platform dependant.
+	 */
+	void (*i2c_recover_bus)(void *);
+};
+
+#endif /* I2C_DESIGNWARE_H */
-- 
1.7.8.110.g4cb5d
