From: Daniel Drake <dsd-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Subject: [PATCH v2] i2c-pxa: prepare clock before use
Date: Mon, 17 Jun 2013 11:30:36 -0400 (EDT)
Message-ID: <20130617153036.67CC84375@dev.laptop.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On OLPC XO-1.75 (MMP2), a WARN_ON() was occurring during boot
since the clock being enabled by i2c-pxa had not been prepared.

Use clk_prepare_enable() to ensure that the prepare operation
has taken place, and use clk_disable_unprepare() in the matching
shutdown paths.

Signed-off-by: Daniel Drake <dsd-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
---
 drivers/i2c/busses/i2c-pxa.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

v2: add the "other half" - thanks Wolfram!

diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index ea6d45d..fbafed2 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -1160,7 +1160,7 @@ static int i2c_pxa_probe(struct platform_device *dev)
 		i2c->adap.class = plat->class;
 	}
 
-	clk_enable(i2c->clk);
+	clk_prepare_enable(i2c->clk);
 
 	if (i2c->use_pio) {
 		i2c->adap.algo = &i2c_pxa_pio_algorithm;
@@ -1202,7 +1202,7 @@ eadapt:
 	if (!i2c->use_pio)
 		free_irq(irq, i2c);
 ereqirq:
-	clk_disable(i2c->clk);
+	clk_disable_unprepare(i2c->clk);
 	iounmap(i2c->reg_base);
 eremap:
 	clk_put(i2c->clk);
@@ -1221,7 +1221,7 @@ static int i2c_pxa_remove(struct platform_device *dev)
 	if (!i2c->use_pio)
 		free_irq(i2c->irq, i2c);
 
-	clk_disable(i2c->clk);
+	clk_disable_unprepare(i2c->clk);
 	clk_put(i2c->clk);
 
 	iounmap(i2c->reg_base);
-- 
1.8.1.4
