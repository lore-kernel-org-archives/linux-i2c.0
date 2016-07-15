From: Alexey Khoroshilov <khoroshilov@ispras.ru>
Subject: [PATCH] i2c: efm32: fix a failure path in efm32_i2c_probe()
Date: Sat, 16 Jul 2016 02:36:38 +0300
Message-ID: <1468625798-6767-1-git-send-email-khoroshilov@ispras.ru>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail.ispras.ru ([83.149.199.45]:48236 "EHLO mail.ispras.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751431AbcGOXg6 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 15 Jul 2016 19:36:58 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <kernel@pengutronix.de>
Cc: Alexey Khoroshilov <khoroshilov@ispras.ru>, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org

There is the only failure path in efm32_i2c_probe(),
where clk_disable_unprepare() is missed.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
---
 drivers/i2c/busses/i2c-efm32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-efm32.c b/drivers/i2c/busses/i2c-efm32.c
index 8eff62738877..e253598d764c 100644
--- a/drivers/i2c/busses/i2c-efm32.c
+++ b/drivers/i2c/busses/i2c-efm32.c
@@ -433,7 +433,7 @@ static int efm32_i2c_probe(struct platform_device *pdev)
 	ret = request_irq(ddata->irq, efm32_i2c_irq, 0, DRIVER_NAME, ddata);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to request irq (%d)\n", ret);
-		return ret;
+		goto err_disable_clk;
 	}
 
 	ret = i2c_add_adapter(&ddata->adapter);
-- 
1.9.1
