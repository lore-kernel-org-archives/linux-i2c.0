From: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Subject: [PATCH] i2c: i2c-ocores: Use devm_request_and_ioremap()
Date: Wed,  8 Aug 2012 08:54:32 +0200
Message-ID: <1344408872-1051-1-git-send-email-thierry.reding@avionic-design.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
Cc: "Jean Delvare (PC drivers, core)" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "Wolfram Sang (embedded platforms)" <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Replacing the devm_request_mem_region() and devm_ioremap_nocache() calls
by a single call to devm_request_and_ioremap() simplifies the code.

Signed-off-by: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
---
 drivers/i2c/busses/i2c-ocores.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
index bffd550..1fad4ae 100644
--- a/drivers/i2c/busses/i2c-ocores.c
+++ b/drivers/i2c/busses/i2c-ocores.c
@@ -283,18 +283,9 @@ static int __devinit ocores_i2c_probe(struct platform_device *pdev)
 	if (!i2c)
 		return -ENOMEM;
 
-	if (!devm_request_mem_region(&pdev->dev, res->start,
-				     resource_size(res), pdev->name)) {
-		dev_err(&pdev->dev, "Memory region busy\n");
-		return -EBUSY;
-	}
-
-	i2c->base = devm_ioremap_nocache(&pdev->dev, res->start,
-					 resource_size(res));
-	if (!i2c->base) {
-		dev_err(&pdev->dev, "Unable to map registers\n");
-		return -EIO;
-	}
+	i2c->base = devm_request_and_ioremap(&pdev->dev, res);
+	if (!i2c->base)
+		return -EADDRNOTAVAIL;
 
 	pdata = pdev->dev.platform_data;
 	if (pdata) {
-- 
1.7.11.4
