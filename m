From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] i2c: jz4780: Fix return value if probe fails
Date: Tue, 30 Jun 2015 11:41:58 +0800
Message-ID: <1435635718.14315.3.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Zubair Lutfullah Kakakhel <Zubair.Kakakhel-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Current code returns 0 if fails to read clock-frequency DT property,
fix it. Also add checking return value of clk_prepare_enable and
propagate return value of devm_request_irq.

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/i2c/busses/i2c-jz4780.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-jz4780.c b/drivers/i2c/busses/i2c-jz4780.c
index 19b2d68..f325663 100644
--- a/drivers/i2c/busses/i2c-jz4780.c
+++ b/drivers/i2c/busses/i2c-jz4780.c
@@ -764,12 +764,15 @@ static int jz4780_i2c_probe(struct platform_device *pdev)
 	if (IS_ERR(i2c->clk))
 		return PTR_ERR(i2c->clk);
 
-	clk_prepare_enable(i2c->clk);
+	ret = clk_prepare_enable(i2c->clk);
+	if (ret)
+		return ret;
 
-	if (of_property_read_u32(pdev->dev.of_node, "clock-frequency",
-				 &clk_freq)) {
+	ret = of_property_read_u32(pdev->dev.of_node, "clock-frequency",
+				   &clk_freq);
+	if (ret) {
 		dev_err(&pdev->dev, "clock-frequency not specified in DT");
-		return clk_freq;
+		goto err;
 	}
 
 	i2c->speed = clk_freq / 1000;
@@ -790,10 +793,8 @@ static int jz4780_i2c_probe(struct platform_device *pdev)
 	i2c->irq = platform_get_irq(pdev, 0);
 	ret = devm_request_irq(&pdev->dev, i2c->irq, jz4780_i2c_irq, 0,
 			       dev_name(&pdev->dev), i2c);
-	if (ret) {
-		ret = -ENODEV;
+	if (ret)
 		goto err;
-	}
 
 	ret = i2c_add_adapter(&i2c->adap);
 	if (ret < 0) {
-- 
2.1.0
