From: Daniel Drake <dsd-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Subject: [PATCH] i2c-pxa: prepare clock before use
Date: Thu, 13 Jun 2013 15:24:57 -0400 (EDT)
Message-ID: <20130613192457.51006FAACE@dev.laptop.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On OLPC XO-1.75 (MMP2), a WARN_ON() was occurring during boot
since the clock being enabled by i2c-pxa had not been prepared.

Use clk_prepare_enable() to ensure that the prepare operation
has taken place.

Signed-off-by: Daniel Drake <dsd-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
---
 drivers/i2c/busses/i2c-pxa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index ea6d45d..ef307ea 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -1160,7 +1160,7 @@ static int i2c_pxa_probe(struct platform_device *dev)
 		i2c->adap.class = plat->class;
 	}
 
-	clk_enable(i2c->clk);
+	clk_prepare_enable(i2c->clk);
 
 	if (i2c->use_pio) {
 		i2c->adap.algo = &i2c_pxa_pio_algorithm;
-- 
1.8.1.4
