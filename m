From: Alexey Khoroshilov <khoroshilov@ispras.ru>
Subject: [PATCH] i2c: designware: balance clk enable/disable on removal
Date: Sat, 30 Jan 2016 01:31:36 +0300
Message-ID: <1454106696-5867-1-git-send-email-khoroshilov@ispras.ru>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail.ispras.ru ([83.149.199.45]:58389 "EHLO mail.ispras.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753570AbcA2Wbp (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 29 Jan 2016 17:31:45 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org, Alexey Khoroshilov <khoroshilov@ispras.ru>

It seems clk_disable_unprepare() is missed in dw_i2c_plat_remove(),
so the patch adds it.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
---
 drivers/i2c/busses/i2c-designware-platdrv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 438f1b4964c0..8f19b7b81fe0 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -267,6 +267,7 @@ static int dw_i2c_plat_remove(struct platform_device *pdev)
 	i2c_del_adapter(&dev->adapter);
 
 	i2c_dw_disable(dev);
+	i2c_dw_plat_prepare_clk(dev, false);
 
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_put_sync(&pdev->dev);
-- 
1.9.1
