From: Feng Kan <fkan-qTEPVZfXA3Y@public.gmane.org>
Subject: [PATCH] i2c: busses: xgene-slimpro: fix incorrect __init declation for probe
Date: Tue,  2 Jun 2015 16:43:09 -0700
Message-ID: <1433288589-10794-1-git-send-email-fkan@apm.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, patches-qTEPVZfXA3Y@public.gmane.org
Cc: Feng Kan <fkan-qTEPVZfXA3Y@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Fix section mismatch error during kernel build for xgene_slimpro_i2c_probe
function. It was incorrectly defined with __init declaration.

Signed-off-by: Feng Kan <fkan-qTEPVZfXA3Y@public.gmane.org>
---
 drivers/i2c/busses/i2c-xgene-slimpro.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-xgene-slimpro.c b/drivers/i2c/busses/i2c-xgene-slimpro.c
index 0b33aa2e..dcca707 100644
--- a/drivers/i2c/busses/i2c-xgene-slimpro.c
+++ b/drivers/i2c/busses/i2c-xgene-slimpro.c
@@ -377,7 +377,7 @@ static struct i2c_algorithm xgene_slimpro_i2c_algorithm = {
 	.functionality = xgene_slimpro_i2c_func,
 };
 
-static int __init xgene_slimpro_i2c_probe(struct platform_device *pdev)
+static int xgene_slimpro_i2c_probe(struct platform_device *pdev)
 {
 	struct slimpro_i2c_dev *ctx;
 	struct i2c_adapter *adapter;
-- 
1.9.1
