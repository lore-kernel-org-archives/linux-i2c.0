From: Boris BREZILLON <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v2] i2c: sun6-p2wi: fix call to snprintf
Date: Fri, 13 Jun 2014 12:23:48 +0200
Message-ID: <1402655028-6214-1-git-send-email-boris.brezillon@free-electrons.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kees Cook <keescook-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Fengguang Wu <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Shuge <shuge-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org>, kevin-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Boris BREZILLON <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Fixes possible issue in case pdev name contains formatting characters.

Signed-off-by: Boris BREZILLON <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Reported-by: Kees Cook <keescook-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
---
Changes since v1:
- use strlcpy instead of snprintf

 drivers/i2c/busses/i2c-sun6i-p2wi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-sun6i-p2wi.c b/drivers/i2c/busses/i2c-sun6i-p2wi.c
index 5d2d678..09de4fd 100644
--- a/drivers/i2c/busses/i2c-sun6i-p2wi.c
+++ b/drivers/i2c/busses/i2c-sun6i-p2wi.c
@@ -237,7 +237,7 @@ static int p2wi_probe(struct platform_device *pdev)
 	if (IS_ERR(p2wi->regs))
 		return PTR_ERR(p2wi->regs);
 
-	snprintf(p2wi->adapter.name, sizeof(p2wi->adapter.name), pdev->name);
+	strlcpy(p2wi->adapter.name, pdev->name, sizeof(p2wi->adapter.name));
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		dev_err(dev, "failed to retrieve irq: %d\n", irq);
-- 
1.8.3.2
