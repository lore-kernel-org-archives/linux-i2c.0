From: Chao Xie <xiechao.mail-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] i2c: pxa: fix the clock APIs
Date: Tue, 31 Jul 2012 14:33:04 +0800
Message-ID: <1343716384-6609-1-git-send-email-xiechao.mail@gmail.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Chao Xie <chao.xie-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Chao Xie <xiechao.mail-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Chao Xie <chao.xie-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>

Signed-off-by: Chao Xie <xiechao.mail-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/busses/i2c-pxa.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index a997c7d..0a57f3e 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -44,8 +44,8 @@
 #ifndef CONFIG_HAVE_CLK
 #define clk_get(dev, id)	NULL
 #define clk_put(clk)		do { } while (0)
-#define clk_disable(clk)	do { } while (0)
-#define clk_enable(clk)		do { } while (0)
+#define clk_disable_unprepare(clk)	do { } while (0)
+#define clk_prepare_enable(clk)		do { } while (0)
 #endif
 
 struct pxa_reg_layout {
@@ -1169,7 +1169,7 @@ static int i2c_pxa_probe(struct platform_device *dev)
 		i2c->adap.class = plat->class;
 	}
 
-	clk_enable(i2c->clk);
+	clk_prepare_enable(i2c->clk);
 
 	if (i2c->use_pio) {
 		i2c->adap.algo = &i2c_pxa_pio_algorithm;
@@ -1211,7 +1211,7 @@ eadapt:
 	if (!i2c->use_pio)
 		free_irq(irq, i2c);
 ereqirq:
-	clk_disable(i2c->clk);
+	clk_disable_unprepare(i2c->clk);
 	iounmap(i2c->reg_base);
 eremap:
 	clk_put(i2c->clk);
@@ -1232,7 +1232,7 @@ static int __exit i2c_pxa_remove(struct platform_device *dev)
 	if (!i2c->use_pio)
 		free_irq(i2c->irq, i2c);
 
-	clk_disable(i2c->clk);
+	clk_disable_unprepare(i2c->clk);
 	clk_put(i2c->clk);
 
 	iounmap(i2c->reg_base);
@@ -1248,7 +1248,7 @@ static int i2c_pxa_suspend_noirq(struct device *dev)
 	struct platform_device *pdev = to_platform_device(dev);
 	struct pxa_i2c *i2c = platform_get_drvdata(pdev);
 
-	clk_disable(i2c->clk);
+	clk_disable_unprepare(i2c->clk);
 
 	return 0;
 }
@@ -1258,7 +1258,7 @@ static int i2c_pxa_resume_noirq(struct device *dev)
 	struct platform_device *pdev = to_platform_device(dev);
 	struct pxa_i2c *i2c = platform_get_drvdata(pdev);
 
-	clk_enable(i2c->clk);
+	clk_prepare_enable(i2c->clk);
 	i2c_pxa_reset(i2c);
 
 	return 0;
-- 
1.7.0.4
