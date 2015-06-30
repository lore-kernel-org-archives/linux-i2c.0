From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] i2c: xgene-slimpro: Fix missing mbox_free_channel call in
 probe error path
Date: Tue, 30 Jun 2015 11:08:46 +0800
Message-ID: <1435633726.14315.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Feng Kan <fkan-qTEPVZfXA3Y@public.gmane.org>, Hieu Le <hnle-qTEPVZfXA3Y@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Free requested mailbox channel before return error.

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/i2c/busses/i2c-xgene-slimpro.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-xgene-slimpro.c b/drivers/i2c/busses/i2c-xgene-slimpro.c
index dcca707..1c9cb65a 100644
--- a/drivers/i2c/busses/i2c-xgene-slimpro.c
+++ b/drivers/i2c/busses/i2c-xgene-slimpro.c
@@ -419,6 +419,7 @@ static int xgene_slimpro_i2c_probe(struct platform_device *pdev)
 	rc = i2c_add_adapter(adapter);
 	if (rc) {
 		dev_err(&pdev->dev, "Adapter registeration failed\n");
+		mbox_free_channel(ctx->mbox_chan);
 		return rc;
 	}
 
-- 
2.1.0
