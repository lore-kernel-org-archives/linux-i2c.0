From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] i2c: at91: Handle return value of clk_prepare_enable
Date: Wed, 31 May 2017 12:27:44 +0530
Message-ID: <74b05c5180872e368970562535bc305728da4be8.1496211597.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33853 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751037AbdEaG57 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 31 May 2017 02:57:59 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: ludovic.desroches@microchip.com, wsa@the-dreams.de
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

clk_prepare_enable() can fail here and we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/i2c/busses/i2c-at91.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
index fabbb9e..2525cd9 100644
--- a/drivers/i2c/busses/i2c-at91.c
+++ b/drivers/i2c/busses/i2c-at91.c
@@ -1083,12 +1083,16 @@ static int at91_twi_probe(struct platform_device *pdev)
 		dev_err(dev->dev, "no clock defined\n");
 		return -ENODEV;
 	}
-	clk_prepare_enable(dev->clk);
+	rc = clk_prepare_enable(dev->clk);
+	if (rc)
+		return rc;
 
 	if (dev->dev->of_node) {
 		rc = at91_twi_configure_dma(dev, phy_addr);
-		if (rc == -EPROBE_DEFER)
+		if (rc == -EPROBE_DEFER) {
+			clk_disable_unprepare(dev->clk);
 			return rc;
+		}
 	}
 
 	if (!of_property_read_u32(pdev->dev.of_node, "atmel,fifo-size",
-- 
1.9.1
