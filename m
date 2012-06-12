From: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Subject: [PATCH 2/2] i2c: stu300: use devm allocation
Date: Tue, 12 Jun 2012 19:33:37 +0200
Message-ID: <1339522417-606-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Allocate memory for device state using devm_kzalloc() to
simplify accounting.

Signed-off-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/i2c/busses/i2c-stu300.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-stu300.c b/drivers/i2c/busses/i2c-stu300.c
index 79b7851..e5c10c5 100644
--- a/drivers/i2c/busses/i2c-stu300.c
+++ b/drivers/i2c/busses/i2c-stu300.c
@@ -873,7 +873,7 @@ stu300_probe(struct platform_device *pdev)
 	int ret = 0;
 	char clk_name[] = "I2C0";
 
-	dev = kzalloc(sizeof(struct stu300_dev), GFP_KERNEL);
+	dev = devm_kzalloc(&pdev->dev, sizeof(struct stu300_dev), GFP_KERNEL);
 	if (!dev) {
 		dev_err(&pdev->dev, "could not allocate device struct\n");
 		ret = -ENOMEM;
@@ -971,7 +971,6 @@ stu300_probe(struct platform_device *pdev)
  err_no_resource:
 	clk_put(dev->clk);
  err_no_clk:
-	kfree(dev);
  err_no_devmem:
 	dev_err(&pdev->dev, "failed to add " NAME " adapter: %d\n",
 		pdev->id);
@@ -1020,7 +1019,6 @@ stu300_remove(struct platform_device *pdev)
 	clk_unprepare(dev->clk);
 	clk_put(dev->clk);
 	platform_set_drvdata(pdev, NULL);
-	kfree(dev);
 	return 0;
 }
 
-- 
1.7.9.2
