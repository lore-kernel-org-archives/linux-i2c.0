From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH] i2c: jz4780: really prevent potential division by zero
Date: Fri,  8 Apr 2016 12:03:47 +0200
Message-ID: <1460109827-3608-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:55764 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753756AbcDHKED (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 8 Apr 2016 06:04:03 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>, Axel Lin <axel.lin@ingics.com>, Wolfram Sang <wsa@the-dreams.de>

Make sure that 'ret' is populated before we leave and check the variable
which is actually used as a divisor. Add missing '\n' while we are here.

Reported-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Fixes: 34cf2acdafaa ("i2c: jz4780: prevent potential division by zero")
---
 drivers/i2c/busses/i2c-jz4780.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-jz4780.c b/drivers/i2c/busses/i2c-jz4780.c
index 597408fc6834fc..ba14a863b451f9 100644
--- a/drivers/i2c/busses/i2c-jz4780.c
+++ b/drivers/i2c/busses/i2c-jz4780.c
@@ -770,12 +770,17 @@ static int jz4780_i2c_probe(struct platform_device *pdev)
 
 	ret = of_property_read_u32(pdev->dev.of_node, "clock-frequency",
 				   &clk_freq);
-	if (ret || clk_freq == 0) {
-		dev_err(&pdev->dev, "clock-frequency not specified in DT");
+	if (ret) {
+		dev_err(&pdev->dev, "clock-frequency not specified in DT\n");
 		goto err;
 	}
 
 	i2c->speed = clk_freq / 1000;
+	if (i2c->speed == 0) {
+		ret = -EINVAL;
+		dev_err(&pdev->dev, "clock-frequency minimum is 1000\n");
+		goto err;
+	}
 	jz4780_i2c_set_speed(i2c);
 
 	dev_info(&pdev->dev, "Bus frequency is %d KHz\n", i2c->speed);
-- 
2.7.0
