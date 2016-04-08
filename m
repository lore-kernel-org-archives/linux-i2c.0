From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] i2c: jz4780: Return error if clk_freq is set to 0
Date: Fri, 08 Apr 2016 15:59:32 +0800
Message-ID: <1460102372.5233.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33406 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757860AbcDHH7h (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Fri, 8 Apr 2016 03:59:37 -0400
Received: by mail-pf0-f196.google.com with SMTP id e190so8959533pfe.0
        for <linux-i2c@vger.kernel.org>; Fri, 08 Apr 2016 00:59:37 -0700 (PDT)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>, linux-i2c@vger.kernel.org

Current code returns 0 in probe if clk_freq is set to 0.
As a result, the probe success but the module does not work. Fix it.

Fixes: 34cf2acdafaa ("i2c: jz4780: prevent potential division by zero")
Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/i2c/busses/i2c-jz4780.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/i2c/busses/i2c-jz4780.c b/drivers/i2c/busses/i2c-jz4780.c
index 597408f..0b3ba8d 100644
--- a/drivers/i2c/busses/i2c-jz4780.c
+++ b/drivers/i2c/busses/i2c-jz4780.c
@@ -772,6 +772,8 @@ static int jz4780_i2c_probe(struct platform_device *pdev)
 				   &clk_freq);
 	if (ret || clk_freq == 0) {
 		dev_err(&pdev->dev, "clock-frequency not specified in DT");
+		if (ret == 0)
+			ret = -EINVAL;
 		goto err;
 	}
 
-- 
2.1.4
