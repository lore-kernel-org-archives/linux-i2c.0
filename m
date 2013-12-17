From: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 01/13] i2c: bcm2835: Use devm_request_irq()
Date: Tue, 17 Dec 2013 15:46:29 +0900
Message-ID: <001d01cefaf3$b743e4c0$25cbae40$%han@samsung.com>
References: <001601cefaf3$940d0040$bc2700c0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <001601cefaf3$940d0040$bc2700c0$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Content-language: ko
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: 'Wolfram Sang' <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Jingoo Han' <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Stephen Warren' <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Use devm_request_irq() to make cleanup paths simpler.

Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-bcm2835.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-bcm2835.c b/drivers/i2c/busses/i2c-bcm2835.c
index 77df97b..af60181 100644
--- a/drivers/i2c/busses/i2c-bcm2835.c
+++ b/drivers/i2c/busses/i2c-bcm2835.c
@@ -285,8 +285,8 @@ static int bcm2835_i2c_probe(struct platform_device *pdev)
 	}
 	i2c_dev->irq = irq->start;
 
-	ret = request_irq(i2c_dev->irq, bcm2835_i2c_isr, IRQF_SHARED,
-			  dev_name(&pdev->dev), i2c_dev);
+	ret = devm_request_irq(&pdev->dev, i2c_dev->irq, bcm2835_i2c_isr,
+			       IRQF_SHARED, dev_name(&pdev->dev), i2c_dev);
 	if (ret) {
 		dev_err(&pdev->dev, "Could not request IRQ\n");
 		return -ENODEV;
@@ -304,8 +304,6 @@ static int bcm2835_i2c_probe(struct platform_device *pdev)
 	bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_C, 0);
 
 	ret = i2c_add_adapter(adap);
-	if (ret)
-		free_irq(i2c_dev->irq, i2c_dev);
 
 	return ret;
 }
@@ -314,7 +312,6 @@ static int bcm2835_i2c_remove(struct platform_device *pdev)
 {
 	struct bcm2835_i2c_dev *i2c_dev = platform_get_drvdata(pdev);
 
-	free_irq(i2c_dev->irq, i2c_dev);
 	i2c_del_adapter(&i2c_dev->adapter);
 
 	return 0;
-- 
1.7.10.4
