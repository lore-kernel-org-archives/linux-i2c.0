From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: [PATCH] i2c: i2c-arb-gpio-challenge: use deferred probe when adapter not found
Date: Thu, 10 Oct 2013 10:25:59 +0200
Message-ID: <1381393663-17511-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Simon Glass <sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

If it is not there yet, it might appear later.

Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
---
 drivers/i2c/muxes/i2c-arb-gpio-challenge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/muxes/i2c-arb-gpio-challenge.c b/drivers/i2c/muxes/i2c-arb-gpio-challenge.c
index 74b41ae..928656e 100644
--- a/drivers/i2c/muxes/i2c-arb-gpio-challenge.c
+++ b/drivers/i2c/muxes/i2c-arb-gpio-challenge.c
@@ -200,7 +200,7 @@ static int i2c_arbitrator_probe(struct platform_device *pdev)
 	arb->parent = of_find_i2c_adapter_by_node(parent_np);
 	if (!arb->parent) {
 		dev_err(dev, "Cannot find parent bus\n");
-		return -EINVAL;
+		return -EPROBE_DEFER;
 	}
 
 	/* Actually add the mux adapter */
-- 
1.8.4.rc3
