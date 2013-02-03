From: Peter Huewe <peterhuewe@gmx.de>
Subject: [PATCH] i2c/i2c-mxs: use devm_request_and_ioremap
Date: Sun,  3 Feb 2013 01:14:57 +0100
Message-ID: <1359850497-927-1-git-send-email-peterhuewe@gmx.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: ben-linux@fluff.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>
List-Id: linux-i2c@vger.kernel.org

Replace a call to devm_request_mem_region followed by a call to
dev_ioremap_nocache with devm_request_and_ioremap which does the same.
And since res_size isn't needed anymore we can remove it as well.

Found with coccicheck and this semantic patch:
 scripts/coccinelle/api/devm_request_and_ioremap.cocci.

Signed-off-by: Peter Huewe <peterhuewe@gmx.de>
---
 drivers/i2c/busses/i2c-mxs.c |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
index d6abaf2..4ca92b6 100644
--- a/drivers/i2c/busses/i2c-mxs.c
+++ b/drivers/i2c/busses/i2c-mxs.c
@@ -439,7 +439,6 @@ static int mxs_i2c_probe(struct platform_device *pdev)
 	struct i2c_adapter *adap;
 	struct pinctrl *pinctrl;
 	struct resource *res;
-	resource_size_t res_size;
 	int err, irq, dmairq;
 	dma_cap_mask_t mask;
 
@@ -458,11 +457,7 @@ static int mxs_i2c_probe(struct platform_device *pdev)
 	if (!res || irq < 0 || dmairq < 0)
 		return -ENOENT;
 
-	res_size = resource_size(res);
-	if (!devm_request_mem_region(dev, res->start, res_size, res->name))
-		return -EBUSY;
-
-	i2c->regs = devm_ioremap_nocache(dev, res->start, res_size);
+	i2c->regs = devm_request_and_ioremap(dev, res);
 	if (!i2c->regs)
 		return -EBUSY;
 
-- 
1.7.8.6
