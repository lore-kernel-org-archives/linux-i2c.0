From: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Subject: [PATCH 2/4] i2c-nomadik: dynamic clocking
Date: Thu, 23 Sep 2010 09:03:55 +0200
Message-ID: <1285225435-985-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, Sundar R Iyer <sundar.iyer-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

This makes sure the Nomadik I2C bus driver silicon is only clocked
when really needed, saving some microamps here and there when
there is no I2C traffic.

Acked-by: Srinidhi Kasagar <srinidhi.kasagar-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Signed-off-by: Sundar R Iyer <sundar.iyer-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Signed-off-by: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
---
 drivers/i2c/busses/i2c-nomadik.c |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
index a73c057..b2dbf7c 100644
--- a/drivers/i2c/busses/i2c-nomadik.c
+++ b/drivers/i2c/busses/i2c-nomadik.c
@@ -250,6 +250,8 @@ static int init_hw(struct nmk_i2c_dev *dev)
 {
 	int stat;
 
+	clk_enable(dev->clk);
+
 	stat = flush_i2c_fifo(dev);
 	if (stat)
 		return stat;
@@ -263,6 +265,8 @@ static int init_hw(struct nmk_i2c_dev *dev)
 
 	dev->cli.operation = I2C_NO_OPERATION;
 
+	clk_disable(dev->clk);
+
 	return 0;
 }
 
@@ -558,6 +562,8 @@ static int nmk_i2c_xfer(struct i2c_adapter *i2c_adap,
 	if (status)
 		return status;
 
+	clk_enable(dev->clk);
+
 	/* setup the i2c controller */
 	setup_i2c_controller(dev);
 
@@ -590,10 +596,13 @@ static int nmk_i2c_xfer(struct i2c_adapter *i2c_adap,
 			dev_err(&dev->pdev->dev, "%s\n",
 				cause >= ARRAY_SIZE(abort_causes)
 				? "unknown reason" : abort_causes[cause]);
+			clk_disable(dev->clk);
 			return status;
 		}
 		mdelay(1);
 	}
+	clk_disable(dev->clk);
+
 	/* return the no. messages processed */
 	if (status)
 		return status;
@@ -857,8 +866,6 @@ static int __devinit nmk_i2c_probe(struct platform_device *pdev)
 		goto err_no_clk;
 	}
 
-	clk_enable(dev->clk);
-
 	adap = &dev->adap;
 	adap->dev.parent = &pdev->dev;
 	adap->owner	= THIS_MODULE;
@@ -895,7 +902,6 @@ static int __devinit nmk_i2c_probe(struct platform_device *pdev)
 	return 0;
 
  err_init_hw:
-	clk_disable(dev->clk);
  err_add_adap:
 	clk_put(dev->clk);
  err_no_clk:
@@ -928,7 +934,6 @@ static int __devexit nmk_i2c_remove(struct platform_device *pdev)
 	iounmap(dev->virtbase);
 	if (res)
 		release_mem_region(res->start, resource_size(res));
-	clk_disable(dev->clk);
 	clk_put(dev->clk);
 	platform_set_drvdata(pdev, NULL);
 	kfree(dev);
-- 
1.6.3.3
