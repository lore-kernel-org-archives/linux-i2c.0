From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] i2c: nomadik: move runtime suspend of hw to _noirq
Date: Mon, 23 May 2016 14:59:16 +0200
Message-ID: <1464008356-21162-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-lb0-f171.google.com ([209.85.217.171]:33789 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753412AbcEWM72 (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Mon, 23 May 2016 08:59:28 -0400
Received: by mail-lb0-f171.google.com with SMTP id k7so34303086lbm.0
        for <linux-i2c@vger.kernel.org>; Mon, 23 May 2016 05:59:27 -0700 (PDT)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>

The runtime suspend of the hardware (declocking and pin control
resting) needs to happen in the *_noirq callbacks after all
hardware interrupts are disabled and we know there will be no
more I2C traffic in the system.

Cc: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/i2c/busses/i2c-nomadik.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
index bcd17e8cbcb4..c96a3e331bed 100644
--- a/drivers/i2c/busses/i2c-nomadik.c
+++ b/drivers/i2c/busses/i2c-nomadik.c
@@ -877,7 +877,7 @@ static irqreturn_t i2c_irq_handler(int irq, void *arg)
 }
 
 #ifdef CONFIG_PM_SLEEP
-static int nmk_i2c_suspend_late(struct device *dev)
+static int nmk_i2c_suspend_noirq(struct device *dev)
 {
 	int ret;
 
@@ -889,7 +889,7 @@ static int nmk_i2c_suspend_late(struct device *dev)
 	return 0;
 }
 
-static int nmk_i2c_resume_early(struct device *dev)
+static int nmk_i2c_resume_noirq(struct device *dev)
 {
 	return pm_runtime_force_resume(dev);
 }
@@ -931,7 +931,8 @@ static int nmk_i2c_runtime_resume(struct device *dev)
 #endif
 
 static const struct dev_pm_ops nmk_i2c_pm = {
-	SET_LATE_SYSTEM_SLEEP_PM_OPS(nmk_i2c_suspend_late, nmk_i2c_resume_early)
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(nmk_i2c_suspend_noirq,
+				      nmk_i2c_resume_noirq)
 	SET_RUNTIME_PM_OPS(nmk_i2c_runtime_suspend,
 			nmk_i2c_runtime_resume,
 			NULL)
-- 
2.4.11
