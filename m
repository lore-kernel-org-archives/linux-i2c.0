From: Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>
Subject: [PATCH V3 2/2] i2c/designware: Provide i2c bus recovery support
Date: Fri, 2 Mar 2012 11:53:43 +0530
Message-ID: <d1a33d23e876ee2760002647151927e382a721c8.1330669025.git.viresh.kumar@st.com>
References: <cover.1330669025.git.viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1330669025.git.viresh.kumar-qxv4g6HH51o@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org, spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, viresh.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, ml.lawnick-Mmb7MZpHnFY@public.gmane.org, Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>, Vincenzo Frascino <vincenzo.frascino-qxv4g6HH51o@public.gmane.org>, Shiraz Hashim <shiraz.hashim-qxv4g6HH51o@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Add bus recovery support for designware_i2c controller. It uses generic gpio
based i2c_gpio_recover_bus() routine.

Signed-off-by: Vincenzo Frascino <vincenzo.frascino-qxv4g6HH51o@public.gmane.org>
Signed-off-by: Shiraz Hashim <shiraz.hashim-qxv4g6HH51o@public.gmane.org>
Signed-off-by: Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>
---
 drivers/i2c/busses/i2c-designware-core.c    |    7 +++-
 drivers/i2c/busses/i2c-designware-platdrv.c |   24 +++++++++++++
 include/linux/i2c/i2c-designware.h          |   49 +++++++++++++++++++++++++++
 3 files changed, 79 insertions(+), 1 deletions(-)
 create mode 100644 include/linux/i2c/i2c-designware.h

diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
index df87992..db70fcb 100644
--- a/drivers/i2c/busses/i2c-designware-core.c
+++ b/drivers/i2c/busses/i2c-designware-core.c
@@ -525,7 +525,12 @@ i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 	ret = wait_for_completion_interruptible_timeout(&dev->cmd_complete, HZ);
 	if (ret == 0) {
 		dev_err(dev->dev, "controller timed out\n");
-		i2c_dw_init(dev);
+		if (adap->bus_recovery_info &&
+				adap->bus_recovery_info->recover_bus) {
+			dev_dbg(dev->dev, "try i2c bus recovery\n");
+			adap->bus_recovery_info->recover_bus(adap);
+		}
+
 		ret = -ETIMEDOUT;
 		goto done;
 	} else if (ret < 0)
diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index f08d024..76bf108 100644
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
@@ -45,6 +46,11 @@ static struct i2c_algorithm i2c_dw_algo = {
 	.master_xfer	= i2c_dw_xfer,
 	.functionality	= i2c_dw_func,
 };
+
+static struct i2c_bus_recovery_info dw_recovery_info = {
+	.is_gpio_recovery = true,
+};
+
 static u32 i2c_dw_get_clk_rate_khz(struct dw_i2c_dev *dev)
 {
 	return clk_get_rate(dev->clk)/1000;
@@ -55,6 +61,7 @@ static int __devinit dw_i2c_probe(struct platform_device *pdev)
 	struct dw_i2c_dev *dev;
 	struct i2c_adapter *adap;
 	struct resource *mem, *ioarea;
+	struct i2c_dw_pdata *pdata;
 	int irq, r;
 
 	/* NOTE: driver uses the static register mapping */
@@ -141,6 +148,23 @@ static int __devinit dw_i2c_probe(struct platform_device *pdev)
 	adap->dev.parent = &pdev->dev;
 	adap->dev.of_node = pdev->dev.of_node;
 
+	/* Bus recovery support */
+	pdata = dev_get_platdata(&pdev->dev);
+	if (pdata) {
+		dw_recovery_info.get_gpio = pdata->get_gpio;
+		dw_recovery_info.put_gpio = pdata->put_gpio;
+		dw_recovery_info.scl_gpio = pdata->scl_gpio;
+		dw_recovery_info.scl_gpio_flags = pdata->scl_gpio_flags;
+		dw_recovery_info.clock_rate_khz = clk_get_rate(dev->clk) / 1000;
+
+		if (!pdata->skip_sda_polling) {
+			dw_recovery_info.sda_gpio = pdata->sda_gpio;
+			dw_recovery_info.sda_gpio_flags = pdata->sda_gpio_flags;
+		}
+
+		adap->bus_recovery_info = &dw_recovery_info;
+	}
+
 	adap->nr = pdev->id;
 	r = i2c_add_numbered_adapter(adap);
 	if (r) {
diff --git a/include/linux/i2c/i2c-designware.h b/include/linux/i2c/i2c-designware.h
new file mode 100644
index 0000000..341bd4c
--- /dev/null
+++ b/include/linux/i2c/i2c-designware.h
@@ -0,0 +1,49 @@
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
+/*
+ * struct i2c_dw_pdata - Designware I2c platform data
+ * @scl_gpio: gpio number of the scl line.
+ * @scl_gpio_flags: flag for gpio_request_one of scl_gpio. 0 implies
+ *	GPIOF_OUT_INIT_LOW.
+ * @get_gpio: called before recover_bus() to get padmux configured for scl line
+ *	as gpio. Only required if is_gpio_recovery == true
+ * @put_gpio: called after recover_bus() to get padmux configured for scl line
+ *	as scl. Only required if is_gpio_recovery == true
+ * @skip_sda_polling: if true, bus recovery will not poll sda line to check if
+ *	it became high or not. Below are required only if this is false.
+ * @sda_gpio: gpio number of the sda line.
+ * @sda_gpio_flags: flag for gpio_request_one of sda_gpio. 0 implies
+ *	GPIOF_OUT_INIT_LOW.
+ */
+struct i2c_dw_pdata {
+	int scl_gpio;
+	int scl_gpio_flags;
+	int (*get_gpio)(unsigned gpio);
+	int (*put_gpio)(unsigned gpio);
+
+	/* sda polling specific */
+	bool skip_sda_polling;
+	int sda_gpio;
+	int sda_gpio_flags;
+};
+
+#endif /* I2C_DESIGNWARE_H */
-- 
1.7.8.110.g4cb5d
