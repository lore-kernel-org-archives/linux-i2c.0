From: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Subject: [PATCH 1/2] i2c: stu300: use clk_prepare/unprepare
Date: Tue, 12 Jun 2012 19:33:30 +0200
Message-ID: <1339522410-570-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Make sure we prepare/unprepare the clock for the ST U300
I2C driver as is required by the clk API especially if you
use common clock.

Signed-off-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/i2c/busses/i2c-stu300.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-stu300.c b/drivers/i2c/busses/i2c-stu300.c
index 4d44af1..79b7851 100644
--- a/drivers/i2c/busses/i2c-stu300.c
+++ b/drivers/i2c/busses/i2c-stu300.c
@@ -924,7 +924,7 @@ stu300_probe(struct platform_device *pdev)
 
 	dev->speed = scl_frequency;
 
-	clk_enable(dev->clk);
+	clk_prepare_enable(dev->clk);
 	ret = stu300_init_hw(dev);
 	clk_disable(dev->clk);
 
@@ -960,6 +960,7 @@ stu300_probe(struct platform_device *pdev)
 
  err_add_adapter:
  err_init_hw:
+	clk_unprepare(dev->clk);
 	free_irq(dev->irq, dev);
  err_no_irq:
 	iounmap(dev->virtbase);
@@ -1016,6 +1017,7 @@ stu300_remove(struct platform_device *pdev)
 	free_irq(dev->irq, dev);
 	iounmap(dev->virtbase);
 	release_mem_region(dev->phybase, dev->physize);
+	clk_unprepare(dev->clk);
 	clk_put(dev->clk);
 	platform_set_drvdata(pdev, NULL);
 	kfree(dev);
-- 
1.7.9.2
