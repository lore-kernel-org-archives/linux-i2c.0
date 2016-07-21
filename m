From: Grzegorz Jaszczyk <jaz@semihalf.com>
Subject: [PATCH] i2c: i2c-mv64xxx: add suspend/resume support
Date: Thu, 21 Jul 2016 12:39:33 +0200
Message-ID: <1469097573-17638-1-git-send-email-jaz@semihalf.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-lf0-f52.google.com ([209.85.215.52]:34377 "EHLO
	mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751346AbcGUKgU (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 21 Jul 2016 06:36:20 -0400
Received: by mail-lf0-f52.google.com with SMTP id l69so57905746lfg.1
        for <linux-i2c@vger.kernel.org>; Thu, 21 Jul 2016 03:36:19 -0700 (PDT)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, thomas.petazzoni@free-electrons.com, gregory.clement@free-electrons.com
Cc: mw@semihalf.com, jaz@semihalf.com, alior@marvell.com

There is no need to implement subroutine for suspend since there is no
data to store before suspending.

Signed-off-by: Grzegorz Jaszczyk <jaz@semihalf.com>
---
 drivers/i2c/busses/i2c-mv64xxx.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
index b4dec08..dc048e7 100644
--- a/drivers/i2c/busses/i2c-mv64xxx.c
+++ b/drivers/i2c/busses/i2c-mv64xxx.c
@@ -977,12 +977,24 @@ mv64xxx_i2c_remove(struct platform_device *dev)
 	return 0;
 }
 
+static int mv64xxx_i2c_resume(struct device *dev)
+{
+	struct mv64xxx_i2c_data *drv_data = dev_get_drvdata(dev);
+
+	mv64xxx_i2c_hw_init(drv_data);
+
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(mv64xxx_i2c_pm_ops, NULL, mv64xxx_i2c_resume);
+
 static struct platform_driver mv64xxx_i2c_driver = {
 	.probe	= mv64xxx_i2c_probe,
 	.remove	= mv64xxx_i2c_remove,
 	.driver	= {
 		.name	= MV64XXX_I2C_CTLR_NAME,
 		.of_match_table = mv64xxx_i2c_of_match_table,
+		.pm = &mv64xxx_i2c_pm_ops,
 	},
 };
 
-- 
1.8.3.1
