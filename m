From: Gao Pan <pandy.gao@nxp.com>
Subject: [Patch V3] i2c: imx-lpi2c: add VLLS mode support
Date: Tue, 17 Jan 2017 18:20:55 +0800
Message-ID: <1484648455-5454-1-git-send-email-pandy.gao@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-eopbgr10053.outbound.protection.outlook.com ([40.107.1.53]:57408
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751017AbdAQKiu (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 17 Jan 2017 05:38:50 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de, wsa-dev@sang-engineering.com, vz@mleia.com
Cc: linux-i2c@vger.kernel.org, pandy.gao@nxp.com, frank.li@nxp.com

When system enters VLLS mode, module power is turned off. As a result,
all registers are reset to HW default value. After exiting VLLS mode,
registers are still in default mode. As a result, the pinctrl settings
are incorrect, which will affect the module function.

The patch recovers the pinctrl setting when exit VLLS mode.

Signed-off-by: Gao Pan <pandy.gao@nxp.com>
---
V2:
 -drop "#else branch" and IMX_LPI2C_PM completely
 -pm = &imx_lpi2c_pm

V3:
 -remove unnecessary #ifdef

 drivers/i2c/busses/i2c-imx-lpi2c.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/i2c/busses/i2c-imx-lpi2c.c b/drivers/i2c/busses/i2c-imx-lpi2c.c
index c62b7cd..5a85c49 100644
--- a/drivers/i2c/busses/i2c-imx-lpi2c.c
+++ b/drivers/i2c/busses/i2c-imx-lpi2c.c
@@ -636,12 +636,31 @@ static int lpi2c_imx_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int lpi2c_imx_suspend(struct device *dev)
+{
+	pinctrl_pm_select_sleep_state(dev);
+
+	return 0;
+}
+
+static int lpi2c_imx_resume(struct device *dev)
+{
+	pinctrl_pm_select_default_state(dev);
+
+	return 0;
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(imx_lpi2c_pm, lpi2c_imx_suspend, lpi2c_imx_resume);
+
 static struct platform_driver lpi2c_imx_driver = {
 	.probe = lpi2c_imx_probe,
 	.remove = lpi2c_imx_remove,
 	.driver = {
 		.name = DRIVER_NAME,
 		.of_match_table = lpi2c_imx_of_match,
+		.pm = &imx_lpi2c_pm,
 	},
 };
 
-- 
1.9.1
