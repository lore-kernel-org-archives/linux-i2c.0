From: Austin Christ <austinwc@codeaurora.org>
Subject: [PATCH] i2c: qup: Add shutdown method
Date: Tue, 16 Jan 2018 14:35:33 -0700
Message-ID: <1516138534-30842-1-git-send-email-austinwc@codeaurora.org>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:56314 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750790AbeAPVfl (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 16 Jan 2018 16:35:41 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc: Austin Christ <austinwc@codeaurora.org>

This shutdown method disables I2C to avoid corrupting a new kernel
started with kexec.

Signed-off-by: Austin Christ <austinwc@codeaurora.org>
---
 drivers/i2c/busses/i2c-qup.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
index 08f8e01..b96f01a 100644
--- a/drivers/i2c/busses/i2c-qup.c
+++ b/drivers/i2c/busses/i2c-qup.c
@@ -1651,12 +1651,16 @@ static int qup_i2c_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static void qup_i2c_shutdown(struct platform_device *pdev)
+{
+	qup_i2c_remove(pdev);
+}
+
 #ifdef CONFIG_PM
 static int qup_i2c_pm_suspend_runtime(struct device *device)
 {
 	struct qup_i2c_dev *qup = dev_get_drvdata(device);
 
-	dev_dbg(device, "pm_runtime: suspending...\n");
 	qup_i2c_disable_clocks(qup);
 	return 0;
 }
@@ -1717,6 +1721,7 @@ static int qup_i2c_resume(struct device *device)
 static struct platform_driver qup_i2c_driver = {
 	.probe  = qup_i2c_probe,
 	.remove = qup_i2c_remove,
+	.shutdown = qup_i2c_shutdown,
 	.driver = {
 		.name = "i2c_qup",
 		.pm = &qup_i2c_qup_pm_ops,
-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
