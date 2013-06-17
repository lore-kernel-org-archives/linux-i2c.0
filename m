From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH V10 Resend] i2c/designware: Provide i2c bus recovery support
Date: Mon, 17 Jun 2013 18:46:45 +0530
Message-ID: <70c7ee79478cc2b89ad876d814207c6433e26a59.1371474881.git.viresh.kumar@linaro.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
Cc: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Vincenzo Frascino <vincenzo.frascino-qxv4g6HH51o@public.gmane.org>, Shiraz Hashim <shiraz.hashim-qxv4g6HH51o@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Add bus recovery support for designware_i2c controller. It uses generic gpio
based i2c_gpio_recover_bus() routine. Platforms need to pass struct
i2c_bus_recovery_info as platform data to designware I2C controller.

Signed-off-by: Vincenzo Frascino <vincenzo.frascino-qxv4g6HH51o@public.gmane.org>
Signed-off-by: Shiraz Hashim <shiraz.hashim-qxv4g6HH51o@public.gmane.org>
Signed-off-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---

This patch isn't drawing attention since sometime, so sending it again.

 drivers/i2c/busses/i2c-designware-core.c    | 5 ++++-
 drivers/i2c/busses/i2c-designware-platdrv.c | 6 ++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
index c41ca63..5ecb2f0 100644
--- a/drivers/i2c/busses/i2c-designware-core.c
+++ b/drivers/i2c/busses/i2c-designware-core.c
@@ -583,7 +583,10 @@ i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 	ret = wait_for_completion_interruptible_timeout(&dev->cmd_complete, HZ);
 	if (ret == 0) {
 		dev_err(dev->dev, "controller timed out\n");
-		i2c_dw_init(dev);
+
+		if (i2c_recover_bus(adap) < 0)
+			i2c_dw_init(dev);
+
 		ret = -ETIMEDOUT;
 		goto done;
 	} else if (ret < 0)
diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 35b70a1..c3ada3e 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -162,6 +162,12 @@ static int dw_i2c_probe(struct platform_device *pdev)
 	adap->dev.parent = &pdev->dev;
 	adap->dev.of_node = pdev->dev.of_node;
 
+	/* Bus recovery support */
+	adap->bus_recovery_info = dev_get_platdata(&pdev->dev);
+	if (adap->bus_recovery_info)
+		adap->bus_recovery_info->recover_bus =
+			i2c_generic_gpio_recovery;
+
 	r = i2c_add_numbered_adapter(adap);
 	if (r) {
 		dev_err(&pdev->dev, "failure adding adapter\n");
-- 
1.7.12.rc2.18.g61b472e
