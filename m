From: Eric Anholt <eric@anholt.net>
Subject: [PATCH] i2c: bcm2835: Don't complain on -EPROBE_DEFER from getting our clock
Date: Thu, 18 Feb 2016 17:12:55 -0800
Message-ID: <1455844375-15019-1-git-send-email-eric@anholt.net>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from gabe.freedesktop.org ([131.252.210.177]:48008 "EHLO
	gabe.freedesktop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1947768AbcBSBM5 (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 18 Feb 2016 20:12:57 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, linux-i2c@vger.kernel.org, Eric Anholt <eric@anholt.net>

Fixes dmesg spam when we just need to wait a moment for the clock
driver to probe.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 drivers/i2c/busses/i2c-bcm2835.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-bcm2835.c b/drivers/i2c/busses/i2c-bcm2835.c
index 818b051..d4f3239 100644
--- a/drivers/i2c/busses/i2c-bcm2835.c
+++ b/drivers/i2c/busses/i2c-bcm2835.c
@@ -253,7 +253,8 @@ static int bcm2835_i2c_probe(struct platform_device *pdev)
 
 	i2c_dev->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(i2c_dev->clk)) {
-		dev_err(&pdev->dev, "Could not get clock\n");
+		if (PTR_ERR(i2c_dev->clk) != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "Could not get clock\n");
 		return PTR_ERR(i2c_dev->clk);
 	}
 
-- 
2.7.0
