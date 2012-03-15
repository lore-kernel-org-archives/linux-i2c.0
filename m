From: Philipp Zabel <philipp.zabel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] i2c: Add clk_prepare/clk_unprepare calls to i2c-pxa
Date: Thu, 15 Mar 2012 19:18:25 +0100
Message-ID: <1331835505.14662.10.camel@flow>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Haojian Zhuang <haojian.zhuang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

This patch adds clk_prepare/clk_unprepare calls to the i2c-pxa
driver by using the helper functions clk_prepare_enable and
clk_disable_unprepare.

Signed-off-by: Philipp Zabel <philipp.zabel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Haojian Zhuang <haojian.zhuang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Cc: Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-pxa.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index d603646..950b76c 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -42,8 +42,10 @@
 #ifndef CONFIG_HAVE_CLK
 #define clk_get(dev, id)	NULL
 #define clk_put(clk)		do { } while (0)
+#define clk_prepare_enable(clk)	do { } while (0)
 #define clk_disable(clk)	do { } while (0)
 #define clk_enable(clk)		do { } while (0)
+#define clk_disable_unprepare(clk) do { } while (0)
 #endif
 
 struct pxa_reg_layout {
@@ -1116,7 +1118,7 @@ static int i2c_pxa_probe(struct platform_device *dev)
 	}
 #endif
 
-	clk_enable(i2c->clk);
+	clk_prepare_enable(i2c->clk);
 
 	if (plat) {
 		i2c->adap.class = plat->class;
@@ -1164,7 +1166,7 @@ eadapt:
 	if (!i2c->use_pio)
 		free_irq(irq, i2c);
 ereqirq:
-	clk_disable(i2c->clk);
+	clk_disable_unprepare(i2c->clk);
 	iounmap(i2c->reg_base);
 eremap:
 	clk_put(i2c->clk);
@@ -1185,7 +1187,7 @@ static int __exit i2c_pxa_remove(struct platform_device *dev)
 	if (!i2c->use_pio)
 		free_irq(i2c->irq, i2c);
 
-	clk_disable(i2c->clk);
+	clk_disable_unprepare(i2c->clk);
 	clk_put(i2c->clk);
 
 	iounmap(i2c->reg_base);
-- 
1.7.9.1
