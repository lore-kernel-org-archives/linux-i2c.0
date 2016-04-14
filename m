From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 2/2] i2c: s3c2410: Use SET_NOIRQ_SYSTEM_SLEEP_PM_OPS instead
 of open-coded
Date: Thu, 14 Apr 2016 09:08:55 +0800
Message-ID: <1460596135.6630.2.camel@ingics.com>
References: <1460596084.6630.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pa0-f65.google.com ([209.85.220.65]:36466 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750952AbcDNBI7 (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Wed, 13 Apr 2016 21:08:59 -0400
Received: by mail-pa0-f65.google.com with SMTP id k3so5230822pav.3
        for <linux-i2c@vger.kernel.org>; Wed, 13 Apr 2016 18:08:59 -0700 (PDT)
In-Reply-To: <1460596084.6630.1.camel@ingics.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-i2c@vger.kernel.org, linux-samsung-soc@vger.kernel.org

Use SET_NOIRQ_SYSTEM_SLEEP_PM_OPS to simplify the code.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/i2c/busses/i2c-s3c2410.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3c2410.c
index 362a6de..1bc7563 100644
--- a/drivers/i2c/busses/i2c-s3c2410.c
+++ b/drivers/i2c/busses/i2c-s3c2410.c
@@ -1316,14 +1316,8 @@ static int s3c24xx_i2c_resume_noirq(struct device *dev)
 
 #ifdef CONFIG_PM
 static const struct dev_pm_ops s3c24xx_i2c_dev_pm_ops = {
-#ifdef CONFIG_PM_SLEEP
-	.suspend_noirq = s3c24xx_i2c_suspend_noirq,
-	.resume_noirq = s3c24xx_i2c_resume_noirq,
-	.freeze_noirq = s3c24xx_i2c_suspend_noirq,
-	.thaw_noirq = s3c24xx_i2c_resume_noirq,
-	.poweroff_noirq = s3c24xx_i2c_suspend_noirq,
-	.restore_noirq = s3c24xx_i2c_resume_noirq,
-#endif
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(s3c24xx_i2c_suspend_noirq,
+				      s3c24xx_i2c_resume_noirq)
 };
 
 #define S3C24XX_DEV_PM_OPS (&s3c24xx_i2c_dev_pm_ops)
-- 
2.5.0
