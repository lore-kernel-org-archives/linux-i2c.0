From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCH] i2c: mv64xxx: add suspend/resume support
Date: Thu, 22 Dec 2016 16:54:02 +0100
Message-ID: <1482422042-30201-1-git-send-email-thomas.petazzoni@free-electrons.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:49855 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758658AbcLVPyK (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 22 Dec 2016 10:54:10 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Grzegorz Jaszczyk <jaz@semihalf.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

From: Grzegorz Jaszczyk <jaz@semihalf.com>

This commit implements suspend/resume support in the mv64xxx I2C
controller driver. There is no need to implement a ->suspend() hook, as
calling mv64xxx_i2c_hw_init() at ->resume() time is enough.

Signed-off-by: Grzegorz Jaszczyk <jaz@semihalf.com>
Reviewed-by: Nadav Haklai <nadavh@marvell.com>
Reviewed-by: Lior Amsalem <alior@marvell.com>
Tested-by: Lior Amsalem <alior@marvell.com>
[Thomas: switch to dev_pm_ops, fix build warning when !PM.]
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/i2c/busses/i2c-mv64xxx.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
index b4dec08..a50bd68 100644
--- a/drivers/i2c/busses/i2c-mv64xxx.c
+++ b/drivers/i2c/busses/i2c-mv64xxx.c
@@ -977,11 +977,32 @@ mv64xxx_i2c_remove(struct platform_device *dev)
 	return 0;
 }
 
+#ifdef CONFIG_PM
+static int mv64xxx_i2c_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct mv64xxx_i2c_data *drv_data = platform_get_drvdata(pdev);
+
+	mv64xxx_i2c_hw_init(drv_data);
+
+	return 0;
+}
+
+static const struct dev_pm_ops mv64xxx_i2c_pm = {
+	.resume = mv64xxx_i2c_resume,
+};
+
+#define mv64xxx_i2c_pm_ops (&mv64xxx_i2c_pm)
+#else
+#define mv64xxx_i2c_pm_ops NULL
+#endif
+
 static struct platform_driver mv64xxx_i2c_driver = {
 	.probe	= mv64xxx_i2c_probe,
 	.remove	= mv64xxx_i2c_remove,
 	.driver	= {
 		.name	= MV64XXX_I2C_CTLR_NAME,
+		.pm     = mv64xxx_i2c_pm_ops,
 		.of_match_table = mv64xxx_i2c_of_match_table,
 	},
 };
-- 
2.7.4
