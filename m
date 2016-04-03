From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH] i2c: jz4780: prevent potential division by zero
Date: Sun,  3 Apr 2016 23:32:00 +0200
Message-ID: <1459719125-27320-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:54934 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751569AbcDCVcR (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sun, 3 Apr 2016 17:32:17 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>

Make sure we don't OOPS in case clock-frequency is set to 0 in a DT. The
variable set here is later used as a divisor.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/i2c/busses/i2c-jz4780.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-jz4780.c b/drivers/i2c/busses/i2c-jz4780.c
index f325663c27c532..597408fc6834fc 100644
--- a/drivers/i2c/busses/i2c-jz4780.c
+++ b/drivers/i2c/busses/i2c-jz4780.c
@@ -770,7 +770,7 @@ static int jz4780_i2c_probe(struct platform_device *pdev)
 
 	ret = of_property_read_u32(pdev->dev.of_node, "clock-frequency",
 				   &clk_freq);
-	if (ret) {
+	if (ret || clk_freq == 0) {
 		dev_err(&pdev->dev, "clock-frequency not specified in DT");
 		goto err;
 	}
-- 
2.7.0
