From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH v2] i2c: efm32: Prevent potential division by zero
Date: Thu, 14 Apr 2016 17:49:35 +0800
Message-ID: <1460627375.17638.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pa0-f68.google.com ([209.85.220.68]:34609 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751205AbcDNJtk (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 14 Apr 2016 05:49:40 -0400
Received: by mail-pa0-f68.google.com with SMTP id hb4so6416498pac.1
        for <linux-i2c@vger.kernel.org>; Thu, 14 Apr 2016 02:49:40 -0700 (PDT)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <kernel@pengutronix.de>, linux-i2c@vger.kernel.org

Make sure we don't OOPS in case clock-frequency is set to 0 in a DT. The
variable set here is later used as a divisor.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
Hi Uwe,
If my understand is correct, you prefer to make it return error rather
than using default frequency setting if DT setting is wrong.

v2: Make probe return error instead of using default frequency.

 drivers/i2c/busses/i2c-efm32.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/i2c/busses/i2c-efm32.c b/drivers/i2c/busses/i2c-efm32.c
index 8eff627..7c0636e 100644
--- a/drivers/i2c/busses/i2c-efm32.c
+++ b/drivers/i2c/busses/i2c-efm32.c
@@ -395,6 +395,13 @@ static int efm32_i2c_probe(struct platform_device *pdev)
 		frequency = 100000;
 		dev_info(&pdev->dev, "defaulting to 100 kHz\n");
 	}
+
+	if (frequency == 0) {
+		dev_err(&pdev->dev, "Invalid clock-frequency\n");
+		ret = -EINVAL;
+		goto err_disable_clk;
+	}
+
 	ddata->frequency = frequency;
 
 	rate = clk_get_rate(ddata->clk);
-- 
2.5.0
